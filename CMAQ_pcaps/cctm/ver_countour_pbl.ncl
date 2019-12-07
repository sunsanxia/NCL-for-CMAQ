load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
begin
hwlat=40.7364
hwlon=-111.8722
llres = True
  llres@ReturnInt = True ; Return integer values
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
do k=0,3,1
cmaqdata=addfile("/data/gpfs/home/xsun/CMAQ_v5.2/data/POST/COMBINE_CONC_v52_intel_4UTWY1_"+SCEN(k)+"_201101.nc","r")
wrfdatafile=systemfunc("ls /data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/wrfoutJan/"+SCEN(k)+"/wrfout_d02*")
wrfdata = addfiles(wrfdatafile,"r")
; Return integer values
    locij1 = wrf_user_ll_to_ij(wrfdata, hwlon, hwlat, llres)
  locij1 = locij1 -1
  locX1 = locij1(0)
  locY1 = locij1(1)

  timess = wrf_times_c(wrfdata[:]->Times,0)

  
  times = timess -7  
  copy_VarAtts(timess, times);
 wrfheight=wrf_user_getvar(wrfdata, "height", -1)
 heighhw=wrfheight(:,:,locY1,locX1)
  ;times=wrf_user_getvar(wrfdata, "times", -1)
pres=wrfdata[:]->PSFC
preshw=pres(:,locY1,locX1)
npreshw=dimsizes(preshw)
;print(npreshw)
ter=wrf_user_getvar(wrfdata, "ter", -1)
terhw=ter(0,locY1,locX1)
hno3=cmaqdata->HNO3
hno3hw=hno3(:,:,66,61)
pblh=cmaqdata->PBLH
pblhhw=pblh(:,0,66,61)
nhnowhw=dimsizes(hno3hw)
;print(hno3hw)
sfctmp=cmaqdata->SFC_TMP
sfctmphw=sfctmp(:,:,66,61)
nh3=cmaqdata->NH3
nh3hw=nh3(:,:,66,61)
pm25no3=cmaqdata->PM25_NO3
pm25no3hw=pm25no3(:,:,66,61)
pm25nh4=cmaqdata->PM25_NH4
pm25nh4hw=pm25nh4(:,:,66,61)
pm25frm=cmaqdata->PM25_FRM
pm25frmhw=pm25frm(:,:,66,61)
printVarSummary(pm25frmhw)
;copy_VarAtts(heighhw, pm25frmhw)
heighhww=transpose(heighhw)
wks1=gsn_open_wks("png", SCEN(k)+"Ver_Col_PM_cctm_PBLH")
pm25frmhww=transpose(pm25frmhw)
printVarSummary(heighhww)

pm25frmhww!0="height"
pm25frmhww&height=heighhww(:,18)-terhw
pm25frmhww!1= "time"
pm25frmhww&time = times
printVarSummary(pm25frmhww)


res=True
res@gsnMaximize=True
res@cnFillPalette="BlGrYeOrReVi200"
;res@cnFillPalette="WhiteBlueGreenYellowRed"
res@cnFillOn = True
res@cnLinesOn=False
res@cnLineLabelsOn=False
res@cnInfoLabelOn=False
res@gsnLeftString=" "
res@gsnRightString=" "
;res@pmLegendDisplayMode="Always"
;res@cnLevelSelectionMode = "ManualLevels"
;res@cnMinLevelValF = 0
;res@cnMaxLevelValF = 28
  res@cnLevelSelectionMode="ExplicitLevels"
  res@cnLevels=(/1,3,5,7,9,11,14,17,20,23,26/)
   ; res@cnLevelSpacingF=4
    res@lbBoxLinesOn = False
    res@lbBoxSeparatorLinesOn= False
    res@lbPerimOn=False
    res@lbLabelFontHeightF=0.015
   ;res@lbLabelStride= 5
   ;res@cnExplicitLabelBarLabelsOn=True
   ;res@lbLabelStrings=(/"5","10","15","20","25","30"/)
   
  
 
;res@tiYAxisString="PBLH (m)"
;res@xyExplicitLegendLabels = (/"NAM_MYJ","NAM_YSU","NAM_ACM2"/)
;res@xyLineColors=(/"green","blue","red"/)
res@gsnYAxisIrregular2Linear=True
res@lgPerimOn = False
res@lgLabelFontHeightF=0.02
res@lgBoxMinorExtentF=0.1
res@tmXTOn="False"
res@tmYROn="False"
;res@pmLegendHeightF=0.15
;res@pmLegendParallelPosF=0.84
;res@pmLegendOrthogonalPosF=-1.16
res@tiXAxisString="Date (MST)"
res@trYMinF=10
res@trYMaxF=1200
res@vpWidthF=0.8
res@vpHeightF=0.3

res1=res
res1@gsnDraw = False
res1@gsnFrame = False
;res1@tmXBMode="Explicit"
;res1@tmXBMinorValues=(/7,31,55,79,103,151,199,223,247,271,295,319,367,391,415,439,463,487,535,559,583,607,631,655,703,727/)
res1@tiYAxisString="Height (AGL)"
res1@trXMinF = times(0)
 restick = True
   restick@ttmFormat = "%D-%c"
 restick@ttmValues=(/(/2011,01,01,0,0,0/),\
                     (/2011,01,08,0,0,0/),\
                     (/2011,01,15,0,0,0/),\
                     (/2011,01,22,0,0,0/),\
                     (/2011,01,29,0,0,0/)/)
restick@ttmMinorStride=24

   time_axis_labels(times,res1,restick)

plot1=gsn_csm_contour(wks1,pm25frmhww,res1)

res2=True
res2@gsnDraw = False
res2@gsnFrame = False
;res2@gsnYAxisIrregular2Linear=True
res2@tmXTOn="False"
res2@tmYROn="False"
res2@xyLineColor="black"
res2@xyLineThicknessF=3.0
;res2@xyDashPattern = 1
;res@pmLegendHeightF=0.15
;res@pmLegendParallelPosF=0.84
;res@pmLegendOrthogonalPosF=-1.16
;res@tiXAxisString="Date (MST)"
res2@trYMinF=10
res2@trYMaxF=1200
res2@vpWidthF=0.8
res2@vpHeightF=0.3
res2@trXMinF = times(7)
time_axis_labels(times,res2,restick)
plot2=gsn_csm_xy(wks1,times,pblhhw,res2)

overlay(plot1,plot2)
draw(plot1)
frame(wks1)
delete(wks1)
end do
    
end