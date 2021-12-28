using l_0mq_4Labview
using Test

@testset "l_0mq_4Labview.jl" begin
    # Write your tests here.

    # Here are the tests:
    @test l_0mq_4Labview.tmp_test(0) == 0
    @test l_0mq_4Labview.tmp_test(3) == 3
    @test l_0mq_4Labview.tmp_test(5) == 5
end
