#!/bin/bash
# The map creates a nice topographical map of Africa and then we
# specify the borders for a study area when calling the next "section"

globe=africa_orotho.ps
cap=country_capitals.dat
jro=jro_domain.ps
bal=bale_domain.ps
topo=../topo_source/ETOPO1_Bed_g_gmt4.grd

# Make a map with a orthographic projection of east Africa
gmt psbasemap -Rg -JG45/10.5/20 -Xc -Yc -Bag -K > $globe
gmt makecpt   -Crelief -T-8500/8500/100 -Z > topo.cpt
gmt grdimage   $topo -R -J -O -K -Ctopo.cpt >> $globe
gmt pscoast   -R -J -W0.15 -Df -Na -I1/0.15p,skyblue3 -O -K >> $globe

# Make a map of the domains within the global map
north=15
south=-20
east=74.25
west=25.25

tick='-B3/3WSen'
proj='-JM23.5'

gmt psbasemap  -R$west/$east/$south/$north $proj $tick -Xc -Yc -K > $jro
gmt makecpt    -Crelief -T-8500/8500/100 -Z > topo.cpt
gmt grdimage   $topo -R -J -Ctopo.cpt -O -K >> $jro
gmt pscoast    -R -J -W0.15 -Df -Na0.05 -I1/0.15p,skyblue3 -I2/0.15p,skyblue3 -Lf30/-34/45/400+lkm -O -K >> $jro
gmt psxy       $cap -R -J -W1 -St0.25 -G255/0/0 -V -K -O >> $jro
gmt pstext     $cap -R -J -X0.25 -O -K >> $jro
