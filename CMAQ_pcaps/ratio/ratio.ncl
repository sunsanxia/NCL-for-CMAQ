;******Code for calculte the daily averages from hourly measurements************** 
;*******Written by Xia Sun, 9 Oct 2018, emsunxia@gmail.com***************
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
begin
;SCEN="myj"
;PCAP="Y"
;if (PCAP.eq."Y")
 ; count=2762
;else count=4294
;end if
count=7057
obssite=490353006
SCEN=new(4,"string")
SCEN(0)="ACM2"
SCEN(1)="YSU"
SCEN(2)="MYJ"
SCEN(3)="MYNN"
SCENW=new(4,"string")
SCENW(0)="acm2"
SCENW(1)="ysu"
SCENW(2)="myj"
SCENW(3)="mynn"
pm25=new((/4,744/),float)
ratioo=new((/4,744/),float)
pm25@_FillValue = -999
ratioo@_FillValue = -999


hwlat=40.7364
hwlon=-111.8722
llres = True
  llres@ReturnInt = True ; Return integer values
  
do k=0,3,1
cmaqdatafile=systemfunc("ls /data/gpfs/home/xsun/CMAQ_v5.2/data/"+SCEN(k)+"_output_CCTM_v52_intel_4UTWY1/CCTM_ACONC_v52_intel_4UTWY1_201101*.nc")
wrfdatafile=systemfunc("ls /data/gpfs/home/xsun/ataq_xsun/soft/CMAQ/CMAQ_v5.2/data/wrf/"+SCEN(k)+"_pcaps/wrfout_d02_2011-01*")
wrfdata = addfiles(wrfdatafile,"r")
cmaqdata = addfiles(cmaqdatafile, "r")
pmdatafile = systemfunc("ls /data/gpfs/home/xsun/CMAQ_v5.2/data/"+SCEN(k)+"_output_CCTM_v52_intel_4UTWY1/CCTM_PMDIAG_v52_intel_4UTWY1_201101*.nc")
pmdata = addfiles(pmdatafile, "r")
combdata=addfile("//data/gpfs/home/xsun/ataq_xsun/soft/CMAQ/CMAQ_v5.2/data/POST/COMBINE_ACONC_v52_intel_4UTWY1_"+SCEN(k)+"_201101.nc","r")
; Return integer values
    locij1 = wrf_user_ll_to_ij(wrfdata, hwlon, hwlat, llres)
  locij1 = locij1 -1
  locX1 = locij1(0)
  locY1 = locij1(1)

  timess = wrf_times_c(wrfdata[:]->Times,0)

  
  times = timess -7  
  copy_VarAtts(timess, times);
  ;times=wrf_user_getvar(wrfdata, "times", -1)
pres=wrfdata[:]->PSFC

preshw=pres(:,locY1,locX1)
printVarSummary(preshw)
npreshw=dimsizes(preshw)
;print(npreshw)
hno3=combdata->HNO3
hno3hw=hno3(:,0,66,61)
nhnowhw=dimsizes(hno3hw)
;print(hno3hw)
sfctmp=combdata->SFC_TMP
sfctmphw=sfctmp(:,0,66,61)
printVarSummary(sfctmphw)
nh3=combdata->NH3
nh3hw=nh3(:,0,66,61)
anh4i=cmaqdata[:]->ANH4I
anh4ihw=anh4i(:,0,66,61)
anh4j=cmaqdata[:]->ANH4J
anh4jhw=anh4j(:,0,66,61)
anh4k=cmaqdata[:]->ANH4K
anh4khw=anh4k(:,0,66,61)
printVarSummary(anh4khw)
ano3i=cmaqdata[:]->ANO3I
ano3ihw=ano3i(:,0,66,61)
ano3j=cmaqdata[:]->ANO3J
ano3jhw=ano3j(:,0,66,61)
ano3k=cmaqdata[:]->ANO3K
ano3khw=ano3k(:,0,66,61)


