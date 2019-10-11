using NewtonsMethod
using Test

using Polynomials
@testset "NewtonsMethod.jl" begin
    @testset "root_of_a_known_function" begin
        f(x) = (x-1)^3
        f_prime(x) = 3*(x-1)^2
        root = 1
        @test root ≈ fixedpointmap(f, f_prime, 2).value #test with first method (f, f', x_0)
        @test root ≈ fixedpointmap(f, 2).value #test with second method (f, x_0)

        f(x) = (x-4)/x
        f_prime(x) = 4/(x^2)
        root = 4
        @test root ≈ fixedpointmap(f, f_prime, 2).value #test with first method (f, f', x_0)
        @test root ≈ fixedpointmap(f, 2).value #test with second method (f, x_0)

    end
    @testset "comparing with Polynomials.roots" begin
        #check the one of the roots of 2 - 5*x + 2*x^2 and comparing it with roots()
        p = Poly([2, -5, 2], :x)
        p′ = polyder(p)
        root = roots(p)
        @test any(root .≈ fixedpointmap(p, p′, 2).value) #test with first method (f, f', x_0)
        @test any(root .≈ fixedpointmap(p, 2).value) #test with second method (f, x_0)


        p = Poly([2, -5, 2, 10], :x)
        p′ = polyder(p)
        root = roots(p)
        @test any(root .≈ fixedpointmap(p, p′, 2).value) #test with first method (f, f', x_0)
        @test any(root .≈ fixedpointmap(p, 2).value) #test with second method (f, x_0)
    end

    @testset "testing BigFloat" begin
        #check the one of the roots of 2 - 5*x + 2*x^2 and comparing it with roots()
        f(x) = (x-1)^3
        f_prime(x) = 3*(x-1)^2
        root = 1.0
        @test root ≈ fixedpointmap(f, f_prime, BigFloat(2)).value #test with first method (f, f', x_0)
        @test root ≈ fixedpointmap(f, BigFloat(2)).value #test with second method (f, x_0)
    end

    @testset "testing non-convergence" begin
        #check the one of the roots of 2 - 5*x + 2*x^2 and comparing it with roots()
        f(x) = x^2 + 1
        f_prime(x) = 2*x
        @test nothing == fixedpointmap(f, f_prime, 2) #test with first method (f, f', x_0)
        @test nothing == fixedpointmap(f, 2) #test with second method (f, x_0)
    end

    @testset "maxiter is working" begin
        #check the one of the roots of 2 - 5*x + 2*x^2 and comparing it with roots()
        f(x) = (x-1)^3
        f_prime(x) = 3*(x-1)^2
        root = 1
        #if with maxiter = 2, we doesn't get the root, then the test will be passed: it means maxiter is working.
        @test_broken root ≈ fixedpointmap(f, f_prime, 2, maxiter = 2).value #test with first method (f, f', x_0)
        @test_broken root ≈ fixedpointmap(f, 2, maxiter = 2).value #test with second method (f, x_0)
    end
    @testset "tolerance is working" begin
        #check the one of the roots of 2 - 5*x + 2*x^2 and comparing it with roots()
        f(x) = (x-1)^3
        f_prime(x) = 3*(x-1)^2
        root = 1
        #if with tolerance = 1E-3, we doesn't get the root, then the test will be passed: it means maxiter is working.
        @test_broken root ≈ fixedpointmap(f, f_prime, 2, tolerance = 1E-3).value #test with first method (f, f', x_0)
        @test_broken root ≈ fixedpointmap(f, 2, tolerance = 1E-3).value #test with second method (f, x_0)
    end

end
