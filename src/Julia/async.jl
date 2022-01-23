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
    id = @spawn f(; kwargs...)
    push!(tasks, ticket=>id)
    return (;ticket)
end

function checkjob(; ticket)
    global tasks
    id = tasks[ticket]
    done = istaskdone(id)
    if !done
        println("patience!")
        return (; done)
    else
        rslt = fetch(id)
        @show rslt
        pop!(d, ticket)
        return (; done, rslt)
    end
end

asyncfunctions = (; checkjob)
