import Base.Threads.@spawn

# untested
mutable struct Tasks
    d::Dict{Int, Any}
    c::Int # counter
end

const tasks = Dict{Int, Any}()

function getticket(tasks)
    return tasks.c += 1
end

function asyncall(f; kwargs...)
    global tasks
    ticket = getticket(tasks)
    id = @spawn f(; kwargs...)
    push!(tasks.d, ticket=>id)
    return (;ticket)
end

function checkjob(; ticket)
    global tasks
    id = tasks.d[ticket]
    done = istaskdone(id)
    if !done
        return (; done)
    else
        result = fetch(id)
        pop!(tasks.d, ticket)
        return (; done, result)
    end
end

asyncfunctions = (; checkjob)
