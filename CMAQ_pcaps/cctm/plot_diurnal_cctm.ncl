load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
begin
scen="nonpcaps" ;pcaps
;scen="pcaps" 
diurnalfile="/data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/cctm/Diurnal_CCTM_"+scen+"_HW.csv"

delim=","
vars=asciiread(diurnalfile, -1, "string")
delim=","
hr=tointeger(str_get_field(vars(1::),1,delim))
print(hr(0))
hnh31=tofloat(str_get_field(vars(1::), 2, delim))
hnh32=tofloat(str_get_field(vars(1::), 3, delim))
hnh33=tofloat(str_get_field(vars(1::), 4, delim))

hN2O51=tofloat(str_get_field(vars(1::), 5, delim))
hN2O52=tofloat(str_get_field(vars(1::), 6, delim))
hN2O53=tofloat(str_get_field(vars(1::), 7, delim))

hNHX1=tofloat(str_get_field(vars(1::), 8, delim))
hNHX2=tofloat(str_get_field(vars(1::), 9, delim))
hNHX3=tofloat(str_get_field(vars(1::), 10, delim))

hPM25_NH41=tofloat(str_get_field(vars(1::), 11, delim))
hPM25_NH42=tofloat(str_get_field(vars(1::), 12, delim))
hPM25_NH43=tofloat(str_get_field(vars(1::), 13, delim))

hPM25_NO31=tofloat(str_get_field(vars(1::), 14, delim))
hPM25_NO32=tofloat(str_get_field(vars(1::), 15, delim))
hPM25_NO33=tofloat(str_get_field(vars(1::), 16, delim))

hPM25_OC1=tofloat(str_get_field(vars(1::), 17, delim))
hPM25_OC2=tofloat(str_get_field(vars(1::), 18, delim))
hPM25_OC3=tofloat(str_get_field(vars(1::), 19, delim))

hPM25_EC1=tofloat(str_get_field(vars(1::), 20, delim))
hPM25_EC2=tofloat(str_get_field(vars(1::), 21, delim))
hPM25_EC3=tofloat(str_get_field(vars(1::), 22, delim))

hPM25_SO41=tofloat(str_get_field(vars(1::), 23, delim))
hPM25_SO42=tofloat(str_get_field(vars(1::), 24, delim))
hPM25_SO43=tofloat(str_get_field(vars(1::), 25, delim))

wks1=gsn_open_wks("png", scen+"Diurnal_NH3_cctm")
wks2=gsn_open_wks("png", scen+"Diurnal_N2O5_cctm")
wks3=gsn_open_wks("png", scen+"Diurnal_NHX_cctm")
wks4=gsn_open_wks("png", scen+"Diurnal_PM25NH4_cctm")
wks5=gsn_open_wks("png", scen+"Diurnal_PM25NO3_cctm")
wks6=gsn_open_wks("png", scen+"Diurnal_PM25OC_cctm")
wks7=gsn_open_wks("png", scen+"Diurnal_PM25EC_cctm")
wks8=gsn_open_wks("png", scen+"Diurnal_PM25SO4_cctm")
datanh3=new((/3,24/),float)
datanh3(0,:)=hnh33
datanh3(1,:)=hnh32
datanh3(2,:)=hnh31

dataN2O5=new((/3,24/),float)
dataN2O5(0,:)=hN2O53
dataN2O5(1,:)=hN2O52
dataN2O5(2,:)=hN2O51

dataNHX=new((/3,24/),float)
dataNHX(0,:)=hNHX3
dataNHX(1,:)=hNHX2
dataNHX(2,:)=hNHX1

dataPM25_NH4=new((/3,24/),float)
dataPM25_NH4(0,:)=hPM25_NH43
dataPM25_NH4(1,:)=hPM25_NH42
dataPM25_NH4(2,:)=hPM25_NH41

dataPM25_NO3=new((/3,24/),float)
dataPM25_NO3(0,:)=hPM25_NO33
dataPM25_NO3(1,:)=hPM25_NO32
dataPM25_NO3(2,:)=hPM25_NO31

dataPM25_OC=new((/3,24/),float)
dataPM25_OC(0,:)=hPM25_OC3
dataPM25_OC(1,:)=hPM25_OC2
dataPM25_OC(2,:)=hPM25_OC1

dataPM25_EC=new((/3,24/),float)
dataPM25_EC(0,:)=hPM25_EC3
dataPM25_EC(1,:)=hPM25_EC2
dataPM25_EC(2,:)=hPM25_EC1

dataPM25_SO4=new((/3,24/),float)
dataPM25_SO4(0,:)=hPM25_SO43
dataPM25_SO4(1,:)=hPM25_SO42
dataPM25_SO4(2,:)=hPM25_SO41

res=True
res@gsnMaximize=True
res@pmLegendDisplayMode="Always"
;res@tiYAxisString="PBLH (m)"
res@xyExplicitLegendLabels = (/"NAM_MYJ","NAM_YSU","NAM_ACM2"/)
res@xyLineColors=(/"green","blue","red"/)
res@lgPerimOn = False
res@lgLabelFontHeightF=0.02
res@lgBoxMinorExtentF=0.1
res@pmLegendHeightF=0.15
res@pmLegendParallelPosF=0.84
res@pmLegendOrthogonalPosF=-1.16
res@tiXAxisString="Hour"
res@xyMarkLineMode="MarkLines"
res@xyDashPattern=0
res@xyMarkers=(/4,4,4/)
res@xyMarkerColors=(/"green","blue","red"/)
res@xyMarkerThicknessF=2.0
res@xyLineThicknessF=5
res@xyMarkerSizeF=0.01
res@trXMinF=0
res@trXMaxF=23
res@vpWidthF=0.8
res@vpHeightF=0.8
res1=res
res1@tiYAxisString="NH~B~3~N~ (ppb)"

res2=res
res2@tiYAxisString="N~B~2~N~O~B~5~N~ (ppb)"

res3=res
res3@tiYAxisString="NH~B~X~N~ (~F33~m~F21~g.m~S~-3~N~)"

res4=res
res4@tiYAxisString="NH~B~4~N~ (~F33~m~F21~g.m~S~-3~N~)"

res5=res
res5@tiYAxisString="NO~B~3~N~ (~F33~m~F21~g.m~S~-3~N~)"

res6=res
res6@tiYAxisString="OC (~F33~m~F21~g.m~S~-3~N~)"

res7=res
res7@tiYAxisString="EC (~F33~m~F21~g.m~S~-3~N~)"

res8=res
res8@tiYAxisString="SO~B~4~N~ (~F33~m~F21~g.m~S~-3~N~)"

plot1=gsn_csm_xy(wks1,hr,datanh3(:,0:23),res1)
plot2=gsn_csm_xy(wks2,hr,dataN2O5(:,0:23),res2)
plot3=gsn_csm_xy(wks3,hr,dataNHX(:,0:23),res3)
plot4=gsn_csm_xy(wks4,hr,dataPM25_NH4(:,0:23),res4)
plot5=gsn_csm_xy(wks5,hr,dataPM25_NO3(:,0:23),res5)
plot6=gsn_csm_xy(wks6,hr,dataPM25_OC(:,0:23),res6)
plot7=gsn_csm_xy(wks7,hr,dataPM25_EC(:,0:23),res7)
plot8=gsn_csm_xy(wks8,hr,dataPM25_SO4(:,0:23),res8)

    
end