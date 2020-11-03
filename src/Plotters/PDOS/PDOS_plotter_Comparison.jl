include("../../general.jl")
include("../../../Data/DFT/e_Fermi.jl")
include("PDOS_Data_Import.jl")

line_alpha = 0.9;
fill_alpha = 0.25;
y_max = max(maximum(PDOS_H_U[2:end, 3]), maximum(PDOS_H_R[2:end, 3]));
# y_max = 2*max(maximum(PDOS_C2_p_U[2:end, 3]), maximum(PDOS_C2_p_R[2:end, 3]));

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
    legendfontsize = 10
)

## Hydrogen
plot!(
    PDOS_H_U[2:end, 1] .- efermi_1h_10x10_U,
    PDOS_H_U[2:end, 3],
    linealpha = line_alpha,
    color = my_green,
    label = "Flat",
    fillcolor = my_green,
    fillrange = 0.0,
    fillalpha = fill_alpha
)

plot!(
    PDOS_H_R[2:end, 1] .- efermi_1h_10x10_R,
    PDOS_H_R[2:end, 3],
    linealpha = line_alpha,
    color = my_blue,
    label = "Relaxed",
    fillcolor = my_blue,
    fillrange = 0.0,
    fillalpha = fill_alpha
)

## Carbon PZ
# plot!(
#     PDOS_C2_p_U[2:end, 1] .- efermi_1h_10x10_U,
#     PDOS_C2_p_U[2:end, 3],
#     linealpha = line_alpha,
#     color = my_green,
#     label = "Flat",
#     fillcolor = my_green,
#     fillrange = 0.0,
#     fillalpha = fill_alpha
# )
#
# plot!(
#     PDOS_C2_p_R[2:end, 1] .- efermi_1h_10x10_R,
#     PDOS_C2_p_R[2:end, 3],
#     linealpha = line_alpha,
#     color = my_blue,
#     label = "Relaxed",
#     fillcolor = my_blue,
#     fillrange = 0.0,
#     fillalpha = fill_alpha
# )

annotate!((
    -8,
    0.9 * y_max,
    Plots.text("(a)", :right, 18),
))

savefig("PDOS_10x10_H.pdf")
# savefig("PDOS_10x10_C2_pz.pdf")
# savefig("Test.pdf")
