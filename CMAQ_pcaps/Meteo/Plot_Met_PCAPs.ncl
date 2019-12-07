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
fils7 = systemfunc("ls /data/gpfs/home/xsun/CMAQ_v5.2/data/wrf/MYNN_pcaps/wrfout_d02_2011-01*")
f7=addfiles(fils7, "r")
f8 = addfile("/data/gpfs/home/xsun/CMAQ_v5.2/data/mcip/MYNN_pcaps/METCRO2D_PCAPs_MYNN.nc","r")
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
  ctime=wrf_times_c(f1[:]->Times,0)
utahtime=ctime-7 ;MST time
time=wrf_user_getvar(f1, "times", -1)

;res@trXMaxF=utahtime(743)

copy_VarAtts(ctime, utahtime)
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
   
   t2m4=f7[:]->T2
  t2m41=t2m4(:,locY1,locX1)
  t2m42=t2m4(:,locY2,locX2)
  t2m43=t2m4(:,locY3,locX3)
  t2m44=t2m4(:,locY4,locX4)
  t2m45=t2m4(:,locY5,locX5)
  t2m46=t2m4(:,locY6,locX6)
  t2m47=t2m4(:,locY7,locX7)

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
  u10m4=f7[:]->U10
  u10m41=u10m4(:,locY1,locX1)
  u10m42=u10m4(:,locY2,locX2)
  u10m43=u10m4(:,locY3,locX3)
  u10m44=u10m4(:,locY4,locX4)
  u10m45=u10m4(:,locY5,locX5)
  u10m46=u10m4(:,locY6,locX6)
  u10m47=u10m4(:,locY7,locX7)

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
  v10m4=f7[:]->V10
  v10m41=v10m4(:,locY1,locX1)
  v10m42=v10m4(:,locY2,locX2)
  v10m43=v10m4(:,locY3,locX3)
  v10m44=v10m4(:,locY4,locX4)
  v10m45=v10m4(:,locY5,locX5)
  v10m46=v10m4(:,locY6,locX6)
  v10m47=v10m4(:,locY7,locX7)

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

  ws10m41=sqrt(u10m41^2+v10m41^2)
  ws10m42=sqrt(u10m42^2+v10m42^2)
  ws10m43=sqrt(u10m43^2+v10m43^2)
  ws10m44=sqrt(u10m44^2+v10m44^2)
  ws10m45=sqrt(u10m45^2+v10m45^2)
  ws10m46=sqrt(u10m46^2+v10m46^2)
  ws10m47=sqrt(u10m47^2+v10m47^2)

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
  rh4=wrf_user_getvar(f7,"Q2",-1)
  rh41=rh4(:,locY1,locX1)
  rh42=rh4(:,locY2,locX2)
  rh43=rh4(:,locY3,locX3)
  rh44=rh4(:,locY4,locX4)
  rh45=rh4(:,locY5,locX5)
  rh46=rh4(:,locY6,locX6)
  rh47=rh4(:,locY7,locX7)

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
PSFC4=f7[:]->PSFC
  PSFC41=PSFC4(:,locY1,locX1)
  PSFC42=PSFC4(:,locY2,locX2)
  PSFC43=PSFC4(:,locY3,locX3)
  PSFC44=PSFC4(:,locY4,locX4)
  PSFC45=PSFC4(:,locY5,locX5)
  PSFC46=PSFC4(:,locY6,locX6)
  PSFC47=PSFC4(:,locY7,locX7)
 
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

realrh41=wrf_rh(rh41, PSFC41,t2m41)
realrh42=wrf_rh(rh42, PSFC42,t2m42)
realrh43=wrf_rh(rh43, PSFC43,t2m43)
realrh44=wrf_rh(rh44, PSFC44,t2m44)
realrh45=wrf_rh(rh45, PSFC45,t2m45)
realrh46=wrf_rh(rh46, PSFC46,t2m46)
realrh47=wrf_rh(rh47, PSFC47,t2m47)
  
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

