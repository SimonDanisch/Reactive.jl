# `record` takes a rollback Signal{Int} and a Signal{T} to record,
# when the rollback signal updates to X, the returned signal will
# hold the Xth previous value held by the signal being recorded

export record

function record(n, rollback, signal; memory=fill(value(signal), n))
    @assert length(memory) >= n

    mem = lift(x -> push!(memory, x), signal)
    rec = lift(x -> memory[end-x], rollback)
    merge(rec, keepwhen(lift(y -> y == 0, rollback), 0, signal))
end
