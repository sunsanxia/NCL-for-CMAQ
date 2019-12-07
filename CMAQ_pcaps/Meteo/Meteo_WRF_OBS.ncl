;******Code for extract turbulent fluxes at seven sites PCAPS*************************************
;*******Written by Xia Sun, 28 Sep 2018, emsunxia@gmail.com***************
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
begin
  
fils1 = systemfunc("ls /data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/wrfoutJan/ACM2/wrfout_d02*")
f1 = addfiles(fils1,"r")
fils2 = systemfunc("ls /data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/wrfoutJan/YSU/wrfout_d02*")
f2 = addfiles(fils2,"r")
fils3 = systemfunc("ls /data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/wrfoutJan/MYJ/wrfout_d02*")
f3 = addfiles(fils3,"r")

f4 = addfile("/data/gpfs/home/xsun/CMAQ_v5.2/data/mcip/ACM2_pcaps/METCRO2D_PCAPs_ACM2.nc","r")
f5 = addfile("/data/gpfs/home/xsun/CMAQ_v5.2/data/mcip/YSU_pcaps/METCRO2D_PCAPs_YSU.nc","r")
f6 = addfile("/data/gpfs/home/xsun/CMAQ_v5.2/data/mcip/MYJ_pcaps/METCRO2D_PCAPs_MYJ.nc","r")


lat1 = 40.779
  lon1 = -112.103
lat2 = 40.738
  lon2 = -111.913
lat3 = 40.697
  lon3 = -111.839
  lat4 = 40.681
  lon4 = -111.995
  lat5 = 40.614
  lon5 = -111.804
  lat6 = 40.594
  lon6 = -112.062
  lat7 = 40.514
  lon7 = -111.974

  llres = True
  llres@ReturnInt = True ; Return integer values
    locij1 = wrf_user_ll_to_ij(f1, lon1, lat1, llres)
  locij1 = locij1 -1
  locX1 = locij1(0)
  locY1 = locij1(1)

  locij2 = wrf_user_ll_to_ij(f1, lon2, lat2, llres)
  locij2 = locij2 -1
  locX2 = locij2(0)
  locY2 = locij2(1)

  locij3 = wrf_user_ll_to_ij(f1, lon3, lat3, llres)
  locij3 = locij3 -1
  locX3 = locij3(0)
  locY3 = locij3(1)

  locij4 = wrf_user_ll_to_ij(f1, lon4, lat4, llres)
  locij4 = locij4 -1
  locX4 = locij4(0)
  locY4 = locij4(1)

  locij5 = wrf_user_ll_to_ij(f1, lon5, lat5, llres)
  locij5 = locij5 -1
  locX5 = locij5(0)
  locY5 = locij5(1)

  locij6 = wrf_user_ll_to_ij(f1, lon6, lat6, llres)
  locij6 = locij6 -1
  locX6 = locij6(0)
  locY6 = locij6(1)

  locij7 = wrf_user_ll_to_ij(f1, lon7, lat7, llres)
  locij7 = locij7 -1
  locX7 = locij7(0)
  locY7 = locij7(1)

   locY11=locY1-25
  locX11=locX1-22
     locY22=locY2-25
  locX22=locX2-22
     locY33=locY3-25
  locX33=locX3-22
     locY44=locY4-25
  locX44=locX4-22
     locY55=locY5-25
  locX55=locX5-22
     locY66=locY6-25
  locX66=locX6-22
     locY77=locY7-25
  locX77=locX7-22
  
  t2m1=f1[:]->T2
  t2m11=t2m1(:,locY1,locX1)
  t2m12=t2m1(:,locY2,locX2)
  t2m13=t2m1(:,locY3,locX3)
  t2m14=t2m1(:,locY4,locX4)
  t2m15=t2m1(:,locY5,locX5)
  t2m16=t2m1(:,locY6,locX6)
  t2m17=t2m1(:,locY7,locX7)

  t2m2=f2[:]->T2
  t2m21=t2m2(:,locY1,locX1)
  t2m22=t2m2(:,locY2,locX2)
  t2m23=t2m2(:,locY3,locX3)
  t2m24=t2m2(:,locY4,locX4)
  t2m25=t2m2(:,locY5,locX5)
  t2m26=t2m2(:,locY6,locX6)
  t2m27=t2m2(:,locY7,locX7)

  t2m3=f3[:]->T2
  t2m31=t2m3(:,locY1,locX1)
  t2m32=t2m3(:,locY2,locX2)
  t2m33=t2m3(:,locY3,locX3)
  t2m34=t2m3(:,locY4,locX4)
  t2m35=t2m3(:,locY5,locX5)
  t2m36=t2m3(:,locY6,locX6)
  t2m37=t2m3(:,locY7,locX7)
