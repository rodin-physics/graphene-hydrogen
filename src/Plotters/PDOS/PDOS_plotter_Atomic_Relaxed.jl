include("../../general.jl")
include("../../../Data/DFT/e_Fermi.jl")
include("PDOS_Data_Import.jl")

e_shift = efermi_1h_10x10_R;

line_alpha = 0.9;
fill_alpha = 0.25;

## Plot setup
pyplot()
plot(
    xaxis = (L"$E$ (eV)", font(12, "Serif")),
    yaxis = (L"$\mathrm{DoS}$ (arb. units)", font(12, "Serif")),
    xtickfont = font(12, "Serif"),
    ytickfont = font(12, "Serif"),
    # xlims = (-6, 6),
    xlims = (-20, 5),
    # ylims = (0, 0.5),
    yticks = false,
    legend = :topright,
)



## Hydrogen

# plot!(
#     PDOS_H[2:end, 1] .- e_shift,
#     PDOS_H[2:end, 2],
#     linealpha = line_alpha,
#     color = my_green,
#     label = L"$\mathrm{H}_{s}}$",
# )

## Carbon

plot!(
    PDOS_C3_S[2:end, 1] .- e_shift,
    PDOS_C3_S[2:end, 2],
    linealpha = line_alpha,
    color = my_orange,
    label = L"$\mathrm{C}_{s}}$",
)

plot!(
    PDOS_C3_P[2:end, 1] .- e_shift,
    PDOS_C3_P[2:end, 3],
    linealpha = line_alpha,
    color = my_blue,
    label = L"$\mathrm{C}_{p_z}}$",
)


plot!(
    PDOS_C3_P[2:end, 1] .- e_shift,
    PDOS_C3_P[2:end, 4],
    linealpha = line_alpha,
    color = my_red,
    label = L"$\mathrm{C}_{p_x/p_y}}$",
)

# savefig("PDOS_10x10_Atomic_C3.pdf")
savefig("TestR.pdf")
