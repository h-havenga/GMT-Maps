#!/bin/bash
             ###################################
             #           GMT 5.4.3             #
             #          wget 1.19.2            #
             #           CDO 1.9.2             #
             # NCEP/NOAA https://goo.gl/xP3X4L #
             #   SA Shapefile: Natural Earth   #
             #          MIT Licence            #
             ###################################

########################################################################
# DISCLAIMER:                                                          #
# This a simple program to make your own weather forecast using        #
# publicly available Global Forecasting (GFS) data. The main programs  # 
# used include WGET to grab gfs data from the NCEP/NOAA server,        #
# Climate Data Operators (CDO) to convert and modify the data where    #
# needed and the main program used here is Generic Mapping Tools (GMT).#
# GMT is used to perform mathematical functions on the datasets and to # 
# draw and plot the data over the desired area. All data and code is   #
# free to use and share, however, however, respect the license terms   #
# and conditions.                                                      #
#                                                                      #
# Please be aware that this is NOT an official weather forecast.       #
# The products created here should not be used in anyway or            #
# form to issue any kind of weather alerts as the South-African Weather#
# Service (SAWS) is the only recognized authority in South-Africa      #
# allowed to do so. It is not the authors job to argue the law. Instead#
# users are encouraged to use the products for education purposes.     #
########################################################################

# The script downloads the data for the current day
# Specify the forecast intervals in the forecast variable
# You can pull a forecast 6 days in advance, that would be 384 hours
today=$(date +"%Y%m%d00")
gfs=http://www.ftp.ncep.noaa.gov/data/nccf/com/gfs/prod/gfs
forecast=(06 12 18 24 30 36 42 48)

# Loop through the specified forecast times wanted and grab GFS data
for i in "${forecast[@]}" 
do 
    wget $gfs.$today/gfs.t00z.pgrb2.0p25.f0$i 
done

# For archive purposes we clip the data to South-Africa with cdo
# and convert GFS files to workable netcdf files
for i in "${forecast[@]}"  
do 
    cdo -sellonlatbox,-35,85,-85,0 gfs.t00z.pgrb2.0p25.f0$i gfs.$today.$i 
    cdo -f nc copy gfs.$today.$i ncfile$i.nc 
done

# Move clipped GFS files to an archive directory 
rm gfs.t00z.pgrb2.0p25.f*
mkdir -p "gfs_archive/gfs_$today"
mv gfs.* gfs_archive/gfs_$today

# Extract variables from the NC files for easy use in GMT
for i in "${forecast[@]}" 
do
    cdo selname,gh ncfile$i.nc geopotential$i.nc 
    cdo splitlevel geopotential$i.nc geopotential$i- 
    mv geopotential$i-050000* zg500$i.nc 
    rm geopotential$i*
done

# To plot the files in GMT we need to get the variables from the newly 
# created netcdf files by extracting only the variable we want.
for i in "${forecast[@]}" 
do
    gmt grdconvert ncfile$i.nc\?prmsl -Gmslp_nrm$i.nc
    gmt grdconvert zg500$i.nc\?gh     -Gzg500_nrm$i.nc
    gmt grdconvert ncfile$i.nc\?tcc   -Gcloudcover$i.nc
    gmt grdconvert ncfile$i.nc\?cape  -Gcape$i.nc
    gmt grdconvert ncfile$i.nc\?aptmp -Gaptmp$i.nc
done

# Do some math
# We standardize the pressure and convert Kelvin to Celsius
for i in "${forecast[@]}" 
do
    gmt grdmath mslp_nrm$i.nc 100 DIV = mslp_nrm$i.nc    
    gmt grdmath zg500_nrm$i.nc 10 DIV = zg500_nrm$i.nc    
    gmt grdmath cloudcover$i.nc 0 NAN = cloudcover$i.nc
    gmt grdmath aptmp$i.nc 273.15 SUB = aptmp$i.nc
done

# Make CAPE values below 250 NAN
for i in "${forecast[@]}"
do
    for number in {0..200}
    do
        gmt grdmath cape$i.nc $number NAN = cape$i.nc
    done
done

            ######################################
            #               Plot                 #
            ######################################

# Coordinates (actually lower left and upper right not E S W N) 
# Projection (Lambert Azimuthal Equal-Area)
coord=(-20/-46/60/-12r)
width=25.5

# First a map with Cloudcover, zg500 and mslp
for i in "${forecast[@]}" 
do
    gmt psbasemap  -R$coord -JA25/-30/$width -Xc -Yc -Ba0 -B+t"Cloud Cover Forecast $(date +"%Y-%m-%d-00:00") + $i Hours" -K > cloud_map$i.ps
    gmt makecpt    -Cgebco -T1/100/5 -Z -I > cloud.cpt
    gmt pscoast    -R -JA -Df -N1 -G200 -W -O -K >> cloud_map$i.ps
    gmt grdimage   -R cloudcover$i.nc -Ccloud.cpt -J -O -Q -K >> cloud_map$i.ps  
    gmt grdcontour -R -JA -Wthinnest,-- mslp_nrm$i.nc -C2 -A2+f10 -T+lLH -O -K >> cloud_map$i.ps
    gmt grdcontour -R -JA -Wthick,black zg500_nrm$i.nc -S150 -C10 -A20+f14 -Gn1 -T+lLH -O -K >> cloud_map$i.ps
    gmt psxy        ZAF_adm1.gmt -R -JA -O -Wfaint -V -K >> cloud_map$i.ps
    gmt psscale    -Ccloud.cpt -R -J -Dx12.25c/-1c+w12c/0.5c+jTC+h -Bx10+l"Cloud Cover" -By+l% -O -K >> cloud_map$i.ps