u10m1=f1[:]->U10
  u10m11=u10m1(:,locY1,locX1)
  u10m12=u10m1(:,locY2,locX2)
  u10m13=u10m1(:,locY3,locX3)
  u10m14=u10m1(:,locY4,locX4)
  u10m15=u10m1(:,locY5,locX5)
  u10m16=u10m1(:,locY6,locX6)
  u10m17=u10m1(:,locY7,locX7)

  u10m2=f2[:]->U10
  u10m21=u10m2(:,locY1,locX1)
  u10m22=u10m2(:,locY2,locX2)
  u10m23=u10m2(:,locY3,locX3)
  u10m24=u10m2(:,locY4,locX4)
  u10m25=u10m2(:,locY5,locX5)
  u10m26=u10m2(:,locY6,locX6)
  u10m27=u10m2(:,locY7,locX7)

  u10m3=f3[:]->U10
  u10m31=u10m3(:,locY1,locX1)
  u10m32=u10m3(:,locY2,locX2)
  u10m33=u10m3(:,locY3,locX3)
  u10m34=u10m3(:,locY4,locX4)
  u10m35=u10m3(:,locY5,locX5)
  u10m36=u10m3(:,locY6,locX6)
  u10m37=u10m3(:,locY7,locX7)

  
  v10m1=f1[:]->V10
  v10m11=v10m1(:,locY1,locX1)
  v10m12=v10m1(:,locY2,locX2)
  v10m13=v10m1(:,locY3,locX3)
  v10m14=v10m1(:,locY4,locX4)
  v10m15=v10m1(:,locY5,locX5)
  v10m16=v10m1(:,locY6,locX6)
  v10m17=v10m1(:,locY7,locX7)

  v10m2=f2[:]->V10
  v10m21=v10m2(:,locY1,locX1)
  v10m22=v10m2(:,locY2,locX2)
  v10m23=v10m2(:,locY3,locX3)
  v10m24=v10m2(:,locY4,locX4)
  v10m25=v10m2(:,locY5,locX5)
  v10m26=v10m2(:,locY6,locX6)
  v10m27=v10m2(:,locY7,locX7)

  v10m3=f3[:]->V10
  v10m31=v10m3(:,locY1,locX1)
  v10m32=v10m3(:,locY2,locX2)
  v10m33=v10m3(:,locY3,locX3)
  v10m34=v10m3(:,locY4,locX4)
  v10m35=v10m3(:,locY5,locX5)
  v10m36=v10m3(:,locY6,locX6)
  v10m37=v10m3(:,locY7,locX7)


  ws10m11=sqrt(u10m11^2+v10m11^2)
  ws10m12=sqrt(u10m12^2+v10m12^2)
  ws10m13=sqrt(u10m13^2+v10m13^2)
  ws10m14=sqrt(u10m14^2+v10m14^2)
  ws10m15=sqrt(u10m15^2+v10m15^2)
  ws10m16=sqrt(u10m16^2+v10m16^2)
  ws10m17=sqrt(u10m17^2+v10m17^2)

 ws10m21=sqrt(u10m21^2+v10m21^2)
  ws10m22=sqrt(u10m22^2+v10m22^2)
  ws10m23=sqrt(u10m23^2+v10m23^2)
  ws10m24=sqrt(u10m24^2+v10m24^2)
  ws10m25=sqrt(u10m25^2+v10m25^2)
  ws10m26=sqrt(u10m26^2+v10m26^2)
  ws10m27=sqrt(u10m27^2+v10m27^2)

   ws10m31=sqrt(u10m31^2+v10m31^2)
  ws10m32=sqrt(u10m32^2+v10m32^2)
  ws10m33=sqrt(u10m33^2+v10m33^2)
  ws10m34=sqrt(u10m34^2+v10m34^2)
  ws10m35=sqrt(u10m35^2+v10m35^2)
  ws10m36=sqrt(u10m36^2+v10m36^2)
  ws10m37=sqrt(u10m37^2+v10m37^2)

  rh1=wrf_user_getvar(f1,"Q2",-1)
  rh11=rh1(:,locY1,locX1)
  rh12=rh1(:,locY2,locX2)
  rh13=rh1(:,locY3,locX3)
  rh14=rh1(:,locY4,locX4)
  rh15=rh1(:,locY5,locX5)
  rh16=rh1(:,locY6,locX6)
  rh17=rh1(:,locY7,locX7)

  rh2=wrf_user_getvar(f2,"Q2",-1)
  rh21=rh2(:,locY1,locX1)
  rh22=rh2(:,locY2,locX2)
  rh23=rh2(:,locY3,locX3)
  rh24=rh2(:,locY4,locX4)
  rh25=rh2(:,locY5,locX5)
  rh26=rh2(:,locY6,locX6)
  rh27=rh2(:,locY7,locX7)

  rh3=wrf_user_getvar(f3,"Q2",-1)
  rh31=rh3(:,locY1,locX1)
  rh32=rh3(:,locY2,locX2)
  rh33=rh3(:,locY3,locX3)
  rh34=rh3(:,locY4,locX4)
  rh35=rh3(:,locY5,locX5)
  rh36=rh3(:,locY6,locX6)
  rh37=rh3(:,locY7,locX7)

 PSFC1=f1[:]->PSFC
  PSFC11=PSFC1(:,locY1,locX1)
  PSFC12=PSFC1(:,locY2,locX2)
  PSFC13=PSFC1(:,locY3,locX3)
  PSFC14=PSFC1(:,locY4,locX4)
  PSFC15=PSFC1(:,locY5,locX5)
  PSFC16=PSFC1(:,locY6,locX6)
  PSFC17=PSFC1(:,locY7,locX7)

  PSFC2=f2[:]->PSFC
  PSFC21=PSFC2(:,locY1,locX1)
  PSFC22=PSFC2(:,locY2,locX2)
  PSFC23=PSFC2(:,locY3,locX3)
  PSFC24=PSFC2(:,locY4,locX4)
  PSFC25=PSFC2(:,locY5,locX5)
  PSFC26=PSFC2(:,locY6,locX6)
  PSFC27=PSFC2(:,locY7,locX7)

  PSFC3=f3[:]->PSFC
  PSFC31=PSFC3(:,locY1,locX1)
  PSFC32=PSFC3(:,locY2,locX2)
  PSFC33=PSFC3(:,locY3,locX3)
  PSFC34=PSFC3(:,locY4,locX4)
  PSFC35=PSFC3(:,locY5,locX5)
  PSFC36=PSFC3(:,locY6,locX6)
  PSFC37=PSFC3(:,locY7,locX7)

 
realrh11=wrf_rh(rh11, PSFC11,t2m11)
realrh12=wrf_rh(rh12, PSFC12,t2m12)
realrh13=wrf_rh(rh13, PSFC13,t2m13)
realrh14=wrf_rh(rh14, PSFC14,t2m14)
realrh15=wrf_rh(rh15, PSFC15,t2m15)
realrh16=wrf_rh(rh16, PSFC16,t2m16)
realrh17=wrf_rh(rh17, PSFC17,t2m17)

realrh21=wrf_rh(rh21, PSFC21,t2m21)
realrh22=wrf_rh(rh22, PSFC22,t2m22)
realrh23=wrf_rh(rh23, PSFC23,t2m23)
realrh24=wrf_rh(rh24, PSFC24,t2m24)
realrh25=wrf_rh(rh25, PSFC25,t2m25)
realrh26=wrf_rh(rh26, PSFC26,t2m26)
realrh27=wrf_rh(rh27, PSFC27,t2m27)

realrh31=wrf_rh(rh31, PSFC31,t2m31)
realrh32=wrf_rh(rh32, PSFC32,t2m32)
realrh33=wrf_rh(rh33, PSFC33,t2m33)
realrh34=wrf_rh(rh34, PSFC34,t2m34)
realrh35=wrf_rh(rh35, PSFC35,t2m35)
realrh36=wrf_rh(rh36, PSFC36,t2m36)
realrh37=wrf_rh(rh37, PSFC37,t2m37)


  
  ;****check the lat and lon from wrfout and mcip***************
  mcipfile = addfile("/data/gpfs/home/xsun/CMAQ_v5.2/data/mcip/ACM2_pcaps/GRIDCRO2D_PCAPs_ACM2.nc","r")
  latmcip=mcipfile->LAT
  lonmcip=mcipfile->LON

  wrffile = addfile("/data/gpfs/home/xsun/modify/ACM2_MPI/WRFV3/run_ACM2_pcaps7/wrfout_d02_2011-01-27_00:00:00","r")
  latwrf=wrffile->XLAT
  lonwrf=wrffile->XLONG
  latmcip0=latmcip(0,0,locY11,locX11)
  lonmcip0=lonmcip(0,0,locY11,locX11)
  latwrf0=latwrf(0,locY1,locX1)
   lonwrf0=lonwrf(0,locY1,locX1)
   print(latwrf0)
  print(lonwrf0)
  print(latmcip0)
  print(lonmcip0)
;****check the lat and lon from wrfout and mcip***************
 
;*********READ OBS FILES**************************
obsname =  "meteo_pcaps_hourly_FillValue.csv"
obsvars=asciiread(obsname, -1, "string")
delim=","
timemst=str_get_field(obsvars(1::), 2, delim)
print(timemst(744))

obst2m1=tofloat(str_get_field(obsvars(1::), 3, delim))+273.15
obst2m2=tofloat(str_get_field(obsvars(1::), 4, delim))+273.15
obst2m3=tofloat(str_get_field(obsvars(1::), 5, delim))+273.15
obst2m4=tofloat(str_get_field(obsvars(1::), 6, delim))+273.15
obst2m5=tofloat(str_get_field(obsvars(1::), 7, delim))+273.15
obst2m6=tofloat(str_get_field(obsvars(1::), 8, delim))+273.15
obst2m7=tofloat(str_get_field(obsvars(1::), 9, delim))+273.15

obsws10m1=tofloat(str_get_field(obsvars(1::), 10, delim))
obsws10m2=tofloat(str_get_field(obsvars(1::), 11, delim))
obsws10m3=tofloat(str_get_field(obsvars(1::), 12, delim))
obsws10m4=tofloat(str_get_field(obsvars(1::), 13, delim))
obsws10m5=tofloat(str_get_field(obsvars(1::), 14, delim))
obsws10m6=tofloat(str_get_field(obsvars(1::), 15, delim))
obsws10m7=tofloat(str_get_field(obsvars(1::), 16, delim))

