include("../../general.jl")

PDOS_P_Cs = readdlm("Data/DFT/pdos/pristine/sumpdos.Cs.out")
PDOS_P_Cp = readdlm("Data/DFT/pdos/pristine/sumpdos.Cp.out")

PDOS_U_Cs = readdlm("Data/DFT/pdos/1h_unrelaxed/10x10/sumpdos.Cs.out")
PDOS_U_Cp = readdlm("Data/DFT/pdos/1h_unrelaxed/10x10/sumpdos.Cp.out")
PDOS_U_H = readdlm("Data/DFT/pdos/1h_unrelaxed/10x10/sumpdos.H.out")

PDOS_R_Cs = readdlm("Data/DFT/pdos/1h_relaxed/10x10/sumpdos.Cs.out")
PDOS_R_Cp = readdlm("Data/DFT/pdos/1h_relaxed/10x10/sumpdos.Cp.out")
PDOS_R_H = readdlm("Data/DFT/pdos/1h_relaxed/10x10/sumpdos.H.out")

# e_shift_P = -1.7760;
# e_shift_U = -2.06;
# e_shift_R = -1.38;

e_shift_P = -1.7760;
e_shift_U = -1.7760;
e_shift_R = -1.7760;

line_alpha = 0.9;
fill_alpha = 0.25;

## Plot setup
pyplot()
plot(
    xaxis = (L"$E$ (eV)", font(12, "Serif")),
    yaxis = (L"$\mathrm{DoS}$ (states / eV)", font(12, "Serif")),
    xtickfont = font(12, "Serif"),
    ytickfont = font(12, "Serif"),
    xlims = (-20, 5),
    # ylims = (0, 2),
    legend = :topright,
)

## Hydrogen
# plot!(
#     PDOS_U_H[2:end, 1] .- e_shift_U,
#     PDOS_U_H[2:end, 2],
#     linealpha = line_alpha,
#     color = my_blue,
#     label = L"$\mathrm{H}^\mathrm{U}_{s}}$",
#     fillcolor = my_blue,
#     fillrange = 0.0,
#     fillalpha = fill_alpha
# )
#
# plot!(
#     PDOS_R_H[2:end, 1] .- e_shift_R,
#     PDOS_R_H[2:end, 2],
#     linealpha = line_alpha,
#     color = my_green,
#     label = L"$\mathrm{H}^\mathrm{R}_{s}}$",
#     fillcolor = my_green,
#     fillrange = 0.0,
#     fillalpha = fill_alpha
# )

## Carbon S
# plot!(
#     PDOS_U_Cs[2:end, 1] .- e_shift_U,
#     PDOS_U_Cs[2:end, 2],
#     linealpha = line_alpha,
#     color = my_blue,
#     label = L"$\mathrm{C}^\mathrm{U}_{s}}$",
#     fillcolor = my_blue,
#     fillrange = 0.0,
#     fillalpha = fill_alpha
# )
#
# plot!(
#     PDOS_R_Cs[2:end, 1] .- e_shift_R,
#     PDOS_R_Cs[2:end, 2],
#     linealpha = line_alpha,
#     color = my_green,
#     label = L"$\mathrm{C}^\mathrm{R}_{s}}$",
#     fillcolor = my_green,
#     fillrange = 0.0,
#     fillalpha = fill_alpha
# )
#
# plot!(
#     PDOS_P_Cs[2:end, 1] .- e_shift_P,
#     PDOS_P_Cs[2:end, 2],
#     linealpha = line_alpha,
#     color = my_red,
#     label = L"$\mathrm{C}^\mathrm{P}_{s}}$",
#     fillcolor = my_red,
#     fillrange = 0.0,
#     fillalpha = fill_alpha
# )

## Carbon PZ
# plot!(
#     PDOS_U_Cp[2:end, 1] .- e_shift_U,
#     PDOS_U_Cp[2:end, 3],
#     linealpha = line_alpha,
#     color = my_blue,
#     label = L"$\mathrm{C}^\mathrm{U}_{p_{z}}}$",
#     fillcolor = my_blue,
#     fillrange = 0.0,
#     fillalpha = fill_alpha
# )
#
# plot!(
#     PDOS_R_Cp[2:end, 1] .- e_shift_R,
#     PDOS_R_Cp[2:end, 3],
#     linealpha = line_alpha,
#     color = my_green,
#     label = L"$\mathrm{C}^\mathrm{R}_{p_{z}}}$",
#     fillcolor = my_green,
#     fillrange = 0.0,
#     fillalpha = fill_alpha
# )

# plot!(
#     PDOS_P_Cp[2:end, 1] .- e_shift_P,
#     PDOS_P_Cp[2:end, 3],
#     linealpha = line_alpha,
#     color = my_red,
#     label = L"$\mathrm{C}^\mathrm{P}_{p_{z}}}$",
# )

## Carbon PX/PY
# plot!(
#     PDOS_U_Cp[2:end, 1] .- e_shift_U,
#     PDOS_U_Cp[2:end, 4],
#     linealpha = line_alpha,
#     color = my_blue,
#     label = L"$\mathrm{C}^\mathrm{U}_{p_{x/y}}}$",
#     fillcolor = my_blue,
#     fillrange = 0.0,
#     fillalpha = fill_alpha
# )
#
# plot!(
#     PDOS_R_Cp[2:end, 1] .- e_shift_R,
#     PDOS_R_Cp[2:end, 4],
#     linealpha = line_alpha,
#     color = my_green,
#     label = L"$\mathrm{C}^\mathrm{R}_{p_{x/y}}}$",
#     fillcolor = my_green,
#     fillrange = 0.0,
#     fillalpha = fill_alpha
# )

plot!(
    PDOS_P_Cp[2:end, 1] .- e_shift_P,
    PDOS_P_Cp[2:end, 3],
    linealpha = line_alpha,
    color = my_red,
    label = L"$\mathrm{C}^\mathrm{P}_{p_{z}}}$",
    fillcolor = my_red,
    fillrange = 0.0,
    fillalpha = fill_alpha
)

# savefig("PDOS_UC_H_S.pdf")
savefig("Test.pdf")
