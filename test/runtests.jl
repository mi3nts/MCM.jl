using MCM
using Test
using Unitful
using Dates

# @testset "MCM Parsing" begin
# end

@testset "photolysis.jl" begin
    @test MCM.J.L[1] ==  6.073e-5
    @test MCM.J.M[1] ==  1.743
    @test MCM.J.N[1] ==  0.474

    @test size(MCM.J.L) == (34,)
    @test size(MCM.J.M) == (34,)
    @test size(MCM.J.N) == (34,)
end


sim = SimulationConfig("test.txt",
                        25.0*u"°C",
                        0.5,
                        DateTime(2022, 9, 5, 12, 0, 0),
                        DateTime(2022, 9, 5, 16, 0, 0),
                        10.0*u"1/cm^3",
                        22.5*u"°",
                        95.3*u"°",
                        )

println(sim)
println(sim.temp)