obsrh1=tofloat(str_get_field(obsvars(1::), 17, delim))
obsrh2=tofloat(str_get_field(obsvars(1::), 18, delim))
obsrh3=tofloat(str_get_field(obsvars(1::), 19, delim))
obsrh4=tofloat(str_get_field(obsvars(1::), 20, delim))
obsrh5=tofloat(str_get_field(obsvars(1::), 21, delim))
obsrh6=tofloat(str_get_field(obsvars(1::), 22, delim))
obsrh7=tofloat(str_get_field(obsvars(1::), 23, delim))

obsp2m1=tofloat(str_get_field(obsvars(1::), 24, delim))
obsp2m2=tofloat(str_get_field(obsvars(1::), 25, delim))
obsp2m3=tofloat(str_get_field(obsvars(1::), 26, delim))
obsp2m4=tofloat(str_get_field(obsvars(1::), 27, delim))
obsp2m5=tofloat(str_get_field(obsvars(1::), 28, delim))
obsp2m6=tofloat(str_get_field(obsvars(1::), 29, delim))
obsp2m7=tofloat(str_get_field(obsvars(1::), 30, delim))



obst2m1@_FillValue = 999+273.15
obsws10m1@_FillValue = 999
obsrh1@_FillValue = 999
obsp2m1@_FillValue = 999

obst2m2@_FillValue = 999+273.15
obsws10m2@_FillValue = 999
obsrh2@_FillValue = 999
obsp2m2@_FillValue = 999

obst2m3@_FillValue = 999+273.15
obsws10m3@_FillValue = 999
obsrh3@_FillValue = 999
obsp2m3@_FillValue = 999

obst2m4@_FillValue = 999+273.15
obsws10m4@_FillValue = 999
obsrh4@_FillValue = 999
obsp2m4@_FillValue = 999

obst2m5@_FillValue = 999+273.15
obsws10m5@_FillValue = 999
obsrh5@_FillValue = 999
obsp2m5@_FillValue = 999

obst2m6@_FillValue = 999+273.15
obsws10m6@_FillValue = 999
obsrh6@_FillValue = 999
obsp2m6@_FillValue = 999

obst2m7@_FillValue = 999+273.15
obsws10m7@_FillValue = 999
obsrh7@_FillValue = 999
obsp2m7@_FillValue = 999
;*********READ OBS FILES**************************

;************PLOT RESOURCES*************************************
wks1=gsn_open_wks("png", "t2m_site1_WRF_OBS_Jan2011")
wks2=gsn_open_wks("png", "ws10m_site1_WRF_OBS_Jan2011")
wks3=gsn_open_wks("png", "realrh2m_site1_WRF_OBS_Jan2011")
wks4=gsn_open_wks("png", "p2m_site1_WRF_OBS_Jan2011")


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
res1=res
res1@tiYAxisString="T2 (K)"

res2=res
res2@tiYAxisString="WS10 (m/s)"
res3=res
res3@tiYAxisString="RH (%)"
res4=res
res4@tiYAxisString="Pressure (hPa)"
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
resobs@pmLegendOrthogonalPosF=-0.9
;resmcip@trXMinF=2011001
;resmcip@trXMaxF=2011031

datat2m1=new((/3,744/),float)
datat2m1(0,:)=t2m31
datat2m1(1,:)=t2m21
datat2m1(2,:)=t2m11
wrft2m1=(/t2m11(:),t2m21(:),t2m31(:)/)
maxwrft2m1=max(wrft2m1)
maxobst2m1=max(obst2m1(744:1487))
maxwrfobst2m1=(/maxwrft2m1,maxobst2m1/)

minwrft2m1=min(wrft2m1)
minobst2m1=min(obst2m1(744:1487))
minwrfobst2m1=(/minwrft2m1,minobst2m1/)

dataws10m1=new((/3,744/),float)
dataws10m1(0,:)=ws10m31
dataws10m1(1,:)=ws10m21
dataws10m1(2,:)=ws10m11

wrfws10m1=(/ws10m11(:),ws10m21(:),ws10m31(:)/)
maxwrfws10m1=max(wrfws10m1)
maxobsws10m1=max(obsws10m1(744:1487))
maxwrfobsws10m1=(/maxwrfws10m1,maxobsws10m1/)
minwrfws10m1=min(wrfws10m1)
minobsws10m1=min(obsws10m1(744:1487))
minwrfobsws10m1=(/minwrfws10m1,minobsws10m1/)

datarealrh1=new((/3,744/),float)
datarealrh1(0,:)=realrh31
datarealrh1(1,:)=realrh21
datarealrh1(2,:)=realrh11
wrfrealrh1=(/realrh11(:),realrh21(:),realrh31(:)/)
maxwrfrealrh1=max(wrfrealrh1)
maxobsrealrh1=max(obsrh1(744:1487))
maxwrfobsrealrh1=(/maxwrfrealrh1,maxobsrealrh1/)
minwrfrealrh1=min(wrfrealrh1)
minobsrealrh1=min(obsrh1(744:1487))
minwrfobsrealrh1=(/minwrfrealrh1,minobsrealrh1/)

dataPSFC1=new((/3,744/),float)
dataPSFC1(0,:)=PSFC31
dataPSFC1(1,:)=PSFC21
dataPSFC1(2,:)=PSFC11
wrfPSFC1=(/PSFC11(:),PSFC21(:),PSFC31(:)/)
maxwrfPSFC1=max(wrfPSFC1)*0.01
maxobsPSFC1=max(obsp2m1(744:1487))
maxwrfobsPSFC1=(/maxwrfPSFC1,maxobsPSFC1/)
minwrfPSFC1=min(wrfPSFC1)*0.01
minobsPSFC1=min(obsp2m1(744:1487))
minwrfobsPSFC1=(/minwrfPSFC1,minobsPSFC1/)

;***********PROCESSING FOR SITE 2*******************
datat2m2=new((/3,744/),float)
datat2m2(0,:)=t2m32
datat2m2(1,:)=t2m22
datat2m2(2,:)=t2m12
wrft2m2=(/t2m12(:),t2m22(:),t2m32(:)/)
maxwrft2m2=max(wrft2m2)
maxobst2m2=max(obst2m2(744:1487))
maxwrfobst2m2=(/maxwrft2m2,maxobst2m2/)

minwrft2m2=min(wrft2m2)
minobst2m2=min(obst2m2(744:1487))
minwrfobst2m2=(/minwrft2m2,minobst2m2/)

dataws10m2=new((/3,744/),float)
dataws10m2(0,:)=ws10m32
dataws10m2(1,:)=ws10m22
dataws10m2(2,:)=ws10m12

wrfws10m2=(/ws10m12(:),ws10m22(:),ws10m32(:)/)
maxwrfws10m2=max(wrfws10m2)
maxobsws10m2=max(obsws10m2(744:1487))
maxwrfobsws10m2=(/maxwrfws10m2,maxobsws10m2/)
minwrfws10m2=min(wrfws10m2)
minobsws10m2=min(obsws10m2(744:1487))
minwrfobsws10m2=(/minwrfws10m2,minobsws10m2/)

datarealrh2=new((/3,744/),float)
datarealrh2(0,:)=realrh32
datarealrh2(1,:)=realrh22
datarealrh2(2,:)=realrh12
wrfrealrh2=(/realrh12(:),realrh22(:),realrh32(:)/)
maxwrfrealrh2=max(wrfrealrh2)
maxobsrealrh2=max(obsrh2(744:1487))
maxwrfobsrealrh2=(/maxwrfrealrh2,maxobsrealrh2/)
minwrfrealrh2=min(wrfrealrh2)
minobsrealrh2=min(obsrh2(744:1487))
minwrfobsrealrh2=(/minwrfrealrh2,minobsrealrh2/)

