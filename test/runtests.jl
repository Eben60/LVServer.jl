using Jl_0mq_4Labview
using Test

@testset "Jl_0mq_4Labview.jl" begin
    # Write your tests here.

    # Here are the tests:
    @test Jl_0mq_4Labview.tmp_test(0) == 0
    @test Jl_0mq_4Labview.tmp_test(3) == 3
    @test Jl_0mq_4Labview.tmp_test(5) == 5
end
