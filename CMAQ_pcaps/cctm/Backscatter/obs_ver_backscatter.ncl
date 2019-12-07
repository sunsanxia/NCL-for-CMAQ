load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
begin
;wrfdatafile=systemfunc("ls /data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/wrfoutJan/ACM2/wrfout_d02*")
wrfdata = addfiles("/data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/wrfoutJan/ACM2/wrfout_d02_2011-01-02_00:00:00","r")
hwlat=40.7364
hwlon=-111.872
 llres = True
  llres@ReturnInt = True ;
   locij1 = wrf_user_ll_to_ij(wrfdata, hwlon, hwlat, llres)
  locij1 = locij1 -1
  locX1 = locij1(0)
  locY1 = locij1(1)
  ter=wrf_user_getvar(wrfdata, "ter", -1)
terhw=ter(0,locY1,locX1)


 file1=addfile("IOP09.nc","r")
bctime=file1->unix_time
bcheight=file1->height
bc =file1->backscatter
temfile=addfile("/data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/LareauData/PCAPS_TIMEHEIGHT.nc","r")
temtime=temfile->time  ;hourly
theta=temfile->Theta
temheight=temfile->height
temheight2=temheight-terhw
timenfile="./Time_TIMEHEIGHT_IOP9.csv"
delim=","
timenvars=asciiread(timenfile, -1, "string")
timen=tofloat(str_get_field(timenvars(0::), 3, delim))

theta!1="timen"
theta&timen=timen
theta!0="height"
theta&height=temheight2

bctimefile="./Time_BC.csv"
bctimevars=asciiread(bctimefile, -1, "string")
bctimen=tofloat(str_get_field(bctimevars(0::), 3, delim))
bc!1="timecount"
bc&timecount=bctimen
wks1=gsn_open_wks("png", "OBS_BC_TH_timeheight_IOP9")
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
res@cnLevelSelectionMode = "ManualLevels"
res@cnMinLevelValF = -8
 res@cnMaxLevelValF = -5
   res@cnLevelSpacingF=0.125
   res@lbLabelStride=8
   ; res@lbLabelStrings =  (/"1","4","7","10","13","16"/) 
   ;  res@cnLevelSelectionMode="ExplicitLevels"
 ; res@cnLevels=(/1,2,3,4,5,6,7,8,20,23,26/)
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
;res@pmLabelBarParallelPosF=0.8
res@pmLabelBarOrthogonalPosF=-0.01
;res@pmLegendHeightF=0.15
;res@pmLegendParallelPosF=0.6
;res@pmLegendOrthogonalPosF=-1.16
res@pmLabelBarWidthF=0.1
res@tiXAxisString="Date (MST)"
res@trYMinF=0
res@trYMaxF=1200
res@vpWidthF=1.0
res@vpHeightF=0.3
res@lbOrientation =   "vertical"

res1=res
res1@gsnDraw = False
res1@gsnFrame = False
res1@tiYAxisString="Height (m)"
res1@trXMinF = 340  ;01/26/2011 13:00 utc
res1@trXMaxF = 7140 ; 1/31/2011 06:00 utc
 ;restick = True
 ;  restick@ttmFormat = "%D-%c %h:%M"

; restick@ttmMinorStride=23
   ;time_axis_labels(timess,res1,restick)
  ; txres=True
   ;txres@txFontColor="white"
   ;txres@txFontHeightF=0.015
res1@tmXBMode="Explicit"
res1@tmXBValues=(/1440,2880,4320,5760,7200/)
res1@tmXBMinorValues=(/720,2160,3600,5040,6480/)
res1@tmXBLabels=(/"27-Jan 0:00", "28-Jan 0:00","29-Jan 0:00","30-Jan 0:00","31-Jan 0:00"/)
plot1=gsn_csm_contour(wks1,bc,res1)
 ;textt=gsn_add_text(wks1, plot1, text(k), timess(620), 2400, txres)  
  res2=True
    res2@gsnDraw=False
    res2@gsnFrame=False
    res2@gsnMaximize=True
    res2@cnFillOn = False
    res2@cnLinesOn = True
    res2@cnLineLabelsOn=False
res2@cnInfoLabelOn=False
res2@gsnLeftString=" "
res2@gsnRightString=" "
res2@trXMinF = 330
res2@trXMaxF = 7140
res2@cnLevelSelectionMode="ManualLevels"
res2@cnLevelSpacingF = 1.0
plot2=gsn_csm_contour(wks1,theta(:,1357:1471),res2)
overlay(plot1, plot2)
res3=True
res3=res2
res3@cnLevelSpacingF=5.0
res3@cnLineThicknessF=4.0
plot3=gsn_csm_contour(wks1,theta(:,1357:1471),res3)
overlay(plot1,plot3)
draw(plot1)
frame(wks1)    
end