pm1at=pmdata[:]->PM1AT
pm1ac=pmdata[:]->PM1AC
pm1co=pmdata[:]->PM1CO
pm1athw=pm1at(:,0,66,61)
pm1achw=pm1ac(:,0,66,61)
pm1cohw=pm1co(:,0,66,61)
;printVarSummary (anh4i)
printVarSummary(pm1achw)
pm1nh4hw=anh4ihw*pm1athw+anh4jhw*pm1achw+anh4khw*pm1cohw
pm1no3hw=ano3ihw*pm1athw+ano3jhw*pm1achw+ano3khw*pm1cohw
pm1tot=combdata->PM1_TOT
pm1tothw=pm1tot(:,0,66,61)

molhno3=hno3hw*preshw*(1e-9)/1013.25/(sfctmphw+273.15)/0.0821
molnh3=nh3hw*preshw*(1e-9)/1013.25/(sfctmphw+273.15)/0.0821
molno3=pm1no3hw*(1e-9)/62.0049
molnh4=pm1nh4hw*(1e-9)/18.038
ratio=(molhno3+molno3)/(molnh3+molnh4)
pm25(k,:)=pm1tothw
ratioo(k,:)=ratio

end do

wks1=gsn_open_wks("png", "ratio")
wks2=gsn_open_wks("png","ratio_time")

res=True
res@gsnMaximize=True
res@pmLegendDisplayMode="Always"
;res@gsnDraw="False"
res@gsnFrame=False
;res@tiYAxisString="PBLH (m)"
res@xyExplicitLegendLabels = (/"ModMYNN","ModMYJ","ModYSU","ModACM2"/)
;res@xyLineColors=(/"darkgoldenrod","green","blue","red"/)
res@lgPerimOn = False
res@lgLabelFontHeightF=0.02
res@lgBoxMinorExtentF=0.1
res@pmLegendHeightF=0.15
res@pmLegendParallelPosF=0.82
res@pmLegendOrthogonalPosF=-1.2
res@tmXTOn="False"
res@tmYROn="False"

res@xyMarkLineMode="Markers"
;res@xyDashPattern=0
res@xyMarkers=(/4,4,4,4/)
res@xyMarkerColors=(/"darkgoldenrod","green","blue","red"/)
res@xyMarkerThicknessF=4.0
;res@xyLineThicknessF=5
res@xyMarkerSizeF=0.01

res@trYMaxF=1.5
;res@trYMinF=0.001
;res@trXMaxF=23
;res@vpWidthF=0.8
;res@vpHeightF=0.8
res@tmYLMode = "Explicit"
res@tmYLValues=(/0,0.2,0.4,0.6,0.8,1.0,1.2,1.4/)
res@tmYLLabels=(/0,0.2,0.4,0.6,0.8,1.0,1.2,1.4/)
res1=res
;res1@trXLog = True 
res1@tiYAxisString="Oxidized/Reduced Nitrogen"
res1@tiXAxisString="PM~B~2.5~N~ (~F33~m~F21~g.m~S~-3~N~)"
;res1@trXMaxF=maxpm
res1@trXMinF=0
;res1@tmYLMode = "Explicit"
;res1@tmYLValues=(/0,0.5,1.0,1.5/)
;res1@gsnDraw=False
res2=res
res2@trXMinF = times(6)
 restick = True
   restick@ttmFormat = "%D-%c"
 restick@ttmValues=(/(/2011,01,01,00,0,0/),\
                     (/2011,01,08,0,0,0/),\
                     (/2011,01,15,0,0,0/),\
                     (/2011,01,22,0,0,0/),\
                     (/2011,01,29,0,0,0/)/)

; restick@ttmMajorStride=12 ;change the lable numbers
 restick@ttmMinorStride=6
  time_axis_labels(times,res2,restick)
;dum=gsn_add_polyline(wks1, plot, x, y, res)
plot1=gsn_csm_xy(wks1,pm25(1,:),ratioo(0:3,:),res1)
plot2=gsn_csm_xy(wks2,times,ratioo(0:3,:),res2)

addres=True
addres@xyMarkLineMode="Line"
addres@gsLineDashPattern=1
addres@xyLineColor="black"
dumdata=new(744,float)
dumdata(:)=1
dum1=gsn_add_polyline(wks1, plot1, (/0,70/), (/1,1/), addres)


draw(plot1)
frame(wks1)
draw(plot2)
frame(wks2)

end     

