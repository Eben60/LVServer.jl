
function reorder_bytes(bvec::T, elsize) where T<:AbstractVector{I} where I<:Union{UInt8,Int8}
    l = length(bvec)
    h = Int(l//elsize)
    m = reshape(bvec, elsize, h)
    m1 = m[end:-1:begin, :]  # having @views result in a slow collect with a lot of allocations downstream
    return reshape(m1, l)
end

function reorder_bytes(vc::T) where T<:AbstractArray{N} where N<:Number
    elsize = sizeof(eltype(vc))
    l = length(vc)
    v = vec(vc)
    s = elsize * l
    bvec = reinterpret(UInt8, v)
    return reorder_bytes(bvec, elsize)
end

# function reorder_bytes_f(bvec::T, elsize) where T<:AbstractVector{I} where I<:Union{UInt8,Int8}
#     # bvec = copy(bvec)
#     l = length(bvec)
#     h = Int(l//elsize)
#     ix = 1
#     @simd for i in 1:h
#         bvec[ix:ix+elsize-1] = bvec[ix+elsize-1:-1:ix]
#         ix += elsize
#     end
#     return bvec
# end
#
# function reorder_bytes_f(vc::T) where T<:AbstractArray{N} where N<:Number
#     elsize = sizeof(eltype(vc))
#     l = length(vc)
#     v = vec(vc)
#     s = elsize * l
#     bvec = reinterpret(UInt8, v)
#     return reorder_bytes_f(bvec, elsize)
# end
# takes much longer

rb = reorder_bytes
# rbf = reorder_bytes_f
