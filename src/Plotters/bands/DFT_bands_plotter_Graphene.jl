include("../../general.jl")
include("../../tight_binding.jl")
include("../../../Data/DFT/e_Fermi.jl")

DFT_Bands_P = readdlm("Data/DFT/bands/pristine/uc.P-C-s.bands")
DFT_Bands_B = readdlm("Data/DFT/bands/buckled/uc.B-C-s.bands")

DFT_Bands_P = DFT_Bands_P[1:2:end, :]

marker_alpha = 0.9;

# Distances between different point of symmetry
KΓ_L = √((K[1] - Γ[1])^2 + (K[2] - Γ[2])^2)
ΓM_L = √((M[1] - Γ[1])^2 + (M[2] - Γ[2])^2)
MK_L = √((K[1] - M[1])^2 + (K[2] - M[2])^2)
## Tight-binding calculations
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
energy_states = map((qx, qy) -> Hπ([qx, qy]) |> eigen, QX, QY)
Energies = reduce(hcat, map(x -> x.values, energy_states))


## Plotting
pyplot()
plot(
    yaxis = (L"$E - E_F$ (eV)", font(12, "Serif")),
    xticks = (
        [0, KΓ_L, KΓ_L + ΓM_L, KΓ_L + ΓM_L + MK_L],
        [L"$\mathrm{K}$", L"$\Gamma$", L"$\mathrm{M}$", L"$\mathrm{K}$"],
    ),
    xtickfont = font(12, "Serif"),
    ytickfont = font(12, "Serif"),
    ylims = (-22, 20),
    legend = :outertopright,
    legendfontsize = 10,
)

plot!(
    xCoord,
    Energies[1, :],
    linewidth = 2,
    linecolor =  :black,
    # linecolor = RGB(0.6, 0.6, 0.6),
    linealpha = 1,
    label = "TB",
)

for ii = 2:size(Energies)[1]
    plot!(
        xCoord,
        Energies[ii, :],
        linewidth = 2,
        linecolor =  :black,
        # linecolor = RGB(0.6, 0.6, 0.6),
        linealpha = 1,
        label = false,
    )
end

scatter!(
    DFT_Bands_P[:, 1] ./ maximum(DFT_Bands_P[:, 1]) .* (KΓ_L + ΓM_L + MK_L),
    DFT_Bands_P[:, 2] .- efermi_pristine,
    markersize = 2,
    markeralpha = marker_alpha,
    markercolor = my_red,
    markerstrokewidth = 0,
    label = "Planar",
    markershape = :diamond,
)

scatter!(
    DFT_Bands_B[:, 1] ./ maximum(DFT_Bands_B[:, 1]) .* (KΓ_L + ΓM_L + MK_L),
    DFT_Bands_B[:, 2] .- efermi_buckled,
    markersize = 2,
    markeralpha = marker_alpha,
    markercolor = my_blue,
    markerstrokewidth = 0,
    label = "Buckled",
    markershape = :circle,
)

# annotate!((
#     0.9 * maximum(xCoord),
#     -18,
#     Plots.text("(e)", :right, 18),
# ))
# savefig("Test.pdf")
savefig("UC_Bands_Comparison.pdf")
