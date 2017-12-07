#!/bin/bash

month=$(date +"%Y%m")
today=$(date +"%Y%m%d")
ncfile=$(date +"%Y%m%d")
plot=forecast_$today.ps
plot_sa=SAforecast_$today.ps

wget ftp://nomads.ncdc.noaa.gov/GFS/Grid4/$month/$today/gfs_4_????????_1200_120.grb2
cdo -f nc copy gfs_4_????????_1200_120.grb2 $ncfile.nc

date=$(echo *.grb2)

# Do a a plot
gmt grdconvert $ncfile.nc\?prmsl -Gmslp_org.nc
gmt grdedit mslp_org.nc -R-180/180/-90/90 -S
gmt grdmath mslp_org.nc 100 DIV = mslp_nrm.nc

gmt grdimage mslp_nrm.nc -JX25/0d -K > $plot
gmt pscoast -Rmsl_nrm.nc -JX -W0.5 -N3 -O -Dc >> $plot

out='southafrica_syn.ps'

#Coordinates (actually lower left and upper right not E S W N) 
east=-20
south=-46
west=60
north=-12r

#Projection (Lambert Azimuthal Equal-Area)
width=25.5

gmt psbasemap  -R$east/$south/$west/$north -JA25/-30/$width -Xc -Yc -B15a0g15 -B+t"Weather $today + 120h" -K > $plot_sa
gmt pscoast    -R -JA -W -Df -N1 -O -K >> $plot_sa
gmt grdcontour -R -JA -Wthinnest mslp_nrm.nc -C2 -A2 -T+lLH -O -K >> $plot_sa

#rm gfs_4_????????_1200_120.grb2
