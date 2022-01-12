
function reorder_bytes(bvec::T, elsize) where T<:AbstractVector{I} where I<:Union{UInt8,Int8}
    l = length(bvec)
    h = Int(l//elsize)
    m = reshape(bvec, elsize, h)
    m1 = @view m[end:-1:begin, :]
    return reshape(m1, l)
end

function reorder_bytes(vc::T) where T<:AbstractArray{N} where N<:Number
    elsize = sizeof(eltype(vc))
    l = length(vc)
    v = vec(vc)
    s = elsize * l
    bvec = reinterpret(UInt8, v)
    return reorder_bytes(bvec, elsize)
    # m = reshape(bvec, elsize, l)
    # m1 = @view m[end:-1:begin, :]
    # return reshape(m1, s)
end


rb = reorder_bytes
