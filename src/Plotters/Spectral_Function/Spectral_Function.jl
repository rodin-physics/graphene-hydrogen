include("../../qft.jl")
## Parameters
nPts = 1000;
V0 = -7;
V1 = -0.2;
ε = 0.5;
δ = 0.05 * t;

line_alpha = 0.9;
fill_alpha = 0.25;
y_max = 3;
## Calculation
ωs = range(-10, 5, length = nPts)

res_Unrelaxed = map(ω -> imag(-2 * Γ_I(ω + 1im * η, ε, V0, V1, 0)), ωs)
res_Relaxed = map(ω -> imag(-2 * Γ_I(ω + 1im * η, ε, V0, 0, δ)), ωs)

# res_Unrelaxed =
#     map(ω -> imag(-2 * G_R(ω + 1im * 1e-4, graphene_B(0,0), ε, V0, V1, 0)), ωs)
# res_Relaxed =
#     map(ω -> imag(-2 * G_R(ω + 1im * 1e-4, graphene_B(0,0), ε, V0, 0, δ)), ωs)

## Plot setup
pyplot()
plot(
    xaxis = (L"$E$ (eV)", font(12, "Serif")),
    yaxis = (L"$\mathcal{A}$ (arb. units)", font(12, "Serif")),
    xtickfont = font(12, "Serif"),
    ytickfont = font(12, "Serif"),
    xlims = (-10, 5),
    ylims = (0, y_max),
    yticks = false,
    legend = :topright,
    legendfontsize = 10,
)

plot!(
    ωs,
    res_Unrelaxed,
    linealpha = line_alpha,
    color = my_green,
    label = "Flat",
    fillcolor = my_green,
    fillrange = 0.0,
    fillalpha = fill_alpha,
)

plot!(
    ωs,
    res_Relaxed,
    linealpha = line_alpha,
    color = my_blue,
    label = "Relaxed",
    fillcolor = my_blue,
    fillrange = 0.0,
    fillalpha = fill_alpha,
)
annotate!((-8, 0.9 * y_max, Plots.text("(b)", :right, 18)))
savefig("Test.pdf")
