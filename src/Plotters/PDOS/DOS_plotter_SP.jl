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
y_max = maximum(DOS_10x10_nonSP_R[2:end, 2]);

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
    DOS_10x10_SP_R[2:end, 1] .- efermi_1h_10x10_R_SP,
    DOS_10x10_SP_R[2:end, 2],
    linealpha = line_alpha,
    color = my_green,
    label = "SP",
    fillcolor = my_green,
    fillrange = 0.0,
    fillalpha = fill_alpha,
)

plot!(
    DOS_10x10_nonSP_R[2:end, 1] .- efermi_1h_10x10_R,
    DOS_10x10_nonSP_R[2:end, 2],
    linealpha = line_alpha,
    color = my_blue,
    label = "non-SP",
    fillcolor = my_blue,
    fillrange = 0.0,
    fillalpha = fill_alpha,
    # subplot = 2
)

# plot!(
#     inset = (1, bbox(0.0, 0.7, 0.3, 0.3)),
#     # border = :semi,
# )
lens!(
    [-1 / 2, 1 / 2],
    [0, 20],
    inset = (1, bbox(0.0, 0.7, 0.3, 0.3)),
    # xticks = false,
    yticks = false,
    subplot = 2
)

# plot!(
#     DOS_10x10_nonSP_R[2:end, 1] .- efermi_1h_10x10_R,
#     DOS_10x10_nonSP_R[2:end, 2],
#     inset = (1, bbox(0.0, 0.7, 0.3, 0.3)),
#     # xticks = false,
#     yticks = false,
#     subplot = 2,
# )

plot!(subplot = 2, xticks = false, framestyle = :semi)

annotate!(subplot = 1, (-8, 0.9 * y_max, Plots.text("(b)", :right, 18)))

savefig("DOS_10x10_R.pdf")
# savefig("PDOS_10x10_C0_pz.pdf")
# savefig("Test.pdf")
