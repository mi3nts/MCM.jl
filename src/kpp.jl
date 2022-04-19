# see parse_equation_file.py in PyBox
"""
    convert_rate_mcm(rate_string::String)

Convert an MCM rate expression to a valid Julia expression we can evaluate after defining necessary constants.
"""
function convert_rate_mcm(rate_string::String)
    math_dict = Dict("dabs"=>"abs",
                     "dsqrt"=>"sqrt",
                     "dlog"=>"log",
                     "LOG"=>"log",
                     "EXP"=>"exp",
                     "TEMP"=>"temp"  # <-- we need this to help distinguishing between TEMP and M
                     )
    map_dict = Dict("D-"=>"E-",
                    "D+"=>"E+",
                    "**"=>"^",
                    )
    # loop through dictionaries and replace functions with Julia equivalents

    for (operation_f, operation_jl) ∈ math_dict
        rate_string = replace(rate_string, operation_f => operation_jl)
    end

    for (syntax_f, syntax_jl) ∈ map_dict
        rate_string = replace(rate_string, syntax_f => syntax_jl)
    end


    # replace J(...) with J[...]
    if occursin("J", rate_string)
        idx = findfirst("J(", rate_string)
        idx_lparens = idx[2]
        idx_rparens = idx_lparens +(findfirst(")", rate_string[idx_lparens:end])[1]-1)
        rate_array = collect(rate_string)
        rate_array[idx_lparens] = '['
        rate_array[idx_rparens] = ']'
        rate_string = join(rate_array)
    end



    return rate_string

end






"""
    extract_mechanism(filename::String)

Reach the mechaism equation file, extracting the reaction strings and rate coefficients for later ingestion into Catalyst.jl
"""
function extract_mechanism(filename::String)
    lines = readlines(filename)

    # find index of line that specifies equations
    idx = last(findall(x->occursin(x, "#EQUATIONS"), lines))

    # loop through reactions and generate tuples of (eq#, equations, rate)
    species_list = []  # we will want this for generating the variables
    rxns = []
    for i ∈(idx+1):length(lines)

        # 1. split into reaction part and rate part
        rxn_line, rate_line = split(lines[i], ":")

        # 2. split reaction into the eq# and eq
        eqnum, eqn = split(rxn_line, "}")
        eqnum = parse(Int, eqnum[2:end-1]) # drop { and .

        # 3. grab the rate equation
        rate = split(rate_line, ";")[1]
        rate = replace(rate, " "=>"")
        rate = convert_rate_mcm(rate)

        # 4. split eqn into reactants and products
        reactant_string, product_string = split(eqn, "=")

        # 5. generate reactants list
        reactant_string = replace(reactant_string, " "=>"")


        reactants = []
        reactants_stoich = []
        reactant_list = split(reactant_string, "+")
        if reactant_string == ""
            push!(reactants, nothing)
            push!(reactants_stoich, 1.0)
        else
            for reactant ∈ reactant_list
                idx = findfirst(isletter.(collect(reactant)))
                if idx == 1
                    stoich = 1.0
                    species = reactant
                else
                    stoich = parse(Float32, reactant[1:idx-1])
                    species = reactant[idx:end]
                end

                push!(reactants, species)
                push!(reactants_stoich, stoich)
            end
        end

        # 6. generate products list
        product_string = replace(product_string, " "=>"")


        products = []
        products_stoich = []
        product_list = split(product_string, "+")
        if product_string == ""
            push!(products, nothing)
            push!(products_stoich, 1.0)
        else
            for product ∈ product_list
                idx = findfirst(isletter.(collect(product)))
                if idx == 1
                    stoich = 1.0
                    species = product
                else
                    stoich = parse(Float32, product[1:idx-1])
                    species = product[idx:end]
                end


                push!(products, species)
                push!(products_stoich, stoich)
            end
        end


        push!(species_list, reactants)
        push!(species_list, products)

        push!(rxns, (eqnum, reactants, reactants_stoich, products, products_stoich, rate))
    end

    # trim up the species list and return unique elements
    species_list = vcat(species_list...)
    species_list = species_list[species_list .!= nothing]


    return rxns, string.(unique!(species_list))
end




"""
    evaluate_rate(rate::String)

Evaluate the MCM reaction rate using simulation parameters.
"""
function evaluate_rate(rate::String)

    # println(rate)

    # do everything and then do M last
    for (key, val) ∈ config
        if key != "M"
            if occursin(key, rate)
                rate = replace(rate, key=>string(val))
                # println("\t", key, "\t", rate)
            end
        end
    end

    if occursin("M", rate)
        rate = replace(rate, "M"=>string(config["M"]))
        # println("\t", "M", "\t", rate)

    end

    # println("\tFINISHED")

    res = eval(Meta.parse(rate))
    # println("\t", res)

    return res
end




"""
    mechanism_to_catalyst(rxns, species_list, out_file, rn_name)

Take the output of extract_mechanism() and generate a julia file called out_file defining a reaction network called rn_name using the Catalyst.jl DSL.

"""
function mechanism_to_catalyst(rxns, species_list, out_file::String, rn_name::String)
    println(out_file)

    open(out_file, "w") do f
        write(f, "using Catalyst\n\n")


        # generate variable list
        species_as_variables = ["$(species)(t)" for species ∈ species_list]
        varlist = join(species_as_variables, " ")
        write(f, "@variables t "*varlist*"\n\n")


        # ------------------- this should probably be some kind of struct



        # write first line of @reaction_network
        write(f, "$(rn_name) = @reaction_network begin\n")

        # loop through reactions and add them
        for rxn ∈ rxns
            num, reactants, reactants_stoich, products, products_stoich, rate = rxn

            # replace nothing with ∅
            replace!(reactants, nothing => "∅")
            replace!(products, nothing => "∅")

            rate_real = evaluate_rate(rate)



            REACTANTS = join([string(reactants_stoich[i])*"*"*reactants[i] for i∈1:length(reactants)], "+")
            PRODUCTS = join([string(products_stoich[i])*"*"*products[i] for i∈1:length(products)], "+")

            eqn = REACTANTS * " ⟶ " * PRODUCTS

            write(f, "\t$(rate_real), $(eqn)\n")
        end


        # finish reaction newtork
        write(f, "end\n")
    end
end





export extract_mechanism
export mechanism_to_catalyst
export convert_rate_mcm
export evaluate_rate