;***********BEGIN DOING STATISTICS for T2*****************
;MEANS & STDEV


obst2m=(/obst2m1(744:1487),obst2m2(744:1487),obst2m3(744:1487),obst2m4(744:1487),obst2m5(744:1487),obst2m6(744:1487),obst2m7(744:1487)/)
printVarSummary(obst2m)
avgobst2m=dim_avg_n(obst2m,0)
obsws10m=(/obsws10m1(744:1487),obsws10m2(744:1487),obsws10m3(744:1487),obsws10m4(744:1487),obsws10m5(744:1487),obsws10m6(744:1487),obsws10m7(744:1487)/)
avgobsws10m=dim_avg_n(obsws10m,0)
obsrh=(/obsrh1(744:1487),obsrh2(744:1487),obsrh3(744:1487),obsrh4(744:1487),obsrh5(744:1487),obsrh6(744:1487),obsrh7(744:1487)/)
avgobsrh=dim_avg_n(obsrh,0)

acm2t2m=(/t2m11,t2m12,t2m13,t2m14,t2m15,t2m16,t2m17/)
acm2ws10m=(/ws10m11,ws10m12,ws10m13,ws10m14,ws10m15,ws10m16,ws10m17/)
acm2realrh=(/realrh11,realrh12,realrh13,realrh14,realrh15,realrh16,realrh17/)
avgacm2t2m=dim_avg_n(acm2t2m,0)
avgacm2ws10m=dim_avg_n(acm2ws10m,0)
avgacm2realrh=dim_avg_n(acm2realrh,0)


ysut2m=(/t2m21,t2m22,t2m23,t2m24,t2m25,t2m26,t2m27/)
ysuws10m=(/ws10m21,ws10m22,ws10m23,ws10m24,ws10m25,ws10m26,ws10m27/)
ysurealrh=(/realrh21,realrh22,realrh23,realrh24,realrh25,realrh26,realrh27/)
avgysut2m=dim_avg_n(ysut2m,0)
avgysuws10m=dim_avg_n(ysuws10m,0)
avgysurealrh=dim_avg_n(ysurealrh,0)



myjt2m=(/t2m31,t2m32,t2m33,t2m34,t2m35,t2m36,t2m37/)
myjws10m=(/ws10m31,ws10m32,ws10m33,ws10m34,ws10m35,ws10m36,ws10m37/)
myjrealrh=(/realrh31,realrh32,realrh33,realrh34,realrh35,realrh36,realrh37/)
avgmyjt2m=dim_avg_n(myjt2m,0)
avgmyjws10m=dim_avg_n(myjws10m,0)
avgmyjrealrh=dim_avg_n(myjrealrh,0)

mynnt2m=(/t2m41,t2m42,t2m43,t2m44,t2m45,t2m46,t2m47/)
mynnws10m=(/ws10m41,ws10m42,ws10m43,ws10m44,ws10m45,ws10m46,ws10m47/)
mynnrealrh=(/realrh41,realrh42,realrh43,realrh44,realrh45,realrh46,realrh47/)
avgmynnt2m=dim_avg_n(mynnt2m,0)
avgmynnws10m=dim_avg_n(mynnws10m,0)
avgmynnrealrh=dim_avg_n(mynnrealrh,0)



wks1=gsn_open_wks("png", "t2m_AvgSites_WRF_OBS_Jan2011")
wks2=gsn_open_wks("png", "ws10m_AvgSites_WRF_OBS_Jan2011")
wks3=gsn_open_wks("png", "realrh2m_AvgSites_WRF_OBS_Jan2011")
;wks4=gsn_open_wks("png", "p2m_AvgSites_WRF_OBS_Jan2011")