dataPSFC2=new((/3,744/),float)
dataPSFC2(0,:)=PSFC32
dataPSFC2(1,:)=PSFC22
dataPSFC2(2,:)=PSFC12
wrfPSFC2=(/PSFC12(:),PSFC22(:),PSFC32(:)/)
maxwrfPSFC2=max(wrfPSFC2)*0.01
maxobsPSFC2=max(obsp2m2(744:1487))
maxwrfobsPSFC2=(/maxwrfPSFC2,maxobsPSFC2/)
minwrfPSFC2=min(wrfPSFC2)*0.01
minobsPSFC2=min(obsp2m2(744:1487))
minwrfobsPSFC2=(/minwrfPSFC2,minobsPSFC2/)


;***********PROCESSING FOR SITE 3*******************
datat2m3=new((/3,744/),float)
datat2m3(0,:)=t2m33
datat2m3(1,:)=t2m23
datat2m3(2,:)=t2m13
wrft2m3=(/t2m13(:),t2m23(:),t2m33(:)/)
maxwrft2m3=max(wrft2m3)
maxobst2m3=max(obst2m3(744:1487))
maxwrfobst2m3=(/maxwrft2m3,maxobst2m3/)

minwrft2m3=min(wrft2m3)
minobst2m3=min(obst2m3(744:1487))
minwrfobst2m3=(/minwrft2m3,minobst2m3/)

dataws10m3=new((/3,744/),float)
dataws10m3(0,:)=ws10m33
dataws10m3(1,:)=ws10m23
dataws10m3(2,:)=ws10m13

wrfws10m3=(/ws10m13(:),ws10m23(:),ws10m33(:)/)
maxwrfws10m3=max(wrfws10m3)
maxobsws10m3=max(obsws10m3(744:1487))
maxwrfobsws10m3=(/maxwrfws10m3,maxobsws10m3/)
minwrfws10m3=min(wrfws10m3)
minobsws10m3=min(obsws10m3(744:1487))
minwrfobsws10m3=(/minwrfws10m3,minobsws10m3/)

datarealrh3=new((/3,744/),float)
datarealrh3(0,:)=realrh33
datarealrh3(1,:)=realrh23
datarealrh3(2,:)=realrh13
wrfrealrh3=(/realrh13(:),realrh23(:),realrh33(:)/)
maxwrfrealrh3=max(wrfrealrh3)
maxobsrealrh3=max(obsrh3(744:1487))
maxwrfobsrealrh3=(/maxwrfrealrh3,maxobsrealrh3/)
minwrfrealrh3=min(wrfrealrh3)
minobsrealrh3=min(obsrh3(744:1487))
minwrfobsrealrh3=(/minwrfrealrh3,minobsrealrh3/)

dataPSFC3=new((/3,744/),float)
dataPSFC3(0,:)=PSFC33
dataPSFC3(1,:)=PSFC23
dataPSFC3(2,:)=PSFC13
wrfPSFC3=(/PSFC13(:),PSFC23(:),PSFC33(:)/)
maxwrfPSFC3=max(wrfPSFC3)*0.01
maxobsPSFC3=max(obsp2m3(744:1487))
maxwrfobsPSFC3=(/maxwrfPSFC3,maxobsPSFC3/)
minwrfPSFC3=min(wrfPSFC3)*0.01
minobsPSFC3=min(obsp2m3(744:1487))
minwrfobsPSFC3=(/minwrfPSFC3,minobsPSFC3/)


;***********PROCESSING FOR SITE 4*******************
datat2m4=new((/3,744/),float)
datat2m4(0,:)=t2m34
datat2m4(1,:)=t2m24
datat2m4(2,:)=t2m14
wrft2m4=(/t2m14(:),t2m24(:),t2m34(:)/)
maxwrft2m4=max(wrft2m4)
maxobst2m4=max(obst2m4(744:1487))
maxwrfobst2m4=(/maxwrft2m4,maxobst2m4/)

minwrft2m4=min(wrft2m4)
minobst2m4=min(obst2m4(744:1487))
minwrfobst2m4=(/minwrft2m4,minobst2m4/)

dataws10m4=new((/3,744/),float)
dataws10m4(0,:)=ws10m34
dataws10m4(1,:)=ws10m24
dataws10m4(2,:)=ws10m14

wrfws10m4=(/ws10m14(:),ws10m24(:),ws10m34(:)/)
maxwrfws10m4=max(wrfws10m4)
maxobsws10m4=max(obsws10m4(744:1487))
maxwrfobsws10m4=(/maxwrfws10m4,maxobsws10m4/)
minwrfws10m4=min(wrfws10m4)
minobsws10m4=min(obsws10m4(744:1487))
minwrfobsws10m4=(/minwrfws10m4,minobsws10m4/)

datarealrh4=new((/3,744/),float)
datarealrh4(0,:)=realrh34
datarealrh4(1,:)=realrh24
datarealrh4(2,:)=realrh14
wrfrealrh4=(/realrh14(:),realrh24(:),realrh34(:)/)
maxwrfrealrh4=max(wrfrealrh4)
maxobsrealrh4=max(obsrh4(744:1487))
maxwrfobsrealrh4=(/maxwrfrealrh4,maxobsrealrh4/)
minwrfrealrh4=min(wrfrealrh4)
minobsrealrh4=min(obsrh4(744:1487))
minwrfobsrealrh4=(/minwrfrealrh4,minobsrealrh4/)

dataPSFC4=new((/3,744/),float)
dataPSFC4(0,:)=PSFC34
dataPSFC4(1,:)=PSFC24
dataPSFC4(2,:)=PSFC14
wrfPSFC4=(/PSFC14(:),PSFC24(:),PSFC34(:)/)
maxwrfPSFC4=max(wrfPSFC4)*0.01
maxobsPSFC4=max(obsp2m4(744:1487))
maxwrfobsPSFC4=(/maxwrfPSFC4,maxobsPSFC4/)
minwrfPSFC4=min(wrfPSFC4)*0.01
minobsPSFC4=min(obsp2m4(744:1487))
minwrfobsPSFC4=(/minwrfPSFC4,minobsPSFC4/)


;***********PROCESSING FOR SITE 5*******************
datat2m5=new((/3,744/),float)
datat2m5(0,:)=t2m35
datat2m5(1,:)=t2m25
datat2m5(2,:)=t2m15
wrft2m5=(/t2m15(:),t2m25(:),t2m35(:)/)
maxwrft2m5=max(wrft2m5)
maxobst2m5=max(obst2m5(744:1487))
maxwrfobst2m5=(/maxwrft2m5,maxobst2m5/)

minwrft2m5=min(wrft2m5)
minobst2m5=min(obst2m5(744:1487))
minwrfobst2m5=(/minwrft2m5,minobst2m5/)

dataws10m5=new((/3,744/),float)
dataws10m5(0,:)=ws10m35
dataws10m5(1,:)=ws10m25
dataws10m5(2,:)=ws10m15

wrfws10m5=(/ws10m15(:),ws10m25(:),ws10m35(:)/)
maxwrfws10m5=max(wrfws10m5)*0.01
maxobsws10m5=max(obsws10m5(744:1487))
maxwrfobsws10m5=(/maxwrfws10m5,maxobsws10m5/)
minwrfws10m5=min(wrfws10m5)*0.01
minobsws10m5=min(obsws10m5(744:1487))
minwrfobsws10m5=(/minwrfws10m5,minobsws10m5/)

