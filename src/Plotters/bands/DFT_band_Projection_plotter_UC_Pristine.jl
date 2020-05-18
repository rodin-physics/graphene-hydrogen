include("../../general.jl")
include("../../../Data/DFT/e_Fermi.jl")

DFT_Bands_S = readdlm("Data/DFT/bands/pristine/uc.P-C-s.bands")
DFT_Bands_PX = readdlm("Data/DFT/bands/pristine/uc.P-C-px.bands")
DFT_Bands_PY = readdlm("Data/DFT/bands/pristine/uc.P-C-py.bands")
DFT_Bands_PZ = readdlm("Data/DFT/bands/pristine/uc.P-C-pz.bands")

DFT_Bands_S = DFT_Bands_S[1:2:end, :]
DFT_Bands_PX = DFT_Bands_PX[1:2:end, :]
DFT_Bands_PY = DFT_Bands_PY[1:2:end, :]
DFT_Bands_PZ = DFT_Bands_PZ[1:2:end, :]

e_shift = efermi_P;
marker_alpha = 0.7;

# Distances between different point of symmetry
KΓ_L = √((K[1] - Γ[1])^2 + (K[2] - Γ[2])^2)
ΓM_L = √((M[1] - Γ[1])^2 + (M[2] - Γ[2])^2)
MK_L = √((K[1] - M[1])^2 + (K[2] - M[2])^2)

# Plotting
pyplot()
plot(
    yaxis = (L"$E-E_F$ (eV)", font(12, "Serif")),
    xticks = (
        [0, KΓ_L, KΓ_L + ΓM_L, KΓ_L + ΓM_L + MK_L],
        [L"$\mathrm{K}$", L"$\Gamma$", L"$\mathrm{M}$", L"$\mathrm{K}$"],
    ),
    xtickfont = font(12, "Serif"),
    ytickfont = font(12, "Serif"),
    ylims = (-22, 20),
    legend = :outertopright,
)

scatter!(
    DFT_Bands_S[:, 1] ./ maximum(DFT_Bands_S[:, 1]) .* (KΓ_L + ΓM_L + MK_L),
    DFT_Bands_S[:, 2] .- e_shift,
    markersize = 1.5,
    markeralpha = marker_alpha,
    markercolor = RGB(0.5, 0.5, 0.5),
    markerstrokewidth = 0,
    label = false,
)

scatter!(
    DFT_Bands_S[:, 1] ./ maximum(DFT_Bands_S[:, 1]) .* (KΓ_L + ΓM_L + MK_L),
    DFT_Bands_S[:, 2] .- e_shift,
    markersize = 6 .* DFT_Bands_S[:, 3],
    markeralpha = marker_alpha,
    markercolor = my_orange,
    markerstrokewidth = 0,
    label = L"$\mathrm{C}_s$",
    legendfontsize = 10,
)

scatter!(
    DFT_Bands_PX[:, 1] ./ maximum(DFT_Bands_PX[:, 1]) .* (KΓ_L + ΓM_L + MK_L),
    DFT_Bands_PX[:, 2] .- e_shift,
    markersize = 6 .* DFT_Bands_PX[:, 3],
    markeralpha = marker_alpha,
    markercolor = my_violet,
    markerstrokewidth = 0,
    label = L"$\mathrm{C}_{p_x}$",
    legendfontsize = 10,
)

scatter!(
    DFT_Bands_PY[:, 1] ./ maximum(DFT_Bands_PY[:, 1]) .* (KΓ_L + ΓM_L + MK_L),
    DFT_Bands_PY[:, 2] .- e_shift,
    markersize = 6 .* DFT_Bands_PY[:, 3],
    markeralpha = marker_alpha,
    markercolor = my_red,
    markerstrokewidth = 0,
    label = L"$\mathrm{C}_{p_y}$",
    legendfontsize = 10,
)

scatter!(
    DFT_Bands_PZ[:, 1] ./ maximum(DFT_Bands_PZ[:, 1]) .* (KΓ_L + ΓM_L + MK_L),
    DFT_Bands_PZ[:, 2] .- e_shift,
    markersize = 6 .* DFT_Bands_PZ[:, 3],
    markeralpha = marker_alpha,
    markercolor = my_blue,
    markerstrokewidth = 0,
    label = L"$\mathrm{C}_{p_z}$",
    legendfontsize = 10,
)

savefig("UC_Projection_Pristine.pdf")
