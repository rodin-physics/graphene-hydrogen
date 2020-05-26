include("../../general.jl")
include("../../tight_binding.jl")


DFT_Bands = readdlm("Data/DFT/bands/1h_unrelaxed/uc.U-H.bands")

e_shift_unrelaxed = -2.169;
marker_alpha = 0.7;

DFT_Bands[:, 2] = DFT_Bands[:, 2] .- e_shift_unrelaxed;

# Distances between different point of symmetry
KΓ_L = √((K[1] - Γ[1])^2 + (K[2] - Γ[2])^2)
ΓM_L = √((M[1] - Γ[1])^2 + (M[2] - Γ[2])^2)
MK_L = √((K[1] - M[1])^2 + (K[2] - M[2])^2)

# BZ path: Κ-Γ-M-K
nPts = 101;

# Distances between different point of symmetry
KΓ_L = √((K[1] - Γ[1])^2 + (K[2] - Γ[2])^2)
ΓM_L = √((M[1] - Γ[1])^2 + (M[2] - Γ[2])^2)
MK_L = √((K[1] - M[1])^2 + (K[2] - M[2])^2)

# x coordinates used for plotting the bands
xCoord = vcat(
    (1:nPts) / nPts * KΓ_L,
    KΓ_L .+ (1:nPts) / nPts * ΓM_L,
    KΓ_L .+ ΓM_L .+ (1:nPts) / nPts * MK_L,
)

# Momenta
QX = vcat(
    range(K[1], stop = Γ[1], length = nPts),
    range(Γ[1], stop = M[1], length = nPts),
    range(M[1], stop = K[1], length = nPts),
)

QY = vcat(
    range(K[2], stop = Γ[2], length = nPts),
    range(Γ[2], stop = M[2], length = nPts),
    range(M[2], stop = K[2], length = nPts),
)

# Calculated energies along the predefined momentum path
energy_states = map((qx, qy) -> Hπ_H([qx, qy]) |> eigen, QX, QY)
Energies = reduce(hcat, map(x -> x.values, energy_states))
H_Proj = reduce(hcat, map(x -> abs.(x.vectors[1, :]) .^ 2, energy_states))

# Plotting
pyplot()
plot(
    yaxis = (L"$E$ (eV)", font(12, "Serif")),
    xticks = (
        [0, KΓ_L, KΓ_L + ΓM_L, KΓ_L + ΓM_L + MK_L],
        [L"$\mathrm{K}$", L"$\Gamma$", L"$\mathrm{M}$", L"$\mathrm{K}$"],
    ),
    xtickfont = font(12, "Serif"),
    ytickfont = font(12, "Serif"),
    ylims = (-22, 20),
    legend = :bottomleft,
)

scatter!(
    DFT_Bands[:, 1] ./ maximum(DFT_Bands[:, 1]) .* (KΓ_L + ΓM_L + MK_L),
    DFT_Bands[:, 2],
    markersize = 1.5,
    markeralpha = 1,
    markerstrokewidth = 0,
    color = RGB(0.65, 0.65, 0.65),
    label = false,
)

for ii = 1:size(Energies)[1]
    scatter!(
        xCoord,
        Energies[ii, :],
        markersize = 1.5 .+ 3 .* H_Proj[ii, :],
        zcolor = H_Proj[ii, :],
        markercolor = :viridis,
        clims = (0, 1),
        legend = false,
        markerstrokewidth = 0,
        markeralpha = 0.5,
    )
end

annotate!((
    0.9 * (KΓ_L + ΓM_L + MK_L),
    -18.5,
    Plots.text("(a)", :right, 18),
))

savefig("TB_Unrelaxed.pdf")
