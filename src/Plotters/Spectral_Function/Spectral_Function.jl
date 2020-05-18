include("../../qft.jl")
## Parameters
nPts = 400;
V0 = -0;
V1 = -0;
δ = 0.0 * t;
ε = 0;
# imag(- G_R(1.1, graphene_B(0, 0), ε, V0, 0, δ)) / pi
## Calculation
ωs = range(-3 * t, 3 * t, length = nPts);
# A_I_R = map(ω -> imag(-2 * Γ_I(ω, ε, V0, 0, δ)), ωs)
# A_I_U = map(ω -> imag(-2 * Γ_I(ω, ε, V0, V1, 0)), ωs)

A_G_R = map(ω -> imag(-2 * G_R(ω, graphene_B(1, 1), ε, V0, V1, δ)), ωs)
# A_G_U = map(ω -> imag(-2 * G_R(ω, graphene_B(0, 0), ε, V0, V1, 0)), ωs)
PDOS_P_Cp = readdlm("Data/DFT/pdos/pristine/sumpdos.Cp.out")

## Plot setup
pyplot()
plot(
    xaxis = (L"$E$ (eV)", font(12, "Serif")),
    yaxis = (L"$\mathcal{A}$ (arb. units)", font(12, "Serif")),
    xtickfont = font(12, "Serif"),
    ytickfont = font(12, "Serif"),
    # xlims = (-3 * t, 3 * t),
    xlims = (-10, 6),
    # yticks = false,
    legend = :topright,
)

# plot!(ωs, A_I_R)
# plot!(ωs, A_I_U)

plot!(ωs, A_G_R)
plot!(
    PDOS_P_Cp[2:end, 1] .+ 1.77,
    PDOS_P_Cp[2:end, 3],
    linealpha = 0.7,
    color = my_red,
    label = L"$\mathrm{C}_{p_x/p_y}}$",
)

scatter!(ωs, res)
# plot!(ωs, A_G_U)

savefig("Test1.pdf")
