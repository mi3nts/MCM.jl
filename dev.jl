using MCM


test_file = "./data/mcm_3-2_kpp_complete.kpp"
isfile(test_file)

out_file = "./data/mcm_3-2.jl"
isfile(out_file)


# 1. Read in mechanism
rxns, species_list = extract_mechanism(test_file)

# for rxn ∈ rxns
#     println("Rxn: $(rxn[1]),  Rate: $(rxn[6])")
# end


# 2. Generate ReactionNetwork file
mechanism_to_catalyst(rxns, species_list, out_file, "test_rn")


# 3. Load in reaction network
include(out_file)


# 4. Visualize
g = Graph(test_rn)
display(g)
savegraph(g, "./output/mcm_3-2_complete.png")


