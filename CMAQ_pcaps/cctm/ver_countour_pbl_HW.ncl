load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
begin
yaxismax=1200
yaxismin=0
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
 colors=new(4,"string")
 colors(0)="red"
 colors(1)="blue"
 colors(2)="green"
 colors(3)="darkgoldenrod"
delim=","
wrfpblcalkslc="/data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/WRF_Ri_PBL_HW.csv"
wrfpblcalncar="/data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/WRF_Ri_PBL_NCAR.csv"
varskslc=asciiread(wrfpblcalkslc, -1, "string")
;wrfcalkslc=tofloat(str_get_field(varskslc(1::), 2, delim)
varsncar=asciiread(wrfpblcalncar, -1, "string")

delim=","
obspblcalkslc="/data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/LareauData/Obs_Pbl_Lidar_Bulk.csv"
varsobspblkslc=asciiread(obspblcalkslc, -1, "string")
numkslc=tointeger(str_get_field(varsobspblkslc(1::),1, delim))
print(numkslc)
obspblkslc=tofloat(str_get_field(varsobspblkslc(1::),2, delim))
print(obspblkslc(0))

obspblcalncar="/data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/Obs_Pbl_Ri_NCAR.csv"
varsobspblncar=asciiread(obspblcalncar, -1, "string")
obspblncar=tofloat(str_get_field(varsobspblncar(1::),2, delim))

numncar=tointeger(str_get_field(varsobspblncar(1::),1, delim))
print(obspblncar(0))
obspblkslc@_FillValue = -999
obspblncar@_FillValue = -999
countkslc=dimsizes(obspblkslc)
countncar=dimsizes(numncar)
newobspblkslc=new(744,float,-999)
newobspblkslc(:)=-999
newobspblncar=new(744,float,-999)
newobspblncar(:)=-999
print(countkslc)
print(countncar)




do k=0,3,1
cmaqdata=addfile("/data/gpfs/home/xsun/CMAQ_v5.2/data/POST/COMBINE_CONC_v52_intel_4UTWY1_"+SCEN(k)+"_201101.nc","r")
wrfdatafile=systemfunc("ls /data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/wrfoutJan/"+SCEN(k)+"/wrfout_d02*")
wrfdata = addfiles(wrfdatafile,"r")
; Return integer values

wrfpncar=tofloat(str_get_field(varsncar(1::), k+2, delim))-1325.0
;wrfpbl=(wrfpkslc+wrfpncar)/2.0
;print(wrfpkslc)
print(wrfpncar)
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
wrfpkslc=tofloat(str_get_field(varskslc(1::), k+2, delim))-terhw
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
wks1=gsn_open_wks("png", SCEN(k)+"HW_Ver_Col_PM_cctm_PBLH_Ri")
pm25frmhww=transpose(pm25frmhw)
printVarSummary(heighhww)

mstring = "y"
  fontnum = 35
  xoffset = 0.0
  yoffset = 0.0
  ratio   = 1.0
  size    = 1.0
  angle   = 0.0

  solsquare = NhlNewMarker(wks1, mstring, fontnum, xoffset, yoffset, ratio, size, angle)

mstring = "u"
  fontnum = 34
  xoffset = 0.0
  yoffset = 0.0
  ratio   = 1.0
  size    = 1.0
  angle   = 0.0

  soltri = NhlNewMarker(wks1, mstring, fontnum, xoffset, yoffset, ratio, size, angle)

pm25frmhww!0="height"
pm25frmhww&height=heighhww(:,18)-terhw
;pm25frmhww&height=heighhww(:,18)
pm25frmhww!1= "time"
pm25frmhww&time = times
printVarSummary(pm25frmhww)


res=True
res@gsnMaximize=True
res@cnFillMode="RasterFill"
res@cnRasterSmoothingOn=True
res@cnFillPalette="BlGrYeOrReVi200"
res@cnFillOn = True
res@cnLinesOn=False
res@cnLineLabelsOn=False
res@cnInfoLabelOn=False
res@gsnLeftString=" "
res@gsnRightString=" "
;res@pmLegendDisplayMode="Always"
;res@cnLevelSelectionMode = "ManualLevels"
;res@cnMinLevelValF = 5
 ; res@cnMaxLevelValF = 25
 ;   res@cnLevelSpacingF=0.5
     res@cnLevelSelectionMode="ExplicitLevels"
  res@cnLevels=(/1,3,5,7,9,11,14,17,20,23,26/)
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
res@trYMinF=yaxismin
res@trYMaxF=yaxismax
res@vpWidthF=0.8
res@vpHeightF=0.3

res1=res
res1@gsnDraw = False
res1@gsnFrame = False
res1@tiYAxisString="Height (AGL)"
res1@trXMinF = times(7)
 restick = True
   restick@ttmFormat = "%D-%c"
 restick@ttmValues=(/(/2011,01,01,00,0,0/),\
                     (/2011,01,08,0,0,0/),\
                     (/2011,01,15,0,0,0/),\
                     (/2011,01,22,0,0,0/),\
                     (/2011,01,29,0,0,0/)/)
; restick@ttmMinorStride=23
   time_axis_labels(times,res1,restick)

plot1=gsn_csm_contour(wks1,pm25frmhww,res1)

res2=True
res2@gsnDraw = False
res2@gsnFrame = False
res2@gsnYAxisIrregular2Linear=True
res2@tmXTOn="False"
res2@tmYROn="False"
res2@xyLineColor= "grey"
res2@xyDashPattern=0
res2@xyLineThicknessF =3.0
;res@pmLegendHeightF=0.15
;res@pmLegendParallelPosF=0.84
;res@pmLegendOrthogonalPosF=-1.16
;res@tiXAxisString="Date (MST)"
res2@trYMinF=yaxismin
res2@trYMaxF=yaxismax
res2@vpWidthF=0.8
res2@vpHeightF=0.3
res2@trXMinF = times(7)
res2@xyLineThicknessF=3.0
time_axis_labels(times,res2,restick)
plot2=gsn_csm_xy(wks1,times,pblhhw,res2)

overlay(plot1,plot2)
resmarker=True
resmarker@gsnDraw = False
resmarker@gsnFrame = False
resmarker@tmXTOn="False"
resmarker@tmYROn="False"
resmarker@xyMarkLineMode="Markers"
resmarker@trYMinF=yaxismin
resmarker@trYMaxF=yaxismax
resmarker@vpWidthF=0.8
resmarker@vpHeightF=0.3
resmarker@xyMarkerSizeF=0.01
resmarker@trXMinF = times(7)

res3=True
res3=resmarker
res3@xyMarker=2
;res@pmLegendHeightF=0.15
;res@pmLegendParallelPosF=0.84
;res@pmLegendOrthogonalPosF=-1.16
;res@tiXAxisString="Date (MST)"

time_axis_labels(times,res3,restick)
plot3=gsn_csm_xy(wks1,times,wrfpkslc,res3)
;overlay(plot1,plot3)


res4=True
res4=resmarker
res4@xyMarker=5

;res@pmLegendHeightF=0.15
;res@pmLegendParallelPosF=0.84
;res@pmLegendOrthogonalPosF=-1.16
;res@tiXAxisString="Date (MST)"
time_axis_labels(times,res4,restick)
plot4=gsn_csm_xy(wks1,times,wrfpncar,res4)
;overlay(plot1,plot4)

res7=True
res7=res2

res7@xyLineColor=colors(k)
res7@xyDashPattern=0
res7@xyLineThicknessF =3.0
time_axis_labels(times,res7,restick)
plot7=gsn_csm_xy(wks1,times,wrfpkslc,res7)
overlay(plot1,plot7)
  
res5=True
res5=resmarker
res5@gsMarkerIndex=2
res5@xyMarker= 16;solsquare
res5@xyMarkerColor="black"
res5@xyMarkerThicknessF=3.0
res5@xyMarkerSizeF=0.003
time_axis_labels(times,res5,restick)
plot5=gsn_csm_xy(wks1,times,(obspblkslc-1312.0),res5) ;THIS IS ACTUALLY HW 
overlay(plot1,plot5)





draw(plot1)
frame(wks1)

end do
    
end