datarealrh5=new((/3,744/),float)
datarealrh5(0,:)=realrh35
datarealrh5(1,:)=realrh25
datarealrh5(2,:)=realrh15
wrfrealrh5=(/realrh15(:),realrh25(:),realrh35(:)/)
maxwrfrealrh5=max(wrfrealrh5)
maxobsrealrh5=max(obsrh5(744:1487))
maxwrfobsrealrh5=(/maxwrfrealrh5,maxobsrealrh5/)
minwrfrealrh5=min(wrfrealrh5)
minobsrealrh5=min(obsrh5(744:1487))
minwrfobsrealrh5=(/minwrfrealrh5,minobsrealrh5/)

dataPSFC5=new((/3,744/),float)
dataPSFC5(0,:)=PSFC35
dataPSFC5(1,:)=PSFC25
dataPSFC5(2,:)=PSFC15
wrfPSFC5=(/PSFC15(:),PSFC25(:),PSFC35(:)/)
maxwrfPSFC5=max(wrfPSFC5)*0.01
maxobsPSFC5=max(obsp2m5(744:1487))
maxwrfobsPSFC5=(/maxwrfPSFC5,maxobsPSFC5/)
minwrfPSFC5=min(wrfPSFC5)*0.01
minobsPSFC5=min(obsp2m5(744:1487))
minwrfobsPSFC5=(/minwrfPSFC5,minobsPSFC5/)


;***********PROCESSING FOR SITE 6*******************
datat2m6=new((/3,744/),float)
datat2m6(0,:)=t2m36
datat2m6(1,:)=t2m26
datat2m6(2,:)=t2m16
wrft2m6=(/t2m16(:),t2m26(:),t2m36(:)/)
maxwrft2m6=max(wrft2m6)
maxobst2m6=max(obst2m6(744:1487))
maxwrfobst2m6=(/maxwrft2m6,maxobst2m6/)

minwrft2m6=min(wrft2m6)
minobst2m6=min(obst2m6(744:1487))
minwrfobst2m6=(/minwrft2m6,minobst2m6/)

dataws10m6=new((/3,744/),float)
dataws10m6(0,:)=ws10m36
dataws10m6(1,:)=ws10m26
dataws10m6(2,:)=ws10m16

wrfws10m6=(/ws10m16(:),ws10m26(:),ws10m36(:)/)
maxwrfws10m6=max(wrfws10m6)
maxobsws10m6=max(obsws10m6(744:1487))
maxwrfobsws10m6=(/maxwrfws10m6,maxobsws10m6/)
minwrfws10m6=min(wrfws10m6)
minobsws10m6=min(obsws10m6(744:1487))
minwrfobsws10m6=(/minwrfws10m6,minobsws10m6/)

datarealrh6=new((/3,744/),float)
datarealrh6(0,:)=realrh36
datarealrh6(1,:)=realrh26
datarealrh6(2,:)=realrh16
wrfrealrh6=(/realrh16(:),realrh26(:),realrh36(:)/)
maxwrfrealrh6=max(wrfrealrh6)
maxobsrealrh6=max(obsrh6(744:1487))
maxwrfobsrealrh6=(/maxwrfrealrh6,maxobsrealrh6/)
minwrfrealrh6=min(wrfrealrh6)
minobsrealrh6=min(obsrh6(744:1487))
minwrfobsrealrh6=(/minwrfrealrh6,minobsrealrh6/)

dataPSFC6=new((/3,744/),float)
dataPSFC6(0,:)=PSFC36
dataPSFC6(1,:)=PSFC26
dataPSFC6(2,:)=PSFC16
wrfPSFC6=(/PSFC16(:),PSFC26(:),PSFC36(:)/)
maxwrfPSFC6=max(wrfPSFC6)*0.01
maxobsPSFC6=max(obsp2m6(744:1487))
maxwrfobsPSFC6=(/maxwrfPSFC6,maxobsPSFC6/)
minwrfPSFC6=min(wrfPSFC6)*0.01
minobsPSFC6=min(obsp2m6(744:1487))
minwrfobsPSFC6=(/minwrfPSFC6,minobsPSFC6/)


;***********PROCESSING FOR SITE 7*******************
datat2m7=new((/3,744/),float)
datat2m7(0,:)=t2m37
datat2m7(1,:)=t2m27
datat2m7(2,:)=t2m17
wrft2m7=(/t2m17(:),t2m27(:),t2m37(:)/)
maxwrft2m7=max(wrft2m7)
maxobst2m7=max(obst2m7(744:1487))
maxwrfobst2m7=(/maxwrft2m7,maxobst2m7/)

minwrft2m7=min(wrft2m7)
minobst2m7=min(obst2m7(744:1487))
minwrfobst2m7=(/minwrft2m7,minobst2m7/)

dataws10m7=new((/3,744/),float)
dataws10m7(0,:)=ws10m37
dataws10m7(1,:)=ws10m27
dataws10m7(2,:)=ws10m17

wrfws10m7=(/ws10m17(:),ws10m27(:),ws10m37(:)/)
maxwrfws10m7=max(wrfws10m7)
maxobsws10m7=max(obsws10m7(744:1487))
maxwrfobsws10m7=(/maxwrfws10m7,maxobsws10m7/)
minwrfws10m7=min(wrfws10m7)
minobsws10m7=min(obsws10m7(744:1487))
minwrfobsws10m7=(/minwrfws10m7,minobsws10m7/)

datarealrh7=new((/3,744/),float)
datarealrh7(0,:)=realrh37
datarealrh7(1,:)=realrh27
datarealrh7(2,:)=realrh17
wrfrealrh7=(/realrh17(:),realrh27(:),realrh37(:)/)
maxwrfrealrh7=max(wrfrealrh7)
maxobsrealrh7=max(obsrh7(744:1487))
maxwrfobsrealrh7=(/maxwrfrealrh7,maxobsrealrh7/)
minwrfrealrh7=min(wrfrealrh7)
minobsrealrh7=min(obsrh7(744:1487))
minwrfobsrealrh7=(/minwrfrealrh7,minobsrealrh7/)

dataPSFC7=new((/3,744/),float)
dataPSFC7(0,:)=PSFC37
dataPSFC7(1,:)=PSFC27
dataPSFC7(2,:)=PSFC17
wrfPSFC7=(/PSFC17(:),PSFC27(:),PSFC37(:)/)
maxwrfPSFC7=max(wrfPSFC7)*0.01
maxobsPSFC7=max(obsp2m7(744:1487))
maxwrfobsPSFC7=(/maxwrfPSFC7,maxobsPSFC7/)
minwrfPSFC7=min(wrfPSFC7)*0.01
minobsPSFC7=min(obsp2m7(744:1487))
minwrfobsPSFC7=(/minwrfPSFC7,minobsPSFC7/)

ctime=wrf_times_c(f1[:]->Times,0)
utahtime=ctime-7 ;MST time

res@trXMinF=utahtime(0)
res@trXMaxF=utahtime(743)

