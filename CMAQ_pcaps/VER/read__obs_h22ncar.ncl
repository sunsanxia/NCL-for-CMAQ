;******Code for plot vertical profiles. This code is written for the format of NCAR soundings and wrfouts. 
;*******Written by Xia Sun, 26 September 2018, emsunxia@gmail.com***************
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
begin
;print(nfili)
datename="/data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/H22_NCAR_OBS.csv"
delim=","
vars=asciiread(datename, -1, "string")
obsdate=tointeger(str_get_field(vars(1::), 1, delim))
print(obsdate)

obstime=tointeger(str_get_field(vars(1::), 2, delim))
print(obstime)

wrfi=tointeger(str_get_field(vars(1::), 4, delim))
print(wrfi)
obsh22=tofloat(str_get_field(vars(1::), 3, delim))
print(obsh22)
obsh22all=new(744,float)
do i=0,743
   obsh22all(i)=999
end do 
do i=0,743
    do j=0, 65
       if (i.eq.wrfi(j))
         obsh22all(i)=obsh22(j)
       end if
    end do
end do
print(obsh22all)
obsh22all@_FillValue = 999
fils1 = systemfunc("ls /data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/wrfoutJan/ACM2/wrfout_d02*")
f1 = addfiles(fils1,"r")
time=wrf_user_getvar(f1, "times", -1)
print(time(wrfi(65)))

wrfh22name="/data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/H22_WRF_NACR_READ.csv"
delim2=","
wrfvars=asciiread(wrfh22name, -1, "string")
wrftime=tointeger(str_get_field(wrfvars(1::), 1, delim2))
print(wrftime)
h22acm2=tofloat(str_get_field(wrfvars(1::), 2, delim2))
h22ysu=tofloat(str_get_field(wrfvars(1::), 3, delim2))
h22myj=tofloat(str_get_field(wrfvars(1::), 4, delim2))
print(h22acm2)

wks=gsn_open_wks("png", "H22_WRF_OBS")
res=True
res@gsnMaximize=True
res@pmLegendDisplayMode="Always"
;res@tiYAxisString="PBLH (m)"
res@xyExplicitLegendLabels = (/"NAM_MYJ","NAM_YSU","NAM_ACM2"/)
res@xyLineColors=(/"green","blue","red"/)
res@lgPerimOn = False
res@lgLabelFontHeightF=0.015
res@lgBoxMinorExtentF=0.1
res@pmLegendHeightF=0.07
res@pmLegendParallelPosF=0.8
res@pmLegendOrthogonalPosF=-1.3
res@tiXAxisString="Date (MST)"
res@xyLineThicknesses=(/4,4,4/)
res@xyDashPatterns=(/0,0,0/)
res@vpWidthF=0.8
res@vpHeightF=0.3

dataH22=new((/3,744/),float)
dataH22(0,:)=h22myj
dataH22(1,:)=h22ysu
dataH22(2,:)=h22acm2

resobs=True
resobs@gsnMaximize=True
resobs@pmLegendDisplayMode="Always"
resobs@xyExplicitLegendLabels = (/"OBS"/)
;resmcip@xyLineColors=(/"orange"/)
resobs@xyMarkLineMode="Markers"
resobs@xyMarker=16
resobs@xyMarkerSizeF=6
resobs@xyMarkerColor="black"
resobs@lgPerimOn = False
resobs@lgLabelFontHeightF=0.015
resobs@lgBoxMinorExtentF=0.1
resobs@pmLegendHeightF=0.05
resobs@pmLegendParallelPosF=0.75
resobs@pmLegendOrthogonalPosF=-0.93

ctime=wrf_times_c(f1[:]->Times,0)
utahtime=ctime-7 ;MST time

res@trXMinF=utahtime(0)
res@trXMaxF=utahtime(743)

copy_VarAtts(ctime, utahtime)
restick=True
restick@ttmFormat="%D-%c"
;restick@ttmMinorStride=23
restick@ttmValues=(/(/2011,1,1,0,0,0/),\
                     (/2011,1,6,0,0,0/),\
                     (/2011,1,11,0,0,0/),\
                     (/2011,1,16,0,0,0/),\
                     (/2011,1,21,0,0,0/),\
                     (/2011,1,26,0,0,0/),\
                     (/2011,1,31,0,0,0/)/)

time_axis_labels(utahtime, res, restick)
plot=gsn_csm_xy2(wks,utahtime,dataH22,obsh22all,res,resobs)
end
