"""
    parse_mechanism(kpp_path::String)

Parse a chemical mechanism file (ending in .kpp), returning a list of reactions and a list of reaction rate constants.
"""
function parse_mechanism(kpp_path::String)
    data = read(kpp_path, String)

    # find the number of reactions in the mechanism
    re = r"\{(.*?)\}"
    m = findall(re, data)
    n_equations = size(m, 1)


    species_list = []
    rxns = []

    eqn_list = findall(r"\}(.*?)\;",data)  # find anything between } and ;

    # loop through reactions and generate tuples of (eq#, equations, rate)
    for equation_step ∈ 1:n_equations
        equation_full = data[eqn_list[equation_step]][2:end-1]
        equation_full = replace(equation_full, "\t"=>"")

        # 1. split into reaction part and rate part
        reaction = split(split(equation_full, ":")[1], "=")
        rate_equation = strip(split(equation_full, ":")[2])

        # 2. split reaction into reactants and products
        reactants_list = strip.(split(reaction[1], "+"))
        products_list = strip.(split(reaction[2], "+"))

        # 3. generate reactants lsit
        reactants = String[]
        reactants_stoich = Float64[]

        if reactants_list == ""
            push!(reactants, nothing)
            push!(reactants_stoich, 1.0)
        else
            for reactant ∈ reactants_list
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

        # 4. generate products list
        products = String[]
        products_stoich = Float64[]
        if products_list == ""
            push!(products, nothing)
            push!(products_stoich, 1.0)
        else
            for product ∈ products_list
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
        push!(rxns, (reactants, reactants_stoich, products, products_stoich, rate_equation))
    end

    # trim up the species list and return unique elements
    species_list = vcat(species_list...)
    species_list = species_list[species_list .!= nothing]

    return rxns, string.(unique!(species_list))
end
