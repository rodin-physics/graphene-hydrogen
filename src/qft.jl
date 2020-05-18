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

## Propagators
# Pristine graphene Green's function
function G0(z, q)
    return inv([
        z 0
        0 z
    ] - Hπ(q))
end

# Real-space propagator. The function picks out the correct element of
# the Ξ matrix depending on the sublattices of the graphene coordinates
function Ξ(a_l::GrapheneCoord, a_m::GrapheneCoord, z)
    u = a_l.u - a_m.u
    v = a_l.v - a_m.v
    G_z(r) = G0(z, r .* [2 / a, 2 / a / √(3)])
    kernel(r) =
        G_z(r) .* exp(1im * ((u - v) * r[1] + (u + v) * r[2])) / (2 * π)^2
    if a_l.sublattice == a_m.sublattice
        idx = 1
    elseif ([a_l.sublattice, a_m.sublattice] == ["●", "○"])
        idx = 3
    elseif ([a_l.sublattice, a_m.sublattice] == ["○", "●"])
        idx = 2
    else
        error("Illegal sublattice parameter")
    end
    res = hcubature(
        2,
        (r, v) -> v[:] = begin
            k = kernel(r)[idx]
            [real(k), imag(k)]
        end,
        [0, 0],
        [2 * π, 2 * π],
        reltol = ν,
        abstol = α,
    )
    return res[1]
end

function Γ_I(ω, ε, V0, V1, δ)
    # We add a small number to the diagonal to allow the matrix to be inverted
    Δ = [
        η δ δ δ
        δ η 0 0
        δ 0 η 0
        δ 0 0 η
    ]

    Vs = [V0, V1, V1, V1]

    Ξ0 = Ξ(graphene_A(0, 0), graphene_A(0, 0), ω + 1im * η)
    Ξ1 = Ξ(graphene_A(0, 0), graphene_B(0, 0), ω + 1im * η)
    Ξ2 = Ξ(graphene_B(0, 0), graphene_B(1, 0), ω + 1im * η)

    IΞI = [
        Ξ0 Ξ1 Ξ1 Ξ1
        Ξ1 Ξ0 Ξ2 Ξ2
        Ξ1 Ξ2 Ξ0 Ξ2
        Ξ1 Ξ2 Ξ2 Ξ0
    ]

    nAtoms = length(coords)
    iden = Diagonal(ones(nAtoms))
    Λ = IΞI * (iden + inv(inv(Δ * IΞI) - iden))

    return 1 / (ω + 1im * η - ε - Vs' * Λ * Vs)
end


function G_R(ω, coord, ε, V0, V1, δ)
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

    Ξ0 = Ξ(graphene_A(0, 0), graphene_A(0, 0), ω + 1im * η)
    Ξ1 = Ξ(graphene_A(0, 0), graphene_B(0, 0), ω + 1im * η)
    Ξ2 = Ξ(graphene_B(0, 0), graphene_B(1, 0), ω + 1im * η)

    IΞI = [
        Ξ0 Ξ1 Ξ1 Ξ1
        Ξ1 Ξ0 Ξ2 Ξ2
        Ξ1 Ξ2 Ξ0 Ξ2
        Ξ1 Ξ2 Ξ2 Ξ0
    ]

    D = inv(Δ + (Vs * Vs') ./ (ω + 1im * η - ε)) - IΞI |> inv

    prop_vector_R = map(x -> propagator(x, coord, ω + 1im * η), coords)

    return (Ξ0 + transpose(prop_vector_R) * D * prop_vector_R)
end