copy_VarAtts(ctime, utahtime)
res11=res1
res11@trXMinF=utahtime(0)
res11@trXMaxF=utahtime(743)
res11@trYMinF=min(minwrfobst2m1)-5.0
res11@trYMaxF=max(maxwrfobst2m1)+5.0
resobs11=resobs
resobs11@trXMinF=utahtime(0)
resobs11@trXMaxF=utahtime(743)
resobs11@trYMinF=min(minwrfobst2m1)-5.0
resobs11@trYMaxF=max(maxwrfobst2m1)+5.0
res12=res2
res12@trXMinF=utahtime(0)
res12@trXMaxF=utahtime(743)
res12@trYMinF=min(minwrfobsws10m1)-2.0
res12@trYMaxF=max(maxwrfobsws10m1)+2.0
resobs12=resobs
resobs12@trXMinF=utahtime(0)
resobs12@trXMaxF=utahtime(743)
resobs12@trYMinF=min(minwrfobsws10m1)-2.0
resobs12@trYMaxF=max(maxwrfobsws10m1)+2.0
res13=res3
res13@trXMinF=utahtime(0)
res13@trXMaxF=utahtime(743)
res13@trYMinF=min(minwrfobsrealrh1)-5
res13@trYMaxF=max(maxwrfobsrealrh1)+5
resobs13=resobs
resobs13@trXMinF=utahtime(0)
resobs13@trXMaxF=utahtime(743)
resobs13@trYMinF=min(minwrfobsrealrh1)-5
resobs13@trYMaxF=max(maxwrfobsrealrh1)+5
res14=res4
res14@trXMinF=utahtime(0)
res14@trXMaxF=utahtime(743)
res14@trYMinF=min(minwrfobsPSFC1)-5
res14@trYMaxF=max(maxwrfobsPSFC1)+5
resobs14=resobs
resobs14@trXMinF=utahtime(0)
resobs14@trXMaxF=utahtime(743)
resobs14@trYMinF=min(minwrfobsPSFC1)-5
resobs14@trYMaxF=max(maxwrfobsPSFC1)+5

res21=res1
res21@trXMinF=utahtime(0)
res21@trXMaxF=utahtime(743)
res21@trYMinF=min(minwrfobst2m2)-5.0
res21@trYMaxF=max(maxwrfobst2m2)+5.0
resobs21=resobs
resobs21@trXMinF=utahtime(0)
resobs21@trXMaxF=utahtime(743)
resobs21@trYMinF=min(minwrfobst2m2)-5.0
resobs21@trYMaxF=max(maxwrfobst2m2)+5.0
res22=res2
res22@trXMinF=utahtime(0)
res22@trXMaxF=utahtime(743)
res22@trYMinF=min(minwrfobsws10m2)-2.0
res22@trYMaxF=max(maxwrfobsws10m2)+2.0
resobs22=resobs
resobs22@trXMinF=utahtime(0)
resobs22@trXMaxF=utahtime(743)
resobs22@trYMinF=min(minwrfobsws10m2)-2.0
resobs22@trYMaxF=max(maxwrfobsws10m2)+2.0
res23=res3
res23@trXMinF=utahtime(0)
res23@trXMaxF=utahtime(743)
res23@trYMinF=min(minwrfobsrealrh2)-5
res23@trYMaxF=max(maxwrfobsrealrh2)+5
resobs23=resobs
resobs23@trXMinF=utahtime(0)
resobs23@trXMaxF=utahtime(743)
resobs23@trYMinF=min(minwrfobsrealrh2)-5
resobs23@trYMaxF=max(maxwrfobsrealrh2)+5
res24=res4
res24@trXMinF=utahtime(0)
res24@trXMaxF=utahtime(743)
res24@trYMinF=min(minwrfobsPSFC2)-5
res24@trYMaxF=max(maxwrfobsPSFC2)+5
resobs24=resobs
resobs24@trXMinF=utahtime(0)
resobs24@trXMaxF=utahtime(743)
resobs24@trYMinF=min(minwrfobsPSFC2)-5
resobs24@trYMaxF=max(maxwrfobsPSFC2)+5

res31=res1
res31@trXMinF=utahtime(0)
res31@trXMaxF=utahtime(743)
res31@trYMinF=min(minwrfobst2m3)-5.0
res31@trYMaxF=max(maxwrfobst2m3)+5.0
resobs31=resobs
resobs31@trXMinF=utahtime(0)
resobs31@trXMaxF=utahtime(743)
resobs31@trYMinF=min(minwrfobst2m3)-5.0
resobs31@trYMaxF=max(maxwrfobst2m3)+5.0
res32=res2
res32@trXMinF=utahtime(0)
res32@trXMaxF=utahtime(743)
res32@trYMinF=min(minwrfobsws10m3)-2.0
res32@trYMaxF=max(maxwrfobsws10m3)+2.0
resobs32=resobs
resobs32@trXMinF=utahtime(0)
resobs32@trXMaxF=utahtime(743)
resobs32@trYMinF=min(minwrfobsws10m3)-2.0
resobs32@trYMaxF=max(maxwrfobsws10m3)+2.0
res33=res3
res33@trXMinF=utahtime(0)
res33@trXMaxF=utahtime(743)
res33@trYMinF=min(minwrfobsrealrh3)-5
res33@trYMaxF=max(maxwrfobsrealrh3)+5
resobs33=resobs
resobs33@trXMinF=utahtime(0)
resobs33@trXMaxF=utahtime(743)
resobs33@trYMinF=min(minwrfobsrealrh3)-5
resobs33@trYMaxF=max(maxwrfobsrealrh3)+5
res34=res4
res34@trXMinF=utahtime(0)
res34@trXMaxF=utahtime(743)
res34@trYMinF=min(minwrfobsPSFC3)-5
res34@trYMaxF=max(maxwrfobsPSFC3)+5
resobs34=resobs
resobs34@trXMinF=utahtime(0)
resobs34@trXMaxF=utahtime(743)
resobs34@trYMinF=min(minwrfobsPSFC3)-5
resobs34@trYMaxF=max(maxwrfobsPSFC3)+5


res41=res1
res41@trXMinF=utahtime(0)
res41@trXMaxF=utahtime(743)
res41@trYMinF=min(minwrfobst2m4)-5
res41@trYMaxF=max(maxwrfobst2m4)+5
resobs41=resobs
resobs41@trXMinF=utahtime(0)
resobs41@trXMaxF=utahtime(743)
resobs41@trYMinF=min(minwrfobst2m4)-5
resobs41@trYMaxF=max(maxwrfobst2m4)+5
res42=res2
res42@trXMinF=utahtime(0)
res42@trXMaxF=utahtime(743)
res42@trYMinF=min(minwrfobsws10m4)-2.0
res42@trYMaxF=max(maxwrfobsws10m4)+2.0
resobs42=resobs
resobs42@trXMinF=utahtime(0)
resobs42@trXMaxF=utahtime(743)
resobs42@trYMinF=min(minwrfobsws10m4)-2.0
resobs42@trYMaxF=max(maxwrfobsws10m4)+2.0
res43=res3
res43@trXMinF=utahtime(0)
res43@trXMaxF=utahtime(743)
res43@trYMinF=min(minwrfobsrealrh4)-5
res43@trYMaxF=max(maxwrfobsrealrh4)+5
resobs43=resobs
resobs43@trXMinF=utahtime(0)
resobs43@trXMaxF=utahtime(743)
resobs43@trYMinF=min(minwrfobsrealrh4)-5
resobs43@trYMaxF=max(maxwrfobsrealrh4)+5
res44=res4
res44@trXMinF=utahtime(0)
res44@trXMaxF=utahtime(743)
res44@trYMinF=min(minwrfobsPSFC4)-5
res44@trYMaxF=max(maxwrfobsPSFC4)+5
resobs44=resobs
resobs44@trXMinF=utahtime(0)
resobs44@trXMaxF=utahtime(743)
resobs44@trYMinF=min(minwrfobsPSFC4)-5
resobs44@trYMaxF=max(maxwrfobsPSFC4)+5



