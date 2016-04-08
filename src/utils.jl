" Return free symbols in an expression as a `Set`"
function free_symbols(ex::Basic)
    syms = CSetBasic()
    ccall((:basic_free_symbols, :libsymengine), Void, (Ptr{Basic}, Ptr{Void}), &ex, syms.ptr)
    convert(Vector, syms)
end
free_symbols(ex::BasicType) = free_symbols(Basic(ex))
flat(A) = mapreduce(x->isa(x,Array)? flat(x): x, vcat, Basic[], A)
free_symbols{T<:SymbolicType}(exs::Array{T})  = unique(flat([free_symbols(ex) for ex in exs]))
free_symbols(exs::Tuple) =  unique(flat([free_symbols(ex) for ex in exs]))

"Return arguments of a function call as a vector of `Basic` objects"
function get_args(ex::Basic)
    args = CVecBasic()
    ccall((:basic_get_args, :libsymengine), Void, (Ptr{Basic}, Ptr{Void}), &ex, args.ptr)
    convert(Vector, args)
end


#Base.hash(ex::Basic) = ccall((:basic_hash, :libsymengine), UInt, (Ptr{Basic}, ), &ex)
