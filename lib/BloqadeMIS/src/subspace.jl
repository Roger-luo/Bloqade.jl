"""
    independent_set_subspace(graph)

Create a subspace from given graph's maximal independent set.
"""
function independent_set_subspace(graph::SimpleGraph)
    if isempty(edges(graph))
        @warn "graph has empty edges, creating a subspace contains the entire fullspace, consider using a full space register."
    end

    cg = complement(graph)
    mis = maximal_cliques(cg)
    n = nv(graph)
    return create_subspace_from_mis(n, mis)
end

"""
    create_subspace_from_mis(n::Int, mis::AbstractVector)

Create `Subspace` from given list of maximal cliques/maximal independent set.

# Arguments

- `n`: number of vertices of the graph.
- `mis`: the list of maximal independent set.
"""
function create_subspace_from_mis(n::Int, mis::AbstractVector)
    iterators = ThreadsX.map(mis) do each
        fixed_points = setdiff(1:n, each)
        locs = sort!(fixed_points)
        # copied from bsubspace to use runtime length
        masks, shift_len = group_shift(locs)
        len = 1 << (n - length(locs))
        return BitSubspace(n, len, length(masks), masks, shift_len)
    end

    # NOTE: ThreadsX doesn't support auto init when using union as op
    # need the following PR merged
    # https://github.com/JuliaFolds/InitialValues.jl/pull/60
    subspace_v = ThreadsX.reduce(union, iterators; init = OnInit(Vector{Int}))
    return Subspace(n, subspace_v)
end

"""
    blockade_subspace(atoms[, radius=1.0])

Create a blockade approximation subspace from given atom positions and radius.
"""
function blockade_subspace(atoms::AbstractVector, radius::AbstractFloat = 1.0)
    return independent_set_subspace(unit_disk_graph(atoms, radius))
end