res51=res1
res51@trXMinF=utahtime(0)
res51@trXMaxF=utahtime(743)
res51@trYMinF=min(minwrfobst2m5)-5
res51@trYMaxF=max(maxwrfobst2m5)+5
resobs51=resobs
resobs51@trXMinF=utahtime(0)
resobs51@trXMaxF=utahtime(743)
resobs51@trYMinF=min(minwrfobst2m5)-5
resobs51@trYMaxF=max(maxwrfobst2m5)+5
res52=res2
res52@trXMinF=utahtime(0)
res52@trXMaxF=utahtime(743)
res52@trYMinF=min(minwrfobsws10m5)-2.0
res52@trYMaxF=max(maxwrfobsws10m5)+2.0
resobs52=resobs
resobs52@trXMinF=utahtime(0)
resobs52@trXMaxF=utahtime(743)
resobs52@trYMinF=min(minwrfobsws10m5)-2.0
resobs52@trYMaxF=max(maxwrfobsws10m5)+2.0
res53=res3
res53@trXMinF=utahtime(0)
res53@trXMaxF=utahtime(743)
res53@trYMinF=min(minwrfobsrealrh5)-5
res53@trYMaxF=max(maxwrfobsrealrh5)+5
resobs53=resobs
resobs53@trXMinF=utahtime(0)
resobs53@trXMaxF=utahtime(743)
resobs53@trYMinF=min(minwrfobsrealrh5)-5
resobs53@trYMaxF=max(maxwrfobsrealrh5)+5
res54=res4
res54@trXMinF=utahtime(0)
res54@trXMaxF=utahtime(743)
res54@trYMinF=min(minwrfobsPSFC5)-5
res54@trYMaxF=max(maxwrfobsPSFC5)+5
resobs54=resobs
resobs54@trXMinF=utahtime(0)
resobs54@trXMaxF=utahtime(743)
resobs54@trYMinF=min(minwrfobsPSFC5)-5
resobs54@trYMaxF=max(maxwrfobsPSFC5)+5


res61=res1
res61@trXMinF=utahtime(0)
res61@trXMaxF=utahtime(743)
res61@trYMinF=min(minwrfobst2m6)-5.0
res61@trYMaxF=max(maxwrfobst2m6)+5.0
resobs61=resobs
resobs61@trXMinF=utahtime(0)
resobs61@trXMaxF=utahtime(743)
resobs61@trYMinF=min(minwrfobst2m6)-5.0
resobs61@trYMaxF=max(maxwrfobst2m6)+5.0
res62=res2
res62@trXMinF=utahtime(0)
res62@trXMaxF=utahtime(743)
res62@trYMinF=min(minwrfobsws10m6)-2.0
res62@trYMaxF=max(maxwrfobsws10m6)+2.0
resobs62=resobs
resobs62@trXMinF=utahtime(0)
resobs62@trXMaxF=utahtime(743)
resobs62@trYMinF=min(minwrfobsws10m6)-2.0
resobs62@trYMaxF=max(maxwrfobsws10m6)+2.0
res63=res3
res63@trXMinF=utahtime(0)
res63@trXMaxF=utahtime(743)
res63@trYMinF=min(minwrfobsrealrh6)-5
res63@trYMaxF=max(maxwrfobsrealrh6)+5
resobs63=resobs
resobs63@trXMinF=utahtime(0)
resobs63@trXMaxF=utahtime(743)
resobs63@trYMinF=min(minwrfobsrealrh6)-5
resobs63@trYMaxF=max(maxwrfobsrealrh6)+5
res64=res4
res64@trXMinF=utahtime(0)
res64@trXMaxF=utahtime(743)
res64@trYMinF=min(minwrfobsPSFC6)-5
res64@trYMaxF=max(maxwrfobsPSFC6)+5
resobs64=resobs
resobs64@trXMinF=utahtime(0)
resobs64@trXMaxF=utahtime(743)
resobs64@trYMinF=min(minwrfobsPSFC6)-5
resobs64@trYMaxF=max(maxwrfobsPSFC6)+5

res71=res1
res71@trXMinF=utahtime(0)
res71@trXMaxF=utahtime(743)
res71@trYMinF=min(minwrfobst2m7)-5.0
res71@trYMaxF=max(maxwrfobst2m7)+5.0
resobs71=resobs
resobs71@trXMinF=utahtime(0)
resobs71@trXMaxF=utahtime(743)
resobs71@trYMinF=min(minwrfobst2m7)-5.0
resobs71@trYMaxF=max(maxwrfobst2m7)+5.0
res72=res2
res72@trXMinF=utahtime(0)
res72@trXMaxF=utahtime(743)
res72@trYMinF=min(minwrfobsws10m7)-2.0
res72@trYMaxF=max(maxwrfobsws10m7)+2.0
resobs72=resobs
resobs72@trXMinF=utahtime(0)
resobs72@trXMaxF=utahtime(743)
resobs72@trYMinF=min(minwrfobsws10m7)-2.0
resobs72@trYMaxF=max(maxwrfobsws10m7)+2.0
res73=res3
res73@trXMinF=utahtime(0)
res73@trXMaxF=utahtime(743)
res73@trYMinF=min(minwrfobsrealrh7)-5
res73@trYMaxF=max(maxwrfobsrealrh7)+5
resobs73=resobs
resobs73@trXMinF=utahtime(0)
resobs73@trXMaxF=utahtime(743)
resobs73@trYMinF=min(minwrfobsrealrh7)-5
resobs73@trYMaxF=max(maxwrfobsrealrh7)+5
res74=res4
res74@trXMinF=utahtime(0)
res74@trXMaxF=utahtime(743)
res74@trYMinF=min(minwrfobsPSFC7)-5
res74@trYMaxF=max(maxwrfobsPSFC7)+5
resobs74=resobs
resobs74@trXMinF=utahtime(0)
resobs74@trXMaxF=utahtime(743)
resobs74@trYMinF=min(minwrfobsPSFC7)-5
resobs74@trYMaxF=max(maxwrfobsPSFC7)+5

restick=True
restick@ttmFormat="%D-%c"
time_axis_labels(utahtime, res11, restick)
time_axis_labels(utahtime, res12, restick)
time_axis_labels(utahtime, res13, restick)
time_axis_labels(utahtime, res14, restick)

time_axis_labels(utahtime, res21, restick)
time_axis_labels(utahtime, res22, restick)
time_axis_labels(utahtime, res23, restick)
time_axis_labels(utahtime, res24, restick)

time_axis_labels(utahtime, res31, restick)
time_axis_labels(utahtime, res32, restick)
time_axis_labels(utahtime, res33, restick)
time_axis_labels(utahtime, res34, restick)

time_axis_labels(utahtime, res41, restick)
time_axis_labels(utahtime, res42, restick)
time_axis_labels(utahtime, res43, restick)
time_axis_labels(utahtime, res44, restick)

time_axis_labels(utahtime, res51, restick)
time_axis_labels(utahtime, res52, restick)
time_axis_labels(utahtime, res53, restick)
time_axis_labels(utahtime, res54, restick)

time_axis_labels(utahtime, res61, restick)
time_axis_labels(utahtime, res62, restick)
time_axis_labels(utahtime, res63, restick)
time_axis_labels(utahtime, res64, restick)

time_axis_labels(utahtime, res71, restick)
time_axis_labels(utahtime, res72, restick)
time_axis_labels(utahtime, res73, restick)
time_axis_labels(utahtime, res74, restick)


