#!/bin/bash
#Use ISO2 country codes
visited="ZA,BW,NA,GB,ZM,MW,NL,CH,FR,FI,DE,BE,LU,CZ,US,RE,US,AT,ES"
usa="US.NC,US.SC,US.NY,US.VA,US.WY,US.MO,US.SD,US.TN,US.WV,US.KS,US.CO,US.MA,US.GA,US.MI,US.AZ,US.KY,US.NJ,US.PA,US.TX,US.DC,US.OR,US.ID,US.MS,US.CA,US.NE,US.NM,US.AL,US.IL,US.AL,US.LA,US.IA,US.MD"
# World
gmt pscoast -Rd -JN0/24 -Xc -Y33 -Bg30/g15 -Dh -E$visited+p0.25p,black+g100/255/100 -N1/0.25p,black -A1000 -Glightgray --PS_MEDIA=45.5cx30c -K > travelmap_world.ps
## Africa
gmt pscoast -R-20/55/-38/40 -JM12 -X-1.5 -Y-15 -Ba30f30/a30f15 -Dh -E$visited+p0.25p,black+g100/255/100 -A100 -N1/0.5p,black -Glightgray -O -K >> travelmap_world.ps
## Europe
gmt pscoast -R-20/50/35/72 -JL15/35/35/55/13c -X14 -Y1.5 -B10a0 -Dh -E$visited+p0.25p,black+g100/255/100 -Glightgrey -N1/0.5p,black -A100 -O -K >> travelmap_world.ps
## North America
gmt pscoast -R-130/-70/24/52 -JL-100/35/33/45/24c -X-12 -Y-17 -B10a0 -Dh -E$usa+p0.25p,black+g100/255/100 -N1/0.5p,black -Glightgrey -O -K >> travelmap_world.ps
