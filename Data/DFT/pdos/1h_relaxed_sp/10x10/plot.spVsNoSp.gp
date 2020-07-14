set term pngcairo enhanced size 1280,960 font "Arial, 20"

set output "1010.relaxed.spVsNoSp.zoom.png"
#set title "10x10 unrelaxed PDOS"

set grid
set key samplen 4 box opaque width 2
set xlabel "E-E_F (eV)"
set ylabel "DOS (states/eV)"
#set xrange [-25:20]
set xrange [-2:2]
set xtics 1
set mxtics 2

efermi=-1.7486
efermisp=-1.7405

plot "1010.pdos_tot_both"                   u ($1-efermisp):2 w lp lw 2 lt 1 t "spin polarized", \
     "1010.pdos_tot_nosp" u ($1-efermi):2   w lp lw 2 lt 2 t "non-spin polarized"
