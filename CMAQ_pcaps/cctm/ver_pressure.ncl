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
presfull=wrf_user_getvar(wrfdata, "pressure", -1)
presfullhw=presfull(:,:,locY1,locX1)
hno3=cmaqdata->HNO3
hno3hw=hno3(:,:,66,61)
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
;heighhww=transpose(heighhw)
wks1=gsn_open_wks("png", SCEN(k)+"Ver_Pres_PM_cctm")
;pm25frmhww=transpose(pm25frmhw)
;printVarSummary(heighhww)

;pm25frmhww!0="height"
;pm25frmhww&height=heighhww(:,18)-terhw
;pm25frmhww!1= "time"
;pm25frmhww&time = times
;printVarSummary(pm25frmhww)
dsizes_pressure=dimsizes(presfullhw)
ntim=dsizes_pressure(0)
klev=dsizes_pressure(1)
pm25frmhww=new((/klev,ntim/),float,"No_FillValue")
do i=0,ntim-1,1
  heighhww=heighhw(i,:)
  presfullhww=presfullhw(i,:)
  pm25frmhww(:,i)=(/pm25frmhw(i,:)/)

  pm25frmhww!0="pressure"
  pm25frmhww&pressure=presfullhww
  pm25frmhww&pressure@units="hPa"
end do
res=True
res@gsnMaximize=True
res@cnFillPalette="BlGrYeOrReVi200"
res@cnFillOn = True
res@cnLinesOn=False
res@tmYUseLeft= False
res@tmYRLabelsOn=True
res@tmYLMode = "Explicit"
res@tmYLLabelsOn= True
res@tmYLValues=(/1000,950,900,850,800/)
res@tmYLLabels=(/"1000","950","900","850","800"/)
res@tmYRTickSpacingF =1
;res@tmYRMode= "Explicit"
;res@tmYRValues=(/(0.2+terhw*0.001),(0.4+terhw*0.001),(0.8+terhw*0.001),(1.2+terhw*0.001),(1.6+terhw*0.001),(2.0+terhw*0.001),(2.4+terhw)*0.001/)
;res@tmYRLabels=(/"0.2","0.4","0.8","1.2","1.6","2.0","2.4"/)
res@vpWidthF = 0.8
  res@vpHeightF = 0.3
;res@pmLegendDisplayMode="Always"
 res@cnLevelSelectionMode = "ManualLevels"
  res@cnMinLevelValF = 5
  res@cnMaxLevelValF = 30
    res@cnLevelSpacingF=0.5
    res@lbBoxLinesOn = False
    res@lbBoxSeparatorLinesOn= False
    res@lbPerimOn=False
   res@lbLabelStride= 5
;    res@cnInfoLabelOn=False
;res@lbPerimOn=False
;res@tiYAxisString="PBLH (m)"
;res@xyExplicitLegendLabels = (/"NAM_MYJ","NAM_YSU","NAM_ACM2"/)
;res@xyLineColors=(/"green","blue","red"/)
;res@lgPerimOn = False
;res@lgLabelFontHeightF=0.02
;res@lgBoxMinorExtentF=0.1
;res@pmLegendHeightF=0.15
;res@pmLegendParallelPosF=0.84
;res@pmLegendOrthogonalPosF=-1.16
res@tiXAxisString="Date (MST)"
;res@trYMinF=0
;res@trYMaxF=3000
;res@vpWidthF=1.6
;res@vpHeightF=0.8
res1=res
res1@tiYAxisString="Height (AGL)"


plot1=gsn_csm_pres_hgt(wks1,pm25frmhww(0:20,:),res1)

end do
    
end