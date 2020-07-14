include("../../general.jl")
include("PDOS_Data_Import.jl")

efermi_1h_10x10_R_SP = -1.7405
efermi_1h_10x10_R = -1.7486

efermi_1h_10x10_U_SP = -1.5095
efermi_1h_10x10_U = -1.5093

efermi_1h_uc_R_SP = -1.6005
efermi_1h_uc_R = -1.5196

efermi_1h_uc_U_SP = -0.7587
efermi_1h_uc_U = -0.7584

line_alpha = 0.9;
fill_alpha = 0.25;
y_max = 5;

## Plot setup
pyplot()
plot(
    xaxis = (L"$E$ (eV)", font(12, "Serif")),
    yaxis = (L"$\mathrm{DoS}$ (arb. units)", font(12, "Serif")),
    xtickfont = font(12, "Serif"),
    ytickfont = font(12, "Serif"),
    xlims = (-10, 5),
    ylims = (0, y_max),
    yticks = false,
    legend = :topright,
    legendfontsize = 10,
)

plot!(
    DOS_UC_SP_U[2:end, 1] .- efermi_1h_uc_U_SP,
    DOS_UC_SP_U[2:end, 2],
    linealpha = line_alpha,
    color = my_green,
    label = "SP",
    fillcolor = my_green,
    fillrange = 0.0,
    fillalpha = fill_alpha,
)

plot!(
    DOS_UC_nonSP_U[2:end, 1] .- efermi_1h_uc_U,
    DOS_UC_nonSP_U[2:end, 2],
    linealpha = line_alpha,
    color = my_blue,
    label = "non-SP",
    fillcolor = my_blue,
    fillrange = 0.0,
    fillalpha = fill_alpha,
)

annotate!((-8, 0.9 * y_max, Plots.text("(a)", :right, 18)))

savefig("DOS_UC_U.pdf")
# savefig("PDOS_10x10_C0_pz.pdf")
# savefig("Test.pdf")
