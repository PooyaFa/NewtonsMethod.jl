module NewtonsMethod

greet() = print("Hello World!")

using LinearAlgebra, ForwardDiff

function fixedpointmap(f, f_prime, x_0; tolerance=1E-7, maxiter=1000)
    normdiff = Inf
    iter = 1
    while normdiff > tolerance && iter <= maxiter
        x_new = x_0 - f(x_0)/f_prime(x_0) # use the passed in map
        if norm(x_new - x_0) > tolerance && iter > 100
            println("non-convergence ")
            return
        end
        normdiff = norm(x_new - x_0)
        x_0 = x_new
        iter = iter + 1
    end
    return (value = x_0, normdiff=normdiff, iter=iter) # A named tuple
end


D(f) = x -> ForwardDiff.derivative(f, x)
function fixedpointmap(f, x_0; tolerance=1E-7, maxiter=1000)
    f_prime = D(f)
    x_0, normdiff, iter = fixedpointmap(f, f_prime, x_0)
    return (value = x_0, normdiff=normdiff, iter=iter)
end

export fixedpointmap

end # module
