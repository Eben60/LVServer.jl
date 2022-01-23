import Base.Threads.@spawn

const tasks = Dict{Int, Any}()

function asyncall(f; kwargs...)
    global tasks
    if isempty(tasks)
        ticket = 1
    else
        ticket = maximum(keys(d)) +1
    end
    id = id = @spawn f(; kwargs..)
    push!(d, ticket=>id)
    return (;ticket)
end

function checkjob(ticket)
    global tasks
    id = tasks[ticket]
    done = istaskdone(id)
    if !done
        return (; done)
    else
        rslt = fetch(id)
        pop!(d, ticket)
        return (; done, rslt)
    end
end

asyncfunctions = (; checkjob)
