using LVServer
using Test

@testset "LVServer.jl" begin
    # Write your tests here.

    # Here are the tests:
    @test LVServer.tmp_test(0) == 0
    @test LVServer.tmp_test(3) == 3
    @test LVServer.tmp_test(5) == 5
end
