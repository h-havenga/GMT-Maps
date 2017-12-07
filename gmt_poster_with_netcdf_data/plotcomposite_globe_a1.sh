#!/bin/bash

#####################################################
# This is to make a synotpic map                   #
# http://gmt.soest.hawaii.edu/boards/1/topics/5997 #
#####################################################
#
#####################################################
## Step 1: Download the ERA-DATA with this script   #
#####################################################

python << EOF
from ecmwfapi import ECMWFDataServer
server = ECMWFDataServer()
server.retrieve({
    "class": "ei",
    "dataset": "interim",
    "date": "2013-11-28/to/2013-11-28",
    "expver": "1",
    "grid": "0.75/0.75",
    "levtype": "sfc",
    "param": "151.128",
    "step": "0",
    "stream": "oper",
    "time": "12:00:00",
    "type": "an",
    "format":"netcdf",
    "target": "msl.nc",
})

server.retrieve({
    "class": "ei",
    "dataset": "interim",
    "date": "2013-11-28/to/2013-11-28",
    "expver": "1",
    "grid": "0.75/0.75",
    "levtype": "sfc",
    "param": "59.128",
    "step": "12",
    "stream": "oper",
    "time": "00:00:00",
    "type": "fc",
    "format":"netcdf",
    "target": "cape.nc",
})

server.retrieve({
    "class": "ei",
    "dataset": "interim",
    "date": "2013-11-28/to/2013-11-28",
    "expver": "1",
    "grid": "0.75/0.75",
    "levelist": "500",
    "levtype": "pl",
    "param": "129.128",
    "step": "0",
    "stream": "oper",
    "time": "12:00:00",
    "type": "an",
    "format":"netcdf",
    "target": "zg500.nc",
})

server.retrieve({
    "class": "ei",
    "dataset": "interim",
    "date": "2013-11-11/to/2013-11-11",
    "expver": "1",
    "grid": "0.75/0.75",
    "levtype": "sfc",
    "param": "151.128",
    "step": "0",
    "stream": "oper",
    "time": "12:00:00",
    "type": "an",
    "format":"netcdf",
    "target": "msl2.nc",
})

server.retrieve({
    "class": "ei",
    "dataset": "interim",
    "date": "2013-11-11/to/2013-11-11",
    "expver": "1",
    "grid": "0.75/0.75",
    "levtype": "sfc",
    "param": "59.128",
    "step": "12",
    "stream": "oper",
    "time": "00:00:00",
    "type": "fc",
    "format":"netcdf",
    "target": "cape2.nc",
})

server.retrieve({
    "class": "ei",
    "dataset": "interim",
    "date": "2013-11-11/to/2013-11-11",
    "expver": "1",
    "grid": "0.75/0.75",
    "levelist": "500",
    "levtype": "pl",
    "param": "129.128",
    "step": "0",
    "stream": "oper",
    "time": "12:00:00",
    "type": "an",
    "format":"netcdf",
    "target": "zg5002.nc",
})

server = ECMWFDataServer()
server.retrieve({
    "class": "ei",
    "dataset": "interim",
    "date": "2012-11-09/to/2012-11-09",
    "expver": "1",
    "grid": "0.75/0.75",
    "levtype": "sfc",
    "param": "151.128",
    "step": "0",
    "stream": "oper",
    "time": "12:00:00",
    "type": "an",
    "format":"netcdf",
    "target": "msl3.nc",
})

server.retrieve({
    "class": "ei",
    "dataset": "interim",
    "date": "2012-11-09/to/2012-11-09",
    "expver": "1",
    "grid": "0.75/0.75",
    "levtype": "sfc",
    "param": "59.128",
    "step": "12",
    "stream": "oper",
    "time": "00:00:00",
    "type": "fc",
    "format":"netcdf",
    "target": "cape3.nc",
})

server.retrieve({
    "class": "ei",
    "dataset": "interim",
    "date": "2012-11-09/to/2012-11-09",
    "expver": "1",
    "grid": "0.75/0.75",
    "levelist": "500",
    "levtype": "pl",
    "param": "129.128",
    "step": "0",
    "stream": "oper",
    "time": "12:00:00",
    "type": "an",
    "format":"netcdf",
    "target": "zg5003.nc",
})

server.retrieve({
    "class": "ei",
    "dataset": "interim",
    "date": "2012-11-08/to/2012-11-08",
    "expver": "1",
    "grid": "0.75/0.75",
    "levtype": "sfc",
    "param": "151.128",
    "step": "0",
    "stream": "oper",
    "time": "12:00:00",
    "type": "an",
    "format":"netcdf",
    "target": "msl4.nc",
})