;plot1=gsn_csm_xy(wks1,utahtime,dataH1,res1)
plot1=gsn_csm_xy2(wks1,utahtime,datat2m1,obst2m1(744:1487),res11,resobs11)
plot2=gsn_csm_xy2(wks2,utahtime,dataws10m1,obsws10m1(744:1487),res12,resobs12)
plot3=gsn_csm_xy2(wks3,utahtime,datarealrh1,obsrh1(744:1487),res13,resobs13)
plot4=gsn_csm_xy2(wks4,utahtime,dataPSFC1*0.01,obsp2m1(744:1487),res14,resobs14)
draw(plot1)
frame(wks1)
draw(plot2)
frame(wks2)
draw(plot3)
frame(wks3)
draw(plot4)
frame(wks4)

delete([/wks1,wks2,wks3,wks4/])
wks12=gsn_open_wks("png", "t2m_site2_WRF_OBS_Jan2011")
wks22=gsn_open_wks("png", "ws10m_site2_WRF_OBS_Jan2011")
wks32=gsn_open_wks("png", "realrh_site2_WRF_OBS_Jan2011")
wks42=gsn_open_wks("png", "p2m_site2_WRF_OBS_Jan2011")

plot12=gsn_csm_xy2(wks12,utahtime,datat2m2,obst2m2(744:1487),res21,resobs21)
plot22=gsn_csm_xy2(wks22,utahtime,dataws10m2,obsws10m2(744:1487),res22,resobs22)
plot32=gsn_csm_xy2(wks32,utahtime,datarealrh2,obsrh2(744:1487),res23,resobs23)
plot42=gsn_csm_xy2(wks42,utahtime,dataPSFC2*0.01,obsp2m2(744:1487),res24,resobs24)
draw(plot12)
frame(wks12)
draw(plot22)
frame(wks22)
draw(plot32)
frame(wks32)
draw(plot42)
frame(wks42)
delete([/wks12,wks22,wks32,wks42/])
wks13=gsn_open_wks("png", "t2m_site3_WRF_OBS_Jan2011")
wks23=gsn_open_wks("png", "ws10m_site3_WRF_OBS_Jan2011")
wks33=gsn_open_wks("png", "realrh_site3_WRF_OBS_Jan2011")
wks43=gsn_open_wks("png", "p2m_site3_WRF_OBS_Jan2011")
plot13=gsn_csm_xy2(wks13,utahtime,datat2m3,obst2m3(744:1487),res31,resobs31)
plot23=gsn_csm_xy2(wks23,utahtime,dataws10m3,obsws10m3(744:1487),res32,resobs32)
plot33=gsn_csm_xy2(wks33,utahtime,datarealrh3,obsrh3(744:1487),res33,resobs33)
plot43=gsn_csm_xy2(wks43,utahtime,dataPSFC3*0.01,obsp2m3(744:1487),res34,resobs34)
draw(plot13)
frame(wks13)
draw(plot23)
frame(wks23)
draw(plot33)
frame(wks33)
draw(plot43)
frame(wks43)
delete([/wks13,wks23,wks33,wks43/])
wks14=gsn_open_wks("png", "t2m_site4_WRF_OBS_Jan2011")
wks24=gsn_open_wks("png", "ws10m_site4_WRF_OBS_Jan2011")
wks34=gsn_open_wks("png", "realrh_site4_WRF_OBS_Jan2011")
wks44=gsn_open_wks("png", "p2m_site4_WRF_OBS_Jan2011")
plot14=gsn_csm_xy2(wks14,utahtime,datat2m4,obst2m4(744:1487),res41,resobs41)
plot24=gsn_csm_xy2(wks24,utahtime,dataws10m4,obsws10m4(744:1487),res42,resobs42)
plot34=gsn_csm_xy2(wks34,utahtime,datarealrh4,obsrh4(744:1487),res43,resobs43)
plot44=gsn_csm_xy2(wks44,utahtime,dataPSFC4*0.01,obsp2m4(744:1487),res44,resobs44)
draw(plot14)
frame(wks14)
draw(plot24)
frame(wks24)
draw(plot34)
frame(wks34)
draw(plot44)
frame(wks44)
delete([/wks14,wks24,wks34,wks44/])
wks15=gsn_open_wks("png", "t2m_site5_WRF_OBS_Jan2011")
wks25=gsn_open_wks("png", "ws10m_site5_WRF_OBS_Jan2011")
wks35=gsn_open_wks("png", "realrh_site5_WRF_OBS_Jan2011")
wks45=gsn_open_wks("png", "p2m_site5_WRF_OBS_Jan2011")
plot15=gsn_csm_xy2(wks15,utahtime,datat2m5,obst2m5(744:1487),res51,resobs51)
plot25=gsn_csm_xy2(wks25,utahtime,dataws10m5,obsws10m5(744:1487),res52,resobs52)
plot35=gsn_csm_xy2(wks35,utahtime,datarealrh5,obsrh5(744:1487),res53,resobs53)
plot45=gsn_csm_xy2(wks45,utahtime,dataPSFC5*0.01,obsp2m5(744:1487),res54,resobs54)
draw(plot15)
frame(wks15)
draw(plot25)
frame(wks25)
draw(plot35)
frame(wks35)
draw(plot45)
frame(wks45)
delete([/wks15,wks25,wks35,wks45/])
wks16=gsn_open_wks("png", "t2m_site6_WRF_OBS_Jan2011")
wks26=gsn_open_wks("png", "ws10m_site6_WRF_OBS_Jan2011")
wks36=gsn_open_wks("png", "realrh_site6_WRF_OBS_Jan2011")
wks46=gsn_open_wks("png", "p2m_site6_WRF_OBS_Jan2011")
plot16=gsn_csm_xy2(wks16,utahtime,datat2m6,obst2m6(744:1487),res61,resobs61)
plot26=gsn_csm_xy2(wks26,utahtime,dataws10m6,obsws10m6(744:1487),res62,resobs62)
plot36=gsn_csm_xy2(wks36,utahtime,datarealrh6,obsrh6(744:1487),res63,resobs63)
plot46=gsn_csm_xy2(wks46,utahtime,dataPSFC6*0.01,obsp2m6(744:1487),res64,resobs64)
draw(plot16)
frame(wks16)
draw(plot26)
frame(wks26)
draw(plot36)
frame(wks36)
draw(plot46)
frame(wks46)
delete([/wks16,wks26,wks36,wks46/])
wks17=gsn_open_wks("png", "t2m_site7_WRF_OBS_Jan2011")
wks27=gsn_open_wks("png", "ws10m_site7_WRF_OBS_Jan2011")
wks37=gsn_open_wks("png", "realrh_site7_WRF_OBS_Jan2011")
wks47=gsn_open_wks("png", "p2m_site7_WRF_OBS_Jan2011")
plot17=gsn_csm_xy2(wks17,utahtime,datat2m7,obst2m7(744:1487),res71,resobs71)
plot27=gsn_csm_xy2(wks27,utahtime,dataws10m7,obsws10m7(744:1487),res72,resobs72)
plot37=gsn_csm_xy2(wks37,utahtime,datarealrh7,obsrh7(744:1487),res73,resobs73)
plot47=gsn_csm_xy2(wks47,utahtime,dataPSFC7*0.01,obsp2m7(744:1487),res74,resobs74)
draw(plot17)
frame(wks17)
draw(plot27)
frame(wks27)
draw(plot37)
frame(wks37)
draw(plot47)
frame(wks47)
delete([/wks17,wks27,wks37,wks47/])
;************PLOT RESOURCES*************************************
end
