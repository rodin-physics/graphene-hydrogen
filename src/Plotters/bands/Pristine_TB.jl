include("../../../src/tight_binding.jl")

# DFT_Bands_P = readdlm("Data/DFT/bands/pristine/uc.c-s.bands")
# DFT_Bands_B = readdlm("Data/DFT/bands/buckled/uc.c-s.bands")

e_shift_B = -1.9415
e_shift_P = -1.7668

marker_alpha = 0.7;

# writedlm("Data/DFT_Test.txt", DFT_Bands_H)
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
energy_states = map((qx, qy) -> Hπ([qx, qy]) |> eigen, QX, QY)
Energies = reduce(hcat, map(x -> x.values, energy_states))

# Plotting
pyplot()
plot(
    yaxis = (L"$E - E_F$ (eV)", font(12, "Serif")),
    xticks = (
        [0, KΓ_L, KΓ_L + ΓM_L, KΓ_L + ΓM_L + MK_L],
        [L"$\mathrm{K}$", L"$\Gamma$", L"$\mathrm{M}$", L"$\mathrm{K}$"],
    ),
    xtickfont = font(12, "Serif"),
    ytickfont = font(12, "Serif"),
    # ylims = (minimum(vcat(DFT_Bands[:, 2])), 20),
    legend = :bottomleft,
)
#
# scatter!(
#     DFT_Bands_P[:, 1] ./ maximum(DFT_Bands_P[:, 1]) .* (KΓ_L + ΓM_L + MK_L),
#     DFT_Bands_P[:, 2] .- e_shift_P,
#     markersize = 1.5,
#     markerstrokecolor = :white,
#     markeralpha = 1,
#     markerstrokewidth = 0,
#     color = RGB(0.65, 0.65, 0.65),
#     label = false,
# )
#
# scatter!(
#     DFT_Bands_B[:, 1] ./ maximum(DFT_Bands_B[:, 1]) .* (KΓ_L + ΓM_L + MK_L),
#     DFT_Bands_B[:, 2] .- e_shift_B,
#     markersize = 1.5,
#     markerstrokecolor = :white,
#     markeralpha = 1,
#     markerstrokewidth = 0,
#     color = RGB(0.65, 0, 0),
#     label = false,
# )

for ii = 1:size(Energies)[1]
    plot!(
        xCoord,
        Energies[ii, :],
        # linewidth = 2,
        linecolor = my_green,
        label = false,
        linealpha = 1,
        # linewidth = 2
    )
end

savefig("Test_1.pdf")
# savefig("UC_Projection_Unrelaxed.pdf")
# savefig("UC_Pristine_Unrelaxed.pdf")
# savefig("UC_Pristine_Relaxed.pdf")
# savefig("UC_Unrelaxed_Relaxed.pdf")