server.retrieve({
    "class": "ei",
    "dataset": "interim",
    "date": "2012-11-08/to/2012-11-08",
    "expver": "1",
    "grid": "0.75/0.75",
    "levtype": "sfc",
    "param": "59.128",
    "step": "12",
    "stream": "oper",
    "time": "00:00:00",
    "type": "fc",
    "format":"netcdf",
    "target": "cape4.nc",
})

server.retrieve({
    "class": "ei",
    "dataset": "interim",
    "date": "2012-11-08/to/2012-11-08",
    "expver": "1",
    "grid": "0.75/0.75",
    "levelist": "500",
    "levtype": "pl",
    "param": "129.128",
    "step": "0",
    "stream": "oper",
    "time": "12:00:00",
    "type": "an",
    "format":"netcdf",
    "target": "zg5004.nc",
})

server.retrieve({
    "class": "ei",
    "dataset": "interim",
    "date": "2011-10-19/to/2011-10-19",
    "expver": "1",
    "grid": "0.75/0.75",
    "levtype": "sfc",
    "param": "151.128",
    "step": "0",
    "stream": "oper",
    "time": "12:00:00",
    "type": "an",
    "format":"netcdf",
    "target": "msl5.nc",
})

server.retrieve({
    "class": "ei",
    "dataset": "interim",
    "date": "2011-10-19/to/2011-10-19",
    "expver": "1",
    "grid": "0.75/0.75",
    "levtype": "sfc",
    "param": "59.128",
    "step": "12",
    "stream": "oper",
    "time": "00:00:00",
    "type": "fc",
    "format":"netcdf",
    "target": "cape5.nc",
})

server.retrieve({
    "class": "ei",
    "dataset": "interim",
    "date": "2011-10-19/to/2011-10-19",
    "expver": "1",
    "grid": "0.75/0.75",
    "levelist": "500",
    "levtype": "pl",
    "param": "129.128",
    "step": "0",
    "stream": "oper",
    "time": "12:00:00",
    "type": "an",
    "format":"netcdf",
    "target": "zg5005.nc",
})

EOF

read -p "ERA-Data downloaded. Press enter to continue and convert data for use in GMT "

#############################################################################
## The file is not compatible with GMT, to get it to work do where ?msl     #
## selects the variable we want and writes it to mslp.nc. The '' is         #
## important otherwise bash looks for a wildcard.                           #
## The date units are also wrong to correct them we need to use gmt grdmath #
#############################################################################

#########################################
# MSLP
#########################################
gmt grdconvert 'msl.nc?msl' -Gmslp_org.nc
gmt grdedit mslp_org.nc -R-180/180/-90/90 -S
gmt grdmath mslp_org.nc 100 DIV = mslp_nrm.nc

gmt grdconvert 'msl2.nc?msl' -Gmslp2_org.nc
gmt grdedit mslp2_org.nc -R-180/180/-90/90 -S
gmt grdmath mslp2_org.nc 100 DIV = mslp2_nrm.nc

gmt grdconvert 'msl3.nc?msl' -Gmslp3_org.nc
gmt grdedit mslp3_org.nc -R-180/180/-90/90 -S
gmt grdmath mslp3_org.nc 100 DIV = mslp3_nrm.nc

gmt grdconvert 'msl4.nc?msl' -Gmslp4_org.nc
gmt grdedit mslp4_org.nc -R-180/180/-90/90 -S
gmt grdmath mslp4_org.nc 100 DIV = mslp4_nrm.nc

gmt grdconvert 'msl5.nc?msl' -Gmslp5_org.nc
gmt grdedit mslp5_org.nc -R-180/180/-90/90 -S
gmt grdmath mslp5_org.nc 100 DIV = mslp5_nrm.nc

gmt grdmath mslp_nrm.nc mslp2_nrm.nc ADD mslp3_nrm.nc ADD mslp4_nrm.nc ADD mslp4_nrm.nc ADD 5 DIV = mslp_mean.nc

#########################################
# CAPE                                  #
#########################################
gmt grdconvert 'cape.nc?cape' -Gcape_org.nc
gmt grdedit cape_org.nc -R-180/180/-90/90 -S

gmt grdconvert 'cape2.nc?cape' -Gcape2_org.nc
gmt grdedit cape2_org.nc -R-180/180/-90/90 -S

