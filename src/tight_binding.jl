include("general.jl")

## Graphene tight-binding
# Graphene hopping parameters, obtained from PRB 87, 195450 (2013).
# Note that we change t0 to make sure the Dirac point is at zero energy.
const t0 = 0.3208 - 0.00274;    # Same lattice
const t1 = -2.92181;            # Opposite lattice
const t2 = 0.22378;             # Same lattice
const t3 = -0.27897;            # Opposite lattice
const t4 = 0.02669;             # Opposite lattice
const t5 = 0.04813;             # Same lattice
const t6 = -0.02402;            # Same lattice
const t7 = -0.00885;            # Opposite lattice
const t8 = -0.01772;            # Opposite lattice
const t9 = 0.00675;             # Opposite lattice
const t10 = 0.00263;            # Same lattice
const t11 = -0.00262;           # Opposite lattice
const t12 = 0.00111;            # Same lattice
const t13 = 0.00019;            # Opposite lattice
const t14 = -0.00068;           # Opposite lattice
const t15 = 0.00018;            # Same lattice
const t16 = -0.00237;           # Opposite lattice
const t17 = -0.00008;           # Same lattice


# Graphene single NN hopping parameter. NOTE: we set hopping to be equal to -t!
const t = 2.8;

function Hπ(q)
    # Phase terms
    f1 = 1 + exp(1im * sum(d1 .* q)) + exp(1im * sum(d2 .* q))
    f2 =
        2 * cos(sum(d1 .* q)) +
        2 * cos(sum(d2 .* q)) +
        2 * cos(sum((d1 .- d2) .* q))
    f3 =
        exp(1im * sum((d1 .+ d2) .* q)) +
        exp(1im * sum((d1 .- d2) .* q)) +
        exp(1im * sum((-d1 .+ d2) .* q))
    f4 =
        exp(2im * sum(d1 .* q)) +
        exp(2im * sum(d2 .* q)) +
        exp(-1im * sum(d1 .* q)) +
        exp(-1im * sum(d2 .* q)) +
        exp(1im * sum((2 .* d2 .- d1) .* q)) +
        exp(1im * sum((2 .* d1 .- d2) .* q))
    f5 =
        2 * cos(sum((d1 .+ d2) .* q)) +
        2 * cos(sum((2 .* d2 .- d1) .* q)) +
        2 * cos(sum((2 .* d1 .- d2) .* q))
    f6 =
        2 * cos(sum(2 .* d1 .* q)) +
        2 * cos(sum(2 .* d2 .* q)) +
        2 * cos(sum(2 .* (d1 .- d2) .* q))
    f7 =
        exp(1im * sum((2 .* d1 .+ d2) .* q)) +
        exp(1im * sum((2 .* d2 .+ d1) .* q)) +
        exp(1im * sum(2 .* (d1 .- d2) .* q)) +
        exp(1im * sum(2 .* (d2 .- d1) .* q)) +
        exp(1im * sum((d2 .- 2 .* d1) .* q)) +
        exp(1im * sum((d1 .- 2 .* d2) .* q))
    f8 =
        exp(1im * sum((3 .* d1 .- d2) .* q)) +
        exp(1im * sum((3 .* d2 .- d1) .* q)) +
        exp(-1im * sum((d1 .+ d2) .* q))
    f9 =
        exp(3im * sum(d1 .* q)) +
        exp(3im * sum(d2 .* q)) +
        exp(-2im * sum(d1 .* q)) +
        exp(-2im * sum(d2 .* q)) +
        exp(1im * sum((3 .* d1 .- 2 .* d2) .* q)) +
        exp(1im * sum((3 .* d2 .- 2 .* d1) .* q))
    f10 =
        2 * cos(sum((3 .* d1 .- d2) .* q)) +
        2 * cos(sum((3 .* d2 .- d1) .* q)) +
        2 * cos(sum((2 .* d1 .+ d2) .* q)) +
        2 * cos(sum((2 .* d2 .+ d1) .* q)) +
        2 * cos(sum((3 .* d1 .- 2 .* d2) .* q)) +
        2 * cos(sum((3 .* d2 .- 2 .* d1) .* q))
    f11 =
        exp(2im * sum((d1 .+ d2) .* q)) +
        exp(1im * sum((2 .* d1 .- 3 .* d2) .* q)) +
        exp(1im * sum((2 .* d2 .- 3 .* d1) .* q))
    f12 =
        2 * cos(sum(3 .* d1 .* q)) +
        2 * cos(sum(3 .* d2 .* q)) +
        2 * cos(sum(3 .* (d1 .- d2) .* q))
    f13 =
        exp(1im * sum((3 .* d1 .+ d2) .* q)) +
        exp(1im * sum((3 .* d2 .+ d1) .* q)) +
        exp(3im * sum((d1 .- d2) .* q)) +
        exp(3im * sum((d2 .- d1) .* q)) +
        exp(1im * sum((d1 .- 3 .* d2) .* q)) +
        exp(1im * sum((d2 .- 3 .* d1) .* q))
    f14 =
        exp(1im * sum((4 .* d1 .- d2) .* q)) +
        exp(1im * sum((4 .* d1 .- 2 .* d2) .* q)) +
        exp(1im * sum((4 .* d2 .- d1) .* q)) +
        exp(1im * sum((4 .* d2 .- 2 .* d1) .* q)) +
        exp(1im * sum((-2 .* d2 .- d1) .* q)) +
        exp(1im * sum((-2 .* d1 .- d2) .* q))
    f15 =
        2 * cos(sum(2 .* (d1 .+ d2) .* q)) +
        2 * cos(sum((4 .* d1 .- 2 .* d2) .* q)) +
        2 * cos(sum((4 .* d2 .- 2 .* d1) .* q))
    f16 =
        exp(4im * sum(d1 .* q)) +
        exp(4im * sum(d2 .* q)) +
        exp(-3im * sum(d1 .* q)) +
        exp(-3im * sum(d2 .* q)) +
        exp(1im * sum((4 .* d1 .- 3 .* d2) .* q)) +
        exp(1im * sum((4 .* d2 .- 3 .* d1) .* q))
    f17 =
        2 * cos(sum((3 .* d1 .+ d2) .* q)) +
        2 * cos(sum((3 .* d2 .+ d1) .* q)) +
        2 * cos(sum((4 .* d1 .- d2) .* q)) +
        2 * cos(sum((4 .* d2 .- d1) .* q)) +
        2 * cos(sum((4 .* d1 .- 3 .* d2) .* q)) +
        2 * cos(sum((4 .* d2 .- 3 .* d1) .* q))
    return ([
        (
            t0 +
            t2 * f2 +
            t5 * f5 +
            t6 * f6 +
            t10 * f10 +
            t12 * f12 +
            t15 * f15 +
            t17 * f17
        ) (
            t1 * f1 +
            t3 * f3 +
            t4 * f4 +
            t7 * f7 +
            t8 * f8 +
            t9 * f9 +
            t11 * f11 +
            t13 * f13 +
            t14 * f14 +
            t16 * f16
        )
        conj(
            t1 * f1 +
            t3 * f3 +
            t4 * f4 +
            t7 * f7 +
            t8 * f8 +
            t9 * f9 +
            t11 * f11 +
            t13 * f13 +
            t14 * f14 +
            t16 * f16,
        ) (
            t0 +
            t2 * f2 +
            t5 * f5 +
            t6 * f6 +
            t10 * f10 +
            t12 * f12 +
            t15 * f15 +
            t17 * f17
        )
    ])
end


## Semihydrogenated graphene Hamiltonian

ε = 2.43615;
h = -0.457284;
V0 = -5.55219;
V1 = -0.244789;
V2 = 0.00261246;
V3 = 0.0734111;

function Hπ_H(q)
    # Phase terms
    f1 = 1 + exp(1im * sum(d1 .* q)) + exp(1im * sum(d2 .* q))
    f2 =
        2 * cos(sum(d1 .* q)) +
        2 * cos(sum(d2 .* q)) +
        2 * cos(sum((d1 .- d2) .* q))
    f3 =
        exp(1im * sum((d1 .+ d2) .* q)) +
        exp(1im * sum((d1 .- d2) .* q)) +
        exp(1im * sum((-d1 .+ d2) .* q))
    Hπ_ = Hπ(q)
    return ([
        (ε + h * f2) (V0 + V2 * f2) (V1 * f1 + V3 * f3)
        (V0 + V2 * f2) Hπ_[1, 1] Hπ_[1, 2]
        conj(V1 * f1 + V3 * f3) Hπ_[2, 1] Hπ_[2, 2]
    ])
end
