set term pngcairo enhanced size 1280,960 font "Arial, 20"

set output "uc.unrelaxed.spVsNoSp.zoom.png"
set title "UC unrelaxed PDOS"

set grid
set key samplen 4 box opaque width 2
set xlabel "E-E_F (eV)"
set ylabel "DOS (states/eV)"
#set xrange [-25:20]
set xrange [-2:2]
set xtics 1
set mxtics 2

efermi=-0.7584
efermisp=-0.7587

plot "uc.pdos_tot_sp_both" u ($1-efermisp):2 w lp lw 2 lt 1 t "spin polarized", \
     "uc.pdos_tot_nosp"    u ($1-efermi):2   w lp lw 2 lt 2 t "non-spin polarized"