gmt grdconvert 'cape3.nc?cape' -Gcape3_org.nc
gmt grdedit cape3_org.nc -R-180/180/-90/90 -S

gmt grdconvert 'cape4.nc?cape' -Gcape4_org.nc
gmt grdedit cape4_org.nc -R-180/180/-90/90 -S

gmt grdconvert 'cape5.nc?cape' -Gcape5_org.nc
gmt grdedit cape5_org.nc -R-180/180/-90/90 -S

gmt grdmath cape_org.nc cape2_org.nc ADD cape3_org.nc ADD cape4_org.nc ADD cape5_org.nc ADD 5 DIV = cape_mean.nc

#########################################
# Geopotentail 500                      #
#########################################
gmt grdconvert 'zg500.nc?z' -Gzg500_org.nc
gmt grdedit zg500_org.nc -R-180/180/-90/90 -S
gmt grdmath zg500_org.nc 10 DIV = zg500_nrm.nc

gmt grdconvert 'zg5002.nc?z' -Gzg5002_org.nc
gmt grdedit zg5002_org.nc -R-180/180/-90/90 -S
gmt grdmath zg5002_org.nc 10 DIV = zg5002_nrm.nc

gmt grdconvert 'zg5003.nc?z' -Gzg5003_org.nc
gmt grdedit zg5003_org.nc -R-180/180/-90/90 -S
gmt grdmath zg5003_org.nc 10 DIV = zg5003_nrm.nc

gmt grdconvert 'zg5004.nc?z' -Gzg5004_org.nc
gmt grdedit zg5004_org.nc -R-180/180/-90/90 -S
gmt grdmath zg5004_org.nc 10 DIV = zg5004_nrm.nc

gmt grdconvert 'zg5005.nc?z' -Gzg5005_org.nc
gmt grdedit zg5005_org.nc -R-180/180/-90/90 -S
gmt grdmath zg5005_org.nc 10 DIV = zg5005_nrm.nc

gmt grdmath zg500_nrm.nc zg5002_nrm.nc ADD zg5003_nrm.nc ADD zg5004_nrm.nc ADD zg5005_nrm.nc ADD 5 DIV = zg500_mean.nc

###########################################
#Inspect Mean                             #
###########################################
read -p "Lets inspect the data with ncdump. Press enter to continue "
ncdump -h mslp_mean.nc
ncdump -h zg500_mean.nc
ncdump -h cape_mean.nc

read -p "Lets inspect the data with grdinfo. Press enter to continue "
gmt grdinfo mslp_mean.nc
gmt grdinfo zg500_mean.nc
gmt grdinfo cape_mean.nc

####################################################
# We can use CDO to convert mslp. We do mslp / 100 #
# Here we create a very basic map to view our data #
####################################################
read -p "Lets create a world map. Press enter to continue "

echo 'MSLP map '
gmt grdimage mslp_mean.nc -JX25/0d -K > mslp.ps
gmt pscoast -Rmslp_mean.nc -JX -W0.5 -N3 -O -Dc >> mslp.ps

echo 'CAPE map '
gmt grdimage cape_mean.nc -JX25/0d -K > cape.ps
gmt pscoast -Rcape_mean.nc -JX -W0.5 -N3 -O -Dc >> cape.ps

echo 'Geopotential map '
gmt grdimage zg500_mean.nc -JX25/0d -K > zg500.ps
gmt pscoast -Rzg500_mean.nc -JX -W0.5 -N3 -O -Dc >> zg500.ps

read -p "World map created. Lets create a map of South-Africa. Press enter to continue "

####################################################################
#Now we need to create a contoured map from the netcdf file for SA #
####################################################################
out='hail_composite_globe.ps'

#Coordinates (actually lower left and upper right not E S W N) 
east=-20
south=-46
west=60
north=-12r

#Projection (Lambert Azimuthal Equal-Area)
width=25.5

gmt psbasemap  -Rg -JG25/-15/40 -X3 -Yc -Bag --PS_MEDIA=50.94cx80.41c -K > $out
gmt makecpt    -Crainbow -T-50/2250/100 -Z > cape.cpt
gmt psscale    -Ccape.cpt -D6.5c/0.5c+w10c/0.5c+jTC+h -Bxaf+l"CAPE J/Kg" -O -K >> $out
gmt grdimage    cape_mean.nc -R -J -Ccape.cpt -O -K >> $out 
gmt pscoast    -R -J -N1 -W -B -O -K -Lx7.5/-2+c-26.5+w4500k+f >> $out
gmt grdcontour -W0 mslp_mean.nc -S4 -R -J -C2 -A2+f6 -T+lLH -O -K >> $out
gmt grdcontour -W1.7 zg500_mean.nc -A150+f6 -R -J -C150 -P -O -Gn1 -K >> $out