res=True
res@gsnMaximize=True
res@pmLegendDisplayMode="Always"
res@xyMarkLineModes =(/"Markers","Lines","Lines","Lines","Lines"/)
;res@tiYAxisString="PBLH (m)"
res@xyExplicitLegendLabels = (/"OBS","ModMYNN","ModMYJ","ModYSU","ModACM2"/)
res@xyMarkerColors=(/"black","darkgoldenrod","green","blue","red"/)
res@xyLineColors=(/"black","darkgoldenrod","green","blue","red"/)
res@xyMarkers=(/16,16,16,16,16/)
res@xyMarkerThicknessF=4.0
;res@xyLineThicknessF=5
res@xyMarkerSizeF=0.01
res@lgPerimOn = False
res@lgLabelFontHeightF=0.015
res@lgBoxMinorExtentF=0.1
res@pmLegendHeightF=0.07
res@pmLegendParallelPosF=0.8
res@pmLegendOrthogonalPosF=-1.3
res@tiXAxisString="Date (MST)"
res@xyLineThicknesses=(/4,4,4,4,4/)
res@xyDashPatterns=(/0,0,0,0,0/)
res@vpWidthF=0.8
res@vpHeightF=0.3
res@tmYROn=False
res@tmXTOn=False
res@trXMinF=utahtime(7)
res@trXMaxF=utahtime(743)
res1=res
res1@tiYAxisString="T2 (K)"

res2=res
res2@tiYAxisString="WS10 (m/s)"
res3=res
res3@tiYAxisString="RH (%)"

datat2m=new((/5,744/),float)
datat2m(0,:)=avgobst2m
datat2m(1,:)=avgmynnt2m
datat2m(2,:)=avgmyjt2m
datat2m(2,:)=avgysut2m
datat2m(2,:)=avgacm2t2m

dataws10m=new((/5,744/),float)
dataws10m(0,:)=avgobsws10m
dataws10m(1,:)=avgmynnws10m
dataws10m(2,:)=avgmyjws10m
dataws10m(2,:)=avgysuws10m
dataws10m(2,:)=avgacm2ws10m

datarealrh=new((/5,744/),float)
datarealrh(0,:)=avgobsrh
datarealrh(1,:)=avgmynnrealrh
datarealrh(2,:)=avgmyjrealrh
datarealrh(2,:)=avgysurealrh
datarealrh(2,:)=avgacm2realrh

 restick = True
   restick@ttmFormat = "%D-%c"
 restick@ttmValues=(/(/2011,01,01,00,0,0/),\
                     (/2011,01,08,0,0,0/),\
                     (/2011,01,15,0,0,0/),\
                     (/2011,01,22,0,0,0/),\
                     (/2011,01,29,0,0,0/)/)
; restick@ttmMinorStride=23
   time_axis_labels(utahtime,res1,restick)
     time_axis_labels(utahtime,res2,restick)
       time_axis_labels(utahtime,res3,restick)
plot1=gsn_csm_xy(wks1, utahtime, datat2m, res1)
plot2=gsn_csm_xy(wks2, utahtime, dataws10m, res2)
plot3=gsn_csm_xy(wks3, utahtime, datarealrh, res3)
csv_filename="./Met_OBS_WRF_AvgSites.csv"
header=[/"time(utc)"+",obs_t2m"+",acm2_t2m"+",ysu_t2m"+",myj_t2m"+",mynn_t2m"+",obs_ws10m"+",acm2_ws10m"+",ysu_ws10m"+",myj_ws10m"+",mynn_ws10m"+",obs_rh"+",acm2_rh"+",ysu_rh"+",myj_rh"+",mynn_rh"/]
write_table(csv_filename,"w",header,"%s")
;do i=0,6,1
printVarSummary(utahtime)
alist=[/time,avgobst2m, avgacm2t2m,avgysut2m,avgmyjt2m,avgmynnt2m,avgobsws10m, avgacm2ws10m,avgysuws10m,avgmyjws10m,avgmynnws10m,avgobsrh, avgacm2realrh,avgysurealrh,avgmyjrealrh,avgmynnrealrh/]
format="%s,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g"
write_table(csv_filename, "a", alist, format)
end
