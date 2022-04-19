using MCM
using Catalyst
using Test




@testset "MCM Parsing" begin
    @variables t, A(t), B(t), C(t)

    test_file = "./test.kpp"
    out_file = "./test.jl"

    rxns, species_list = extract_mechanism(test_file)
    mechanism_to_catalyst(rxns, species_list, out_file, "test_rn")

    include(out_file)

    rn_test = @reaction_network begin
        1.0, A + B → C
    end

    rx_a = reactions(test_rn)
    a_rx = reactions(rn_test)

    @test rx_a == a_rx





end






# @testset "MCM.jl" begin
#     # Write your tests here.
# end
