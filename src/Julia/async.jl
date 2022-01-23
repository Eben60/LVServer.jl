import Base.Threads.@spawn

const tasks = Dict{Int, Any}()

function getticket()
    global tasks
    if isempty(tasks)
        return 1
    else
        return maximum(keys(tasks)) +1
    end
end

function asyncall(f; kwargs...)
    global tasks
    ticket = getticket()
    id = id = @spawn f(; kwargs..)
    push!(tasks, ticket=>id)
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
