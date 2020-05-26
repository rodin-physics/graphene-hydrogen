using DelimitedFiles
using LaTeXStrings
using LinearAlgebra
using Plots
using QuadGK
## Parameters
# Lattice parameters
const a = 2.46;
const d1 = a .* [+1, √(3)] ./ 2;
const d2 = a .* [-1, √(3)] ./ 2;

const Γ = [0, 0];
const K = [2 * pi / 3 / a, 2 * pi / sqrt(3) / a];
const M = [0, 2 * pi / sqrt(3) / a];

const ν = 1e-2;     # Small number for relative tolerance
const α = 1e-5;     # Small number for absolute tolerance
const η = 1e-5;     # Small number for moving the contour off the real axis

## Colors for plotting
my_yellow = RGB(255 / 255, 255 / 255, 153 / 255)
my_green = RGB(127 / 255, 201 / 255, 127 / 255)
my_blue = RGB(56 / 255, 108 / 255, 176 / 255)
my_violet = RGB(190 / 255, 174 / 255, 212 / 255)
my_red = RGB(240 / 255, 2 / 255, 127 / 255)
my_orange = RGB(253 / 255, 192 / 255, 134 / 255)