done

# Make a animation
convert -bordercolor white -border 0 -layers OptimizePlus -density 300 -delay 2x1 cloud*.ps -loop 0 cloud_$(date "+%Y%m%d").gif
convert cloud_$(date "+%Y%m%d").gif -rotate 90  cloud_$(date "+%Y%m%d").gif

# Second a map with CAPE, zg500 and mslp
for i in "${forecast[@]}" 
do
    gmt psbasemap  -R$coord -JA25/-30/$width -Xc -Yc -Ba0 -B+t"CAPE Forecast $(date +"%Y-%m-%d-00:00") + $i Hours" -K > cape_map$i.ps
    gmt makecpt    -Chot -T250/2000/50 -Z -I > cape.cpt
    gmt pscoast    -R -JA -Df -N1 -G200 -W -O -K >> cape_map$i.ps
    gmt grdimage   -R cape$i.nc -Ccape.cpt -J -O -Q -K >> cape_map$i.ps  
    gmt grdcontour -R -JA -Wthinnest,-- mslp_nrm$i.nc -C2 -A2+f10 -T+lLH -O -K >> cape_map$i.ps
    gmt grdcontour -R -JA -Wthick,black zg500_nrm$i.nc -S150 -C10 -A20+f14 -Gn1 -T+lLH -O -K >> cape_map$i.ps
    gmt psxy        ZAF_adm1.gmt -R -JA -O -Wfaint -V -K >> cape_map$i.ps
    gmt psscale    -Ccape.cpt -R -J -Dx12.25c/-1c+w12c/0.5c+jTC+h -Bx150+l"CAPE J/Kg" -By+lJ/kg -O -K >> cape_map$i.ps
done

# Make a animation
convert -bordercolor white -border 0 -layers OptimizePlus -density 300 -delay 2x1 cape*.ps -loop 0 cape_$(date "+%Y%m%d").gif
convert cape_$(date "+%Y%m%d").gif -rotate 90 cape_$(date "+%Y%m%d").gif

# Third a map with temperature, zg500 and mslp
for i in "${forecast[@]}" 
do
    gmt psbasemap  -R$coord -JA25/-30/$width -Xc -Yc -Ba0 -B+t"Apparent Temperature $(date +"%Y-%m-%d-00:00") + $i Hours" -K > aptmp_map$i.ps
    gmt makecpt    -Cjet -T-8/43/1 -Z > aptmp.cpt
    gmt grdimage   -R aptmp$i.nc -Captmp.cpt -J -O -Q -K >> aptmp_map$i.ps  
    gmt pscoast    -R -JA -Df -N1 -W -O -K >> aptmp_map$i.ps
    gmt grdcontour -R -JA -Wthinnest,-- mslp_nrm$i.nc -C2 -A2+f10 -T+lLH -O -K >> aptmp_map$i.ps
    gmt grdcontour -R -JA -Wthick,black zg500_nrm$i.nc -S150 -C10 -A20+f14 -Gn1 -T+lLH -O -K >> aptmp_map$i.ps
    gmt psxy        ZAF_adm1.gmt -R -JA -O -Wfaint -V -K >> aptmp_map$i.ps
    gmt psscale    -Captmp.cpt -R -J -Dx12.25c/-1c+w12c/0.5c+jTC+h -Bx5+l"Temperature" -By+lCelcuis -O -K >> aptmp_map$i.ps
done

# Make a animation
convert -bordercolor white -border 0 -layers OptimizePlus -density 300 -delay 2x1 aptmp*.ps -loop 0 aptmp_$(date "+%Y%m%d").gif
convert aptmp_$(date "+%Y%m%d").gif -rotate 90  aptmp_$(date "+%Y%m%d").gif

# Last map zg500 and mslp
for i in "${forecast[@]}" 
do
    gmt psbasemap  -R$coord -JA25/-30/$width -Xc -Yc -Ba0 -B+t"Synoptic Weather Map $(date +"%Y-%m-%d-00:00") + $i Hours" -K > synoptic$i.ps
    gmt pscoast    -R -JA -Df -N1 -G200 -W -O -K >> synoptic$i.ps
    gmt grdcontour -R -JA -Wthinnest,-- mslp_nrm$i.nc -C2 -A2+f10 -T+lLH -O -K >> synoptic$i.ps
    gmt grdcontour -R -JA -Wthick,black zg500_nrm$i.nc -S150 -C10 -A20+f14 -Gn1 -T+lLH -O -K >> synoptic$i.ps
    gmt psxy        ZAF_adm1.gmt -R -JA -O -Wfaint -V -K >> synoptic$i.ps
done

# Make a animation
convert -bordercolor white -border 0 -layers OptimizePlus -density 300 -delay 2x1 synoptic*.ps -loop 0 synoptic_$(date "+%Y%m%d").gif
convert synoptic_$(date "+%Y%m%d").gif -rotate 90 synoptic_$(date "+%Y%m%d").gif

# Move eps and gif 
mkdir -p "ps/$today"
mkdir -p "gif/$today"
mv *ps ps/$today
mv *gif gif/$today

# The data is quite big, because the netcdf files are a product of the
# gfs files you can remove all netcdf files and compress the gfs
# file for archive purposes.
rm *.nc

exit 0