# Start plotting the individual days
gmt psbasemap  -R15/34/-36/-21 -JM10 -Bn -X42 -Y0 -O -K >> $out
gmt grdimage   cape5_org.nc -R -J -Ccape.cpt -O -K >> $out 
gmt pscoast    -R -JM -Na -W -O -K >> $out
gmt grdcontour -W0 mslp5_nrm.nc -S4 -R -J -C2 -A2+f6 -T+lLH -O -K >> $out
gmt grdcontour -W1.7 zg5005_nrm.nc -A150+f6 -R -J -C150 -P -O -Gn1 -K >> $out
gmt psxy       ZAF_adm1.gmt -R -J -K -O -W0.05 -V >> $out
echo "34 -34 19/10/2011" | gmt pstext -R -JM -O -K -F+jTR+f8 -T -Gwhite -W1p -Dj0.1 >> $out

gmt psbasemap  -R15/34/-36/-21 -JM10 -Bn -Y10 -O -K >> $out
gmt grdimage   cape4_org.nc -R -J -Ccape.cpt -O -K >> $out 
gmt pscoast    -R -JM -Na -W -O -K >> $out
gmt grdcontour -W0 mslp4_nrm.nc -S4 -R -J -C2 -A2+f6 -O -T+lLH -K >> $out
gmt grdcontour -W1.7 zg5004_nrm.nc -A150+f6 -R -J -C150 -P -O -Gn1 -K >> $out
gmt psxy       ZAF_adm1.gmt -R -J -K -O -W0.05 -V >> $out
echo "34 -34 08/11/2012" | gmt pstext -R -JM -O -K -F+jTR+f8 -T -Gwhite -W1p -Dj0.1 >> $out

gmt psbasemap  -R15/34/-36/-21 -JM10 -Bn -X11 -Y0 -O -K >> $out
gmt grdimage   cape3_org.nc -R -J -Ccape.cpt -O -K >> $out 
gmt pscoast    -R -JM -Na -W -O -K >> $out
gmt grdcontour -W0 mslp3_nrm.nc -S4 -R -J -C2 -A2+f6 -T+lLH -O -K >> $out
gmt grdcontour -W1.7 zg5003_nrm.nc -A150+f6 -R -J -C150 -P -O -Gn1 -K >> $out
gmt psxy       ZAF_adm1.gmt -R -J -K -O -W0.05 -V >> $out
echo "34 -34 09/11/2012" | gmt pstext -R -JM -O -K -F+jTR+f8 -T -Gwhite -W1p -Dj0.1 >> $out

gmt psbasemap  -R15/34/-36/-21 -JM10 -Bn -X-11 -Y10 -O -K >> $out
gmt grdimage   cape2_org.nc -R -J -Ccape.cpt -O -K >> $out 
gmt pscoast    -R -JM -Na -W -O -K >> $out
gmt grdcontour -W0 mslp2_nrm.nc -S4 -R -J -C2 -A2+f6 -T+lLH -O -K >> $out
gmt grdcontour -W1.7 zg5002_nrm.nc -A150+f6 -R -J -C150 -P -O -Gn1 -K >> $out
gmt psxy       ZAF_adm1.gmt -R -J -K -O -W0.05 -V >> $out
echo "34 -34 11/11/2013" | gmt pstext -R -JM -O -K -F+jTR+f8 -T -Gwhite -W1p -Dj0.1 >> $out

gmt psbasemap  -R15/34/-36/-21 -JM10 -Bn -X11 -Y0 -O -K >> $out
gmt grdimage   cape_org.nc -R -J -Ccape.cpt -O -K >> $out 
gmt pscoast    -R -JM -Na -W -O -K >> $out
gmt grdcontour -W0 mslp_nrm.nc -S4 -R -J -C2 -A2+f6 -T+lLH -O -K >> $out
gmt grdcontour -W1.7 zg500_nrm.nc -A150+f6 -R -J -C150 -P -O -Gn1 -K >> $out
gmt psxy       ZAF_adm1.gmt -R -J -K -O -W0.05 -V >> $out
echo "34 -34 28/11/2013" | gmt pstext -R -JM -O -K -F+jTR+f8 -T -Gwhite -W1p -Dj0.1 >> $out

gmt logo -R -J -DjTR+o-0/10+w10 -Y-11 -O -K >> $out
