module RydbergEmulator

using Random
using Printf
using Unitful
using BitBasis
using MLStyle
using UUIDs
using Adapt
using SparseArrays
using LuxurySparse
using Graphs
using LinearAlgebra
using OrderedCollections
using Configurations
using DelimitedFiles
using EliminateGraphs
using ProgressLogging
using Polyester
using StatsBase
using ThreadsX
using Transducers
using StaticArrays

import Yao
using Yao: measure, zero_state
using Unitful: Quantity, uconvert, MHz, µm, μs, ns
using Transducers: OnInit
using LinearAlgebra: BlasInt, BlasReal, BlasComplex

export RydInteract, RydAtom, XTerm, ZTerm, NTerm,
    Hamiltonian, DiscreteEmulationCache,
    RydbergReg, RealLayout, ComplexLayout, MemoryLayout,
    FullSpace, fullspace, Subspace, SubspaceMap,
    PulseJob, Pulse, HyperfinePulse, RydbergPulse, is_time_dependent,
    update_term!, simple_rydberg, rydberg_h, rydatoms,
    rand_atoms, read_atoms, write_atoms, read_subspace,
    write_subspace, unit_disk_graph, rand_unit_disk_graph,
    DiscreteEvolution, emulate!, emulate,
    mean_rydberg, count_vertices, mean, gibbs_loss, logsumexp,
    square_lattice, set_zero_state!, blockade_subspace, is_independent_set,
    to_independent_set!, to_independent_set, add_vertices, add_vertices!,
    add_random_vertices,
    # reexport from Yao
    measure, zero_state, independent_set_probabilities,
    mis_postprocessing,
    # units
    MHz, μs, ns

# NOTE: remove this after expv get fixed
include("expmv.jl")

# NOTE: remove this after BQCESubroutine beta version is released
include("bsubspace.jl")

include("utils.jl")
include("atoms.jl")
include("subspace.jl")
include("hamiltonian.jl")

include("register.jl")
include("measure.jl")
include("instructs.jl")
include("mat.jl")

include("unit_disk.jl")
include("emulate.jl")

include("serialize.jl")
include("mis.jl")
include("schema.jl")
include("deprecations.jl")

end # module
