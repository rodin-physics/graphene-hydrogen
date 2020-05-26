include("tight_binding.jl")

## Graphene Coordinate functions
# Graphene Coordinate with the position R = u * d1 + v * d2 and the sublattice
struct GrapheneCoord
    u::Int
    v::Int
    sublattice::String
end

# Functions to initialize graphene coordinates
function graphene_A(u, v)
    return GrapheneCoord(u, v, "●")
end

function graphene_B(u, v)
    return GrapheneCoord(u, v, "○")
end

@inline function Ω_Integrand(z, u, v, x::Float64)
    W = ((z / t)^2 - 1.0) / (4.0 * cos(x)) - cos(x)
    return (
        exp(1.0im * (u - v) * x) / cos(x) *
        ((W - √(W - 1) * √(W + 1))^abs.(u + v)) / (√(W - 1) * √(W + 1))
    )
end

@inline function Ω(z, u, v)
    return ((quadgk(
        x -> Ω_Integrand(z, u, v, x) / (8.0 * π * t^2),
        0.0,
        2.0 * π,
        atol = α,
    ))[1])
end

@inline function Ωp_Integrand(z, u, v, x::Float64)
    W = ((z / t)^2 - 1.0) / (4.0 * cos(x)) - cos(x)
    return (
        2 *
        exp(1.0im * (u - v) * x) *
        ((W - √(W - 1) * √(W + 1))^abs.(u + v + 1)) / (√(W - 1) * √(W + 1))
    )
end

@inline function Ωp(z, u, v)
    return ((quadgk(
        x -> Ωp_Integrand(z, u, v, x) / (8.0 * π * t^2),
        0.0,
        2.0 * π,
        atol = α,
    ))[1])
end

@inline function Ωn_Integrand(z, u, v, x::Float64)
    W = ((z / t)^2 - 1.0) / (4.0 * cos(x)) - cos(x)
    return (
        2 *
        exp(1.0im * (u - v) * x) *
        ((W - √(W - 1) * √(W + 1))^abs.(u + v - 1)) / (√(W - 1) * √(W + 1))
    )
end

@inline function Ωn(z, u, v)
    return ((quadgk(
        x -> Ωn_Integrand(z, u, v, x) / (8.0 * π * t^2),
        0.0,
        2.0 * π,
        atol = α,
    ))[1])
end

# The propagator function picks out the correct element of the Ξ matrix based
# on the sublattices of the graphene coordinates
function propagator(a_l::GrapheneCoord, a_m::GrapheneCoord, z)
    u = a_l.u - a_m.u
    v = a_l.v - a_m.v
    if a_l.sublattice == a_m.sublattice
        return (z * Ω(z, u, v))
    elseif ([a_l.sublattice, a_m.sublattice] == ["●", "○"])
        return (-t * (Ω(z, u, v) + Ωp(z, u, v)))
    elseif ([a_l.sublattice, a_m.sublattice] == ["○", "●"])
        return (-t * (Ω(z, u, v) + Ωn(z, u, v)))
    else
        error("Illegal sublattice parameter")
    end
end

# The (I^T Ξ I) Matrix. We use the fact that the matrix is symmetric to speed
# up the calculation
function propagator_matrix(z, Coords::Vector{GrapheneCoord})
    len_coords = length(Coords)
    out = zeros(ComplexF64, len_coords, len_coords)
    for ii = 1:len_coords
        @inbounds for jj = ii:len_coords
            out[ii, jj] = propagator(Coords[ii], Coords[jj], z)
            out[jj, ii] = out[ii, jj]
        end
    end
    return out
end

function δΓ_I(z, ε, V0, V1, δ)
    coords =
        [graphene_A(0, 0), graphene_B(0, 0), graphene_B(1, 0), graphene_B(0, 1)]

    # We add a small number to the diagonal to allow the matrix to be inverted
    Δ = [
        η δ δ δ
        δ η 0 0
        δ 0 η 0
        δ 0 0 η
    ]

    Vs = [V0, V1, V1, V1]

    IΞI = propagator_matrix(z, coords)
    nAtoms = length(coords)
    iden = Diagonal(ones(nAtoms))
    Λ = IΞI * (iden + inv(inv(Δ * IΞI) - iden))
    return (Vs' * Λ * Vs) / ((z - ε - Vs' * Λ * Vs) * (z - ε))
end

function Γ_I(z, ε, V0, V1, δ)
    return (δΓ_I(z, ε, V0, V1, δ) + 1 / (z - ε))
end

function G_R(z, coord, ε, V0, V1, δ)
    coords =
        [graphene_A(0, 0), graphene_B(0, 0), graphene_B(1, 0), graphene_B(0, 1)]
    IΞI = propagator_matrix(z, coords)
    Δ = [
        η δ δ δ
        δ η 0 0
        δ 0 η 0
        δ 0 0 η
    ]
    Vs = [V0, V1, V1, V1]
    D = inv(Δ + (Vs * Vs') ./ (z - ε)) - IΞI |> inv

    Ξ_0 = propagator(coord, coord, z)

    prop_vector_R = map(x -> propagator(x, coord, z), coords)

    return (Ξ_0 + transpose(prop_vector_R) * D * prop_vector_R)
end
