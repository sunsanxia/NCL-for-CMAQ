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
  print("FINISH PAIRING LOCATION AND GRID")
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
print("FINISH READING T")
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
print("FINISH READING ws")
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
  print("FINISH READ DATA FROM WRFOUT")
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
avgobst2m1=avg(obst2m1(744:1487))
avgobst2m2=avg(obst2m2(744:1487))
avgobst2m3=avg(obst2m3(744:1487))
avgobst2m4=avg(obst2m4(744:1487))
avgobst2m5=avg(obst2m5(744:1487))
avgobst2m6=avg(obst2m6(744:1487))
avgobst2m7=avg(obst2m7(744:1487))
stddevobst2m1=stddev(obst2m1(744:1487))
stddevobst2m2=stddev(obst2m2(744:1487))
stddevobst2m3=stddev(obst2m3(744:1487))
stddevobst2m4=stddev(obst2m4(744:1487))
stddevobst2m5=stddev(obst2m5(744:1487))
stddevobst2m6=stddev(obst2m6(744:1487))
stddevobst2m7=stddev(obst2m7(744:1487))

avgobsws10m1=avg(obsws10m1(744:1487))
avgobsws10m2=avg(obsws10m2(744:1487))
avgobsws10m3=avg(obsws10m3(744:1487))
avgobsws10m4=avg(obsws10m4(744:1487))
avgobsws10m5=avg(obsws10m5(744:1487))
avgobsws10m6=avg(obsws10m6(744:1487))
avgobsws10m7=avg(obsws10m7(744:1487))
stddevobsws10m1=stddev(obsws10m1(744:1487))
stddevobsws10m2=stddev(obsws10m2(744:1487))
stddevobsws10m3=stddev(obsws10m3(744:1487))
stddevobsws10m4=stddev(obsws10m4(744:1487))
stddevobsws10m5=stddev(obsws10m5(744:1487))
stddevobsws10m6=stddev(obsws10m6(744:1487))
stddevobsws10m7=stddev(obsws10m7(744:1487))

avgobsrh1=avg(obsrh1(744:1487))
avgobsrh2=avg(obsrh2(744:1487))
avgobsrh3=avg(obsrh3(744:1487))
avgobsrh4=avg(obsrh4(744:1487))
avgobsrh5=avg(obsrh5(744:1487))
avgobsrh6=avg(obsrh6(744:1487))
avgobsrh7=avg(obsrh7(744:1487))
stddevobsrh1=stddev(obsrh1(744:1487))
stddevobsrh2=stddev(obsrh2(744:1487))
stddevobsrh3=stddev(obsrh3(744:1487))
stddevobsrh4=stddev(obsrh4(744:1487))
stddevobsrh5=stddev(obsrh5(744:1487))
stddevobsrh6=stddev(obsrh6(744:1487))
stddevobsrh7=stddev(obsrh7(744:1487))

avgt2m11=avg(t2m11)
avgt2m12=avg(t2m12)
avgt2m13=avg(t2m13)
avgt2m14=avg(t2m14)
avgt2m15=avg(t2m15)
avgt2m16=avg(t2m16)
avgt2m17=avg(t2m17)

stdt2m11=stddev(t2m11)
stdt2m12=stddev(t2m12)
stdt2m13=stddev(t2m13)
stdt2m14=stddev(t2m14)
stdt2m15=stddev(t2m15)
stdt2m16=stddev(t2m16)
stdt2m17=stddev(t2m17)

;MB,ME,NMB,NME,PCC
nt2m11=0.0
sumdiff_t2m11=0.0
sumabsdiff_t2m11=0.0
nt2m12=0.0
sumdiff_t2m12=0.0
sumabsdiff_t2m12=0.0
nt2m13=0.0
sumdiff_t2m13=0.0
sumabsdiff_t2m13=0.0
nt2m14=0.0
sumdiff_t2m14=0.0
sumabsdiff_t2m14=0.0
nt2m15=0.0
sumdiff_t2m15=0.0
sumabsdiff_t2m15=0.0
nt2m16=0.0
sumdiff_t2m16=0.0
sumabsdiff_t2m16=0.0
nt2m17=0.0
sumdiff_t2m17=0.0
sumabsdiff_t2m17=0.0

nt2m21=0.0
sumdiff_t2m21=0.0
sumabsdiff_t2m21=0.0
nt2m22=0.0
sumdiff_t2m22=0.0
sumabsdiff_t2m22=0.0
nt2m23=0.0
sumdiff_t2m23=0.0
sumabsdiff_t2m23=0.0
nt2m24=0.0
sumdiff_t2m24=0.0
sumabsdiff_t2m24=0.0
nt2m25=0.0
sumdiff_t2m25=0.0
sumabsdiff_t2m25=0.0
nt2m26=0.0
sumdiff_t2m26=0.0
sumabsdiff_t2m26=0.0
nt2m27=0.0
sumdiff_t2m27=0.0
sumabsdiff_t2m27=0.0

nt2m31=0.0
sumdiff_t2m31=0.0
sumabsdiff_t2m31=0.0
nt2m32=0.0
sumdiff_t2m32=0.0
sumabsdiff_t2m32=0.0
nt2m33=0.0
sumdiff_t2m33=0.0
sumabsdiff_t2m33=0.0
nt2m34=0.0
sumdiff_t2m34=0.0
sumabsdiff_t2m34=0.0
nt2m35=0.0
sumdiff_t2m35=0.0
sumabsdiff_t2m35=0.0
nt2m36=0.0
sumdiff_t2m36=0.0
sumabsdiff_t2m36=0.0
nt2m37=0.0
sumdiff_t2m37=0.0
sumabsdiff_t2m37=0.0

nt2m41=0.0
sumdiff_t2m41=0.0
sumabsdiff_t2m41=0.0
nt2m42=0.0
sumdiff_t2m42=0.0
sumabsdiff_t2m42=0.0
nt2m43=0.0
sumdiff_t2m43=0.0
sumabsdiff_t2m43=0.0
nt2m44=0.0
sumdiff_t2m44=0.0
sumabsdiff_t2m44=0.0
nt2m45=0.0
sumdiff_t2m45=0.0
sumabsdiff_t2m45=0.0
nt2m46=0.0
sumdiff_t2m46=0.0
sumabsdiff_t2m46=0.0
nt2m47=0.0
sumdiff_t2m47=0.0
sumabsdiff_t2m47=0.0

;READ PCAPS DATES
PCAPname =  "Numbers_N.csv"
countvar=asciiread(PCAPname, -1, "string")
delim=","
countt=str_get_field(countvar(0::), 1, delim)
count=tointeger(countt)
print(count(0))
print(count(446))

;DO AVERAGE OF PCAP OBS
newobst2m1=new(447,float)
newobst2m2=new(447,float)
newobst2m3=new(447,float)
newobst2m4=new(447,float)
newobst2m5=new(447,float)
newobst2m6=new(447,float)
newobst2m7=new(447,float)

newobsws10m1=new(447,float)
newobsws10m2=new(447,float)
newobsws10m3=new(447,float)
newobsws10m4=new(447,float)
newobsws10m5=new(447,float)
newobsws10m6=new(447,float)
newobsws10m7=new(447,float)

newobsrh1=new(447,float)
newobsrh2=new(447,float)
newobsrh3=new(447,float)
newobsrh4=new(447,float)
newobsrh5=new(447,float)
newobsrh6=new(447,float)
newobsrh7=new(447,float)
do j=0,446,1
    i=count(j)
    newobst2m1(j)=obst2m1(i+744)
    newobst2m2(j)=obst2m2(i+744)
    newobst2m3(j)=obst2m3(i+744)
    newobst2m4(j)=obst2m4(i+744)
    newobst2m5(j)=obst2m5(i+744)
    newobst2m6(j)=obst2m6(i+744)
    newobst2m7(j)=obst2m7(i+744)

    newobsws10m1(j)=obsws10m1(i+744)
    newobsws10m2(j)=obsws10m2(i+744)
    newobsws10m3(j)=obsws10m3(i+744)
    newobsws10m4(j)=obsws10m4(i+744)
    newobsws10m5(j)=obsws10m5(i+744)
    newobsws10m6(j)=obsws10m6(i+744)
    newobsws10m7(j)=obsws10m7(i+744)

    newobsrh1(j)=obsrh1(i+744)
    newobsrh2(j)=obsrh2(i+744)
    newobsrh3(j)=obsrh3(i+744)
    newobsrh4(j)=obsrh4(i+744)
    newobsrh5(j)=obsrh5(i+744)
    newobsrh6(j)=obsrh6(i+744)
    newobsrh7(j)=obsrh7(i+744)
end do
avgnewobst2m1=avg(newobst2m1)
avgnewobst2m2=avg(newobst2m2)
avgnewobst2m3=avg(newobst2m3)
avgnewobst2m4=avg(newobst2m4)
avgnewobst2m5=avg(newobst2m5)
avgnewobst2m6=avg(newobst2m6)
avgnewobst2m7=avg(newobst2m7)

stddevnewobst2m1=stddev(newobst2m1)
stddevnewobst2m2=stddev(newobst2m2)
stddevnewobst2m3=stddev(newobst2m3)
stddevnewobst2m4=stddev(newobst2m4)
stddevnewobst2m5=stddev(newobst2m5)
stddevnewobst2m6=stddev(newobst2m6)
stddevnewobst2m7=stddev(newobst2m7)

avgnewobsws10m1=avg(newobsws10m1)
avgnewobsws10m2=avg(newobsws10m2)
avgnewobsws10m3=avg(newobsws10m3)
avgnewobsws10m4=avg(newobsws10m4)
avgnewobsws10m5=avg(newobsws10m5)
avgnewobsws10m6=avg(newobsws10m6)
avgnewobsws10m7=avg(newobsws10m7)

stddevnewobsws10m1=stddev(newobsws10m1)
stddevnewobsws10m2=stddev(newobsws10m2)
stddevnewobsws10m3=stddev(newobsws10m3)
stddevnewobsws10m4=stddev(newobsws10m4)
stddevnewobsws10m5=stddev(newobsws10m5)
stddevnewobsws10m6=stddev(newobsws10m6)
stddevnewobsws10m7=stddev(newobsws10m7)

avgnewobsrh1=avg(newobsrh1)
avgnewobsrh2=avg(newobsrh2)
avgnewobsrh3=avg(newobsrh3)
avgnewobsrh4=avg(newobsrh4)
avgnewobsrh5=avg(newobsrh5)
avgnewobsrh6=avg(newobsrh6)
avgnewobsrh7=avg(newobsrh7)

stddevnewobsrh1=stddev(newobsrh1)
stddevnewobsrh2=stddev(newobsrh2)
stddevnewobsrh3=stddev(newobsrh3)
stddevnewobsrh4=stddev(newobsrh4)
stddevnewobsrh5=stddev(newobsrh5)
stddevnewobsrh6=stddev(newobsrh6)
stddevnewobsrh7=stddev(newobsrh7)

do j=0,446,1
 i =count(j)
    print(i)
    if(.not.ismissing(obst2m1(i+744)))
     diff_t2m11=t2m11(i)-obst2m1(i+744)
          absdiff_t2m11=abs(t2m11(i)-obst2m1(i+744))
         nt2m11=nt2m11+1
        sumdiff_t2m11=sumdiff_t2m11+diff_t2m11
        sumabsdiff_t2m11=sumabsdiff_t2m11+absdiff_t2m11

        diff_t2m21=t2m21(i)-obst2m1(i+744)
        absdiff_t2m21=abs(t2m21(i)-obst2m1(i+744))
        sumdiff_t2m21=sumdiff_t2m21+diff_t2m21
        sumabsdiff_t2m21=sumabsdiff_t2m21+absdiff_t2m21

        diff_t2m31=t2m31(i)-obst2m1(i+744)
        absdiff_t2m31=abs(t2m31(i)-obst2m1(i+744))
        sumdiff_t2m31=sumdiff_t2m31+diff_t2m31
        sumabsdiff_t2m31=sumabsdiff_t2m31+absdiff_t2m31


        diff_t2m41=t2m41(i)-obst2m1(i+744)
        absdiff_t2m41=abs(t2m41(i)-obst2m1(i+744))
        sumdiff_t2m41=sumdiff_t2m41+diff_t2m41
        sumabsdiff_t2m41=sumabsdiff_t2m41+absdiff_t2m41

       end if

        if(.not.ismissing(obst2m2(i+744)))
     diff_t2m12=t2m12(i)-obst2m2(i+744)
          absdiff_t2m12=abs(t2m12(i)-obst2m2(i+744))
         nt2m12=nt2m12+1
        sumdiff_t2m12=sumdiff_t2m12+diff_t2m12
        sumabsdiff_t2m12=sumabsdiff_t2m12+absdiff_t2m12

        diff_t2m22=t2m21(i)-obst2m2(i+744)
        absdiff_t2m22=abs(t2m22(i)-obst2m2(i+744))
        sumdiff_t2m22=sumdiff_t2m22+diff_t2m22
        sumabsdiff_t2m22=sumabsdiff_t2m22+absdiff_t2m22

        diff_t2m32=t2m32(i)-obst2m2(i+744)
        absdiff_t2m32=abs(t2m32(i)-obst2m2(i+744))
        sumdiff_t2m32=sumdiff_t2m32+diff_t2m32
        sumabsdiff_t2m32=sumabsdiff_t2m32+absdiff_t2m32


        diff_t2m42=t2m42(i)-obst2m2(i+744)
        absdiff_t2m42=abs(t2m42(i)-obst2m2(i+744))
        sumdiff_t2m42=sumdiff_t2m42+diff_t2m42
        sumabsdiff_t2m42=sumabsdiff_t2m42+absdiff_t2m42

       end if

        if(.not.ismissing(obst2m3(i+744)))
     diff_t2m13=t2m13(i)-obst2m3(i+744)
          absdiff_t2m13=abs(t2m13(i)-obst2m3(i+744))
         nt2m13=nt2m13+1
        sumdiff_t2m13=sumdiff_t2m13+diff_t2m13
        sumabsdiff_t2m13=sumabsdiff_t2m13+absdiff_t2m13

        diff_t2m23=t2m23(i)-obst2m3(i+744)
        absdiff_t2m23=abs(t2m23(i)-obst2m3(i+744))
        sumdiff_t2m23=sumdiff_t2m23+diff_t2m23
        sumabsdiff_t2m23=sumabsdiff_t2m23+absdiff_t2m23

        diff_t2m33=t2m33(i)-obst2m3(i+744)
        absdiff_t2m33=abs(t2m33(i)-obst2m3(i+744))
        sumdiff_t2m33=sumdiff_t2m33+diff_t2m33
        sumabsdiff_t2m33=sumabsdiff_t2m33+absdiff_t2m33


        diff_t2m43=t2m43(i)-obst2m3(i+744)
        absdiff_t2m43=abs(t2m43(i)-obst2m3(i+744))
        sumdiff_t2m43=sumdiff_t2m43+diff_t2m43
        sumabsdiff_t2m43=sumabsdiff_t2m43+absdiff_t2m43

       end if
      if(.not.ismissing(obst2m4(i+744)))
     diff_t2m14=t2m14(i)-obst2m4(i+744)
          absdiff_t2m14=abs(t2m14(i)-obst2m4(i+744))
         nt2m14=nt2m14+1
        sumdiff_t2m14=sumdiff_t2m14+diff_t2m14
        sumabsdiff_t2m14=sumabsdiff_t2m14+absdiff_t2m14

        diff_t2m24=t2m24(i)-obst2m4(i+744)
        absdiff_t2m24=abs(t2m24(i)-obst2m4(i+744))
        sumdiff_t2m24=sumdiff_t2m24+diff_t2m24
        sumabsdiff_t2m24=sumabsdiff_t2m24+absdiff_t2m24

        diff_t2m34=t2m34(i)-obst2m4(i+744)
        absdiff_t2m34=abs(t2m34(i)-obst2m4(i+744))
        sumdiff_t2m34=sumdiff_t2m34+diff_t2m34
        sumabsdiff_t2m34=sumabsdiff_t2m34+absdiff_t2m34


        diff_t2m44=t2m44(i)-obst2m4(i+744)
        absdiff_t2m44=abs(t2m44(i)-obst2m4(i+744))
        sumdiff_t2m44=sumdiff_t2m44+diff_t2m44
        sumabsdiff_t2m44=sumabsdiff_t2m44+absdiff_t2m44

       end if

         if(.not.ismissing(obst2m5(i+744)))
     diff_t2m15=t2m15(i)-obst2m5(i+744)
          absdiff_t2m15=abs(t2m15(i)-obst2m5(i+744))
         nt2m15=nt2m15+1
        sumdiff_t2m15=sumdiff_t2m15+diff_t2m15
        sumabsdiff_t2m15=sumabsdiff_t2m15+absdiff_t2m15

        diff_t2m25=t2m25(i)-obst2m5(i+744)
        absdiff_t2m25=abs(t2m25(i)-obst2m5(i+744))
        sumdiff_t2m25=sumdiff_t2m25+diff_t2m25
        sumabsdiff_t2m25=sumabsdiff_t2m25+absdiff_t2m25

        diff_t2m35=t2m35(i)-obst2m5(i+744)
        absdiff_t2m35=abs(t2m35(i)-obst2m5(i+744))
        sumdiff_t2m35=sumdiff_t2m35+diff_t2m35
        sumabsdiff_t2m35=sumabsdiff_t2m35+absdiff_t2m35


        diff_t2m45=t2m45(i)-obst2m5(i+744)
        absdiff_t2m45=abs(t2m45(i)-obst2m5(i+744))
        sumdiff_t2m45=sumdiff_t2m45+diff_t2m45
        sumabsdiff_t2m45=sumabsdiff_t2m45+absdiff_t2m45

       end if

       if(.not.ismissing(obst2m6(i+744)))
     diff_t2m16=t2m16(i)-obst2m6(i+744)
          absdiff_t2m16=abs(t2m16(i)-obst2m6(i+744))
         nt2m16=nt2m16+1
        sumdiff_t2m16=sumdiff_t2m16+diff_t2m16
        sumabsdiff_t2m16=sumabsdiff_t2m16+absdiff_t2m16

        diff_t2m26=t2m26(i)-obst2m6(i+744)
        absdiff_t2m26=abs(t2m26(i)-obst2m6(i+744))
        sumdiff_t2m26=sumdiff_t2m26+diff_t2m26
        sumabsdiff_t2m26=sumabsdiff_t2m26+absdiff_t2m26

        diff_t2m36=t2m36(i)-obst2m6(i+744)
        absdiff_t2m36=abs(t2m36(i)-obst2m6(i+744))
        sumdiff_t2m36=sumdiff_t2m36+diff_t2m36
        sumabsdiff_t2m36=sumabsdiff_t2m36+absdiff_t2m36


        diff_t2m46=t2m46(i)-obst2m6(i+744)
        absdiff_t2m46=abs(t2m46(i)-obst2m6(i+744))
        sumdiff_t2m46=sumdiff_t2m46+diff_t2m46
        sumabsdiff_t2m46=sumabsdiff_t2m46+absdiff_t2m46

       end if

       if(.not.ismissing(obst2m7(i+744)))
     diff_t2m17=t2m17(i)-obst2m7(i+744)
          absdiff_t2m17=abs(t2m17(i)-obst2m7(i+744))
         nt2m17=nt2m17+1
        sumdiff_t2m17=sumdiff_t2m17+diff_t2m17
        sumabsdiff_t2m17=sumabsdiff_t2m17+absdiff_t2m17

        diff_t2m27=t2m27(i)-obst2m7(i+744)
        absdiff_t2m27=abs(t2m27(i)-obst2m7(i+744))
        sumdiff_t2m27=sumdiff_t2m27+diff_t2m27
        sumabsdiff_t2m27=sumabsdiff_t2m27+absdiff_t2m27

        diff_t2m37=t2m37(i)-obst2m7(i+744)
        absdiff_t2m37=abs(t2m37(i)-obst2m7(i+744))
        sumdiff_t2m37=sumdiff_t2m37+diff_t2m37
        sumabsdiff_t2m37=sumabsdiff_t2m37+absdiff_t2m37


        diff_t2m47=t2m47(i)-obst2m7(i+744)
        absdiff_t2m47=abs(t2m47(i)-obst2m7(i+744))
        sumdiff_t2m47=sumdiff_t2m47+diff_t2m47
        sumabsdiff_t2m47=sumabsdiff_t2m47+absdiff_t2m47

       end if

end do
;print(nt2m11)
mbt2m11=sumdiff_t2m11/nt2m11
met2m11=sumabsdiff_t2m11/nt2m11
nmbt2m11=100*sumdiff_t2m11/sum(obst2m1(744:1487))
nmet2m11=100*sumabsdiff_t2m11/sum(obst2m1(744:1487))
rt2m11=escorc(t2m11(0:743),obst2m1(744:1487))
tt2m11=rt2m11*sqrt((nt2m11-2)/(1-rt2m11^2))
dft2m11=nt2m11-2
pt2m11=student_t(tt2m11,dft2m11) ;test significance level at the 95% level
if (pt2m11.le.0.05) then
    psig_t2m11="yes"
 else
   psig_t2m11="no"
end if
;print(mbt2m11)
;print(met2m11)
;print(nmbt2m11)
;print(nmet2m11)
;print(rt2m11)
;print(pt2m11)
;print(psig_t2m11)

mbt2m21=sumdiff_t2m21/nt2m11
met2m21=sumabsdiff_t2m21/nt2m11
nmbt2m21=100*sumdiff_t2m21/sum(obst2m1(744:1487))
nmet2m21=100*sumabsdiff_t2m21/sum(obst2m1(744:1487))
rt2m21=escorc(t2m21(0:743),obst2m1(744:1487))
tt2m21=rt2m21*sqrt((nt2m11-2)/(1-rt2m21^2))
dft2m21=nt2m11-2
pt2m21=student_t(tt2m21,dft2m21) ;test significance level at the 95% level
if (pt2m21.le.0.05) then
    psig_t2m21="yes"
 else
   psig_t2m21="no"
end if



mbt2m31=sumdiff_t2m31/nt2m11
met2m31=sumabsdiff_t2m31/nt2m11
nmbt2m31=100*sumdiff_t2m31/sum(obst2m1(744:1487))
nmet2m31=100*sumabsdiff_t2m31/sum(obst2m1(744:1487))
rt2m31=escorc(t2m31(0:743),obst2m1(744:1487))
tt2m31=rt2m31*sqrt((nt2m11-2)/(1-rt2m31^2))
dft2m31=nt2m11-2
pt2m31=student_t(tt2m31,dft2m31) ;test significance level at the 95% level
if (pt2m31.le.0.05) then
    psig_t2m31="yes"
 else
   psig_t2m31="no"
end if

mbt2m41=sumdiff_t2m41/nt2m11
met2m41=sumabsdiff_t2m41/nt2m11
nmbt2m41=100*sumdiff_t2m41/sum(obst2m1(744:1487))
nmet2m41=100*sumabsdiff_t2m41/sum(obst2m1(744:1487))
rt2m41=escorc(t2m41(0:743),obst2m1(744:1487))
tt2m41=rt2m41*sqrt((nt2m11-2)/(1-rt2m41^2))
dft2m41=nt2m11-2
pt2m41=student_t(tt2m41,dft2m41) ;test significance level at the 95% level
if (pt2m41.le.0.05) then
    psig_t2m41="yes"
 else
   psig_t2m41="no"
end if


mbt2m12=sumdiff_t2m12/nt2m12
met2m12=sumabsdiff_t2m12/nt2m12
nmbt2m12=100*sumdiff_t2m12/sum(obst2m2(744:1487))
nmet2m12=100*sumabsdiff_t2m12/sum(obst2m2(744:1487))
rt2m12=escorc(t2m12(0:743),obst2m2(744:1487))
tt2m12=rt2m12*sqrt((nt2m12-2)/(1-rt2m12^2))
dft2m12=nt2m12-2
pt2m12=student_t(tt2m12,dft2m12) ;test significance level at the 95% level
if (pt2m12.le.0.05) then
    psig_t2m12="yes"
 else
   psig_t2m12="no"
end if
;print(mbt2m12)
;print(met2m12)
;print(nmbt2m12)
;print(nmet2m12)
;print(rt2m12)
;print(pt2m12)
;print(psig_t2m12)

mbt2m22=sumdiff_t2m22/nt2m12
met2m22=sumabsdiff_t2m22/nt2m12
nmbt2m22=100*sumdiff_t2m22/sum(obst2m2(744:1487))
nmet2m22=100*sumabsdiff_t2m22/sum(obst2m2(744:1487))
rt2m22=escorc(t2m22(0:743),obst2m2(744:1487))
tt2m22=rt2m22*sqrt((nt2m12-2)/(1-rt2m22^2))
dft2m22=nt2m12-2
pt2m22=student_t(tt2m22,dft2m22) ;test significance level at the 95% level
if (pt2m22.le.0.05) then
    psig_t2m22="yes"
 else
   psig_t2m22="no"
end if



mbt2m32=sumdiff_t2m32/nt2m12
met2m32=sumabsdiff_t2m32/nt2m12
nmbt2m32=100*sumdiff_t2m32/sum(obst2m2(744:1487))
nmet2m32=100*sumabsdiff_t2m32/sum(obst2m2(744:1487))
rt2m32=escorc(t2m32(0:743),obst2m2(744:1487))
tt2m32=rt2m32*sqrt((nt2m12-2)/(1-rt2m32^2))
dft2m32=nt2m12-2
pt2m32=student_t(tt2m32,dft2m32) ;test significance level at the 95% level
if (pt2m32.le.0.05) then
    psig_t2m32="yes"
 else
   psig_t2m32="no"
end if

mbt2m42=sumdiff_t2m42/nt2m12
met2m42=sumabsdiff_t2m42/nt2m12
nmbt2m42=100*sumdiff_t2m42/sum(obst2m2(744:1487))
nmet2m42=100*sumabsdiff_t2m42/sum(obst2m2(744:1487))
rt2m42=escorc(t2m42(0:743),obst2m2(744:1487))
tt2m42=rt2m42*sqrt((nt2m12-2)/(1-rt2m42^2))
dft2m42=nt2m12-2
pt2m42=student_t(tt2m42,dft2m42) ;test significance level at the 95% level
if (pt2m42.le.0.05) then
    psig_t2m42="yes"
 else
   psig_t2m42="no"
end if

mbt2m13=sumdiff_t2m13/nt2m13
met2m13=sumabsdiff_t2m13/nt2m13
nmbt2m13=100*sumdiff_t2m13/sum(obst2m3(744:1487))
nmet2m13=100*sumabsdiff_t2m13/sum(obst2m3(744:1487))
rt2m13=escorc(t2m13(0:743),obst2m3(744:1487))
tt2m13=rt2m13*sqrt((nt2m13-2)/(1-rt2m13^2))
dft2m13=nt2m13-2
pt2m13=student_t(tt2m13,dft2m13) ;test significance level at the 95% level
if (pt2m13.le.0.05) then
    psig_t2m13="yes"
 else
   psig_t2m13="no"
end if
;print(mbt2m13)
;print(met2m13)
;print(nmbt2m13)
;print(nmet2m13)
;print(rt2m13)
;print(pt2m13)
;print(psig_t2m13)

mbt2m23=sumdiff_t2m23/nt2m13
met2m23=sumabsdiff_t2m23/nt2m13
nmbt2m23=100*sumdiff_t2m23/sum(obst2m3(744:1487))
nmet2m23=100*sumabsdiff_t2m23/sum(obst2m3(744:1487))
rt2m23=escorc(t2m23(0:743),obst2m3(744:1487))
tt2m23=rt2m23*sqrt((nt2m13-2)/(1-rt2m23^2))
dft2m23=nt2m13-2
pt2m23=student_t(tt2m23,dft2m23) ;test significance level at the 95% level
if (pt2m23.le.0.05) then
    psig_t2m23="yes"
 else
   psig_t2m23="no"
end if



mbt2m33=sumdiff_t2m33/nt2m13
met2m33=sumabsdiff_t2m33/nt2m13
nmbt2m33=100*sumdiff_t2m33/sum(obst2m3(744:1487))
nmet2m33=100*sumabsdiff_t2m33/sum(obst2m3(744:1487))
rt2m33=escorc(t2m33(0:743),obst2m3(744:1487))
tt2m33=rt2m33*sqrt((nt2m13-2)/(1-rt2m33^2))
dft2m33=nt2m13-2
pt2m33=student_t(tt2m33,dft2m33) ;test significance level at the 95% level
if (pt2m33.le.0.05) then
    psig_t2m33="yes"
 else
   psig_t2m33="no"
end if

mbt2m43=sumdiff_t2m43/nt2m13
met2m43=sumabsdiff_t2m43/nt2m13
nmbt2m43=100*sumdiff_t2m43/sum(obst2m3(744:1487))
nmet2m43=100*sumabsdiff_t2m43/sum(obst2m3(744:1487))
rt2m43=escorc(t2m43(0:743),obst2m3(744:1487))
tt2m43=rt2m43*sqrt((nt2m13-2)/(1-rt2m43^2))
dft2m43=nt2m13-2
pt2m43=student_t(tt2m43,dft2m43) ;test significance level at the 95% level
if (pt2m43.le.0.05) then
    psig_t2m43="yes"
 else
   psig_t2m43="no"
end if

mbt2m14=sumdiff_t2m14/nt2m14
met2m14=sumabsdiff_t2m14/nt2m14
nmbt2m14=100*sumdiff_t2m14/sum(obst2m4(744:1487))
nmet2m14=100*sumabsdiff_t2m14/sum(obst2m4(744:1487))
rt2m14=escorc(t2m14(0:743),obst2m4(744:1487))
tt2m14=rt2m14*sqrt((nt2m14-2)/(1-rt2m14^2))
dft2m14=nt2m14-2
pt2m14=student_t(tt2m14,dft2m14) ;test significance level at the 95% level
if (pt2m14.le.0.05) then
    psig_t2m14="yes"
 else
   psig_t2m14="no"
end if
;print(mbt2m14)
;print(met2m14)
;print(nmbt2m14)
;print(nmet2m14)
;print(rt2m14)
;print(pt2m14)
;print(psig_t2m14)

mbt2m24=sumdiff_t2m24/nt2m14
met2m24=sumabsdiff_t2m24/nt2m14
nmbt2m24=100*sumdiff_t2m24/sum(obst2m4(744:1487))
nmet2m24=100*sumabsdiff_t2m24/sum(obst2m4(744:1487))
rt2m24=escorc(t2m24(0:743),obst2m4(744:1487))
tt2m24=rt2m24*sqrt((nt2m14-2)/(1-rt2m24^2))
dft2m24=nt2m14-2
pt2m24=student_t(tt2m24,dft2m24) ;test significance level at the 95% level
if (pt2m24.le.0.05) then
    psig_t2m24="yes"
 else
   psig_t2m24="no"
end if



mbt2m34=sumdiff_t2m34/nt2m14
met2m34=sumabsdiff_t2m34/nt2m14
nmbt2m34=100*sumdiff_t2m34/sum(obst2m4(744:1487))
nmet2m34=100*sumabsdiff_t2m34/sum(obst2m4(744:1487))
rt2m34=escorc(t2m34(0:743),obst2m4(744:1487))
tt2m34=rt2m34*sqrt((nt2m14-2)/(1-rt2m34^2))
dft2m34=nt2m14-2
pt2m34=student_t(tt2m34,dft2m34) ;test significance level at the 95% level
if (pt2m34.le.0.05) then
    psig_t2m34="yes"
 else
   psig_t2m34="no"
end if

mbt2m44=sumdiff_t2m44/nt2m14
met2m44=sumabsdiff_t2m44/nt2m14
nmbt2m44=100*sumdiff_t2m44/sum(obst2m4(744:1487))
nmet2m44=100*sumabsdiff_t2m44/sum(obst2m4(744:1487))
rt2m44=escorc(t2m44(0:743),obst2m4(744:1487))
tt2m44=rt2m44*sqrt((nt2m14-2)/(1-rt2m44^2))
dft2m44=nt2m14-2
pt2m44=student_t(tt2m44,dft2m44) ;test significance level at the 95% level
if (pt2m44.le.0.05) then
    psig_t2m44="yes"
 else
   psig_t2m44="no"
end if

mbt2m15=sumdiff_t2m15/nt2m15
met2m15=sumabsdiff_t2m15/nt2m15
nmbt2m15=100*sumdiff_t2m15/sum(obst2m5(744:1487))
nmet2m15=100*sumabsdiff_t2m15/sum(obst2m5(744:1487))
rt2m15=escorc(t2m15(0:743),obst2m5(744:1487))
tt2m15=rt2m15*sqrt((nt2m15-2)/(1-rt2m15^2))
dft2m15=nt2m15-2
pt2m15=student_t(tt2m15,dft2m15) ;test significance level at the 95% level
if (pt2m15.le.0.05) then
    psig_t2m15="yes"
 else
   psig_t2m15="no"
end if
;print(mbt2m15)
;print(met2m15)
;print(nmbt2m15)
;print(nmet2m15)
;print(rt2m15)
;print(pt2m15)
;print(psig_t2m15)

mbt2m25=sumdiff_t2m25/nt2m15
met2m25=sumabsdiff_t2m25/nt2m15
nmbt2m25=100*sumdiff_t2m25/sum(obst2m5(744:1487))
nmet2m25=100*sumabsdiff_t2m25/sum(obst2m5(744:1487))
rt2m25=escorc(t2m25(0:743),obst2m5(744:1487))
tt2m25=rt2m25*sqrt((nt2m15-2)/(1-rt2m25^2))
dft2m25=nt2m15-2
pt2m25=student_t(tt2m25,dft2m25) ;test significance level at the 95% level
if (pt2m25.le.0.05) then
    psig_t2m25="yes"
 else
   psig_t2m25="no"
end if



mbt2m35=sumdiff_t2m35/nt2m15
met2m35=sumabsdiff_t2m35/nt2m15
nmbt2m35=100*sumdiff_t2m35/sum(obst2m5(744:1487))
nmet2m35=100*sumabsdiff_t2m35/sum(obst2m5(744:1487))
rt2m35=escorc(t2m35(0:743),obst2m5(744:1487))
tt2m35=rt2m35*sqrt((nt2m15-2)/(1-rt2m35^2))
dft2m35=nt2m15-2
pt2m35=student_t(tt2m35,dft2m35) ;test significance level at the 95% level
if (pt2m35.le.0.05) then
    psig_t2m35="yes"
 else
   psig_t2m35="no"
end if

mbt2m45=sumdiff_t2m45/nt2m15
met2m45=sumabsdiff_t2m45/nt2m15
nmbt2m45=100*sumdiff_t2m45/sum(obst2m5(744:1487))
nmet2m45=100*sumabsdiff_t2m45/sum(obst2m5(744:1487))
rt2m45=escorc(t2m45(0:743),obst2m5(744:1487))
tt2m45=rt2m45*sqrt((nt2m15-2)/(1-rt2m45^2))
dft2m45=nt2m15-2
pt2m45=student_t(tt2m45,dft2m45) ;test significance level at the 95% level
if (pt2m45.le.0.05) then
    psig_t2m45="yes"
 else
   psig_t2m45="no"
end if

mbt2m16=sumdiff_t2m16/nt2m16
met2m16=sumabsdiff_t2m16/nt2m16
nmbt2m16=100*sumdiff_t2m16/sum(obst2m6(744:1487))
nmet2m16=100*sumabsdiff_t2m16/sum(obst2m6(744:1487))
rt2m16=escorc(t2m16(0:743),obst2m6(744:1487))
tt2m16=rt2m16*sqrt((nt2m16-2)/(1-rt2m16^2))
dft2m16=nt2m16-2
pt2m16=student_t(tt2m16,dft2m16) ;test significance level at the 95% level
if (pt2m16.le.0.05) then
    psig_t2m16="yes"
 else
   psig_t2m16="no"
end if
;print(mbt2m16)
;print(met2m16)
;print(nmbt2m16)
;print(nmet2m16)
;print(rt2m16)
;print(pt2m16)
;print(psig_t2m16)

mbt2m26=sumdiff_t2m26/nt2m16
met2m26=sumabsdiff_t2m26/nt2m16
nmbt2m26=100*sumdiff_t2m26/sum(obst2m6(744:1487))
nmet2m26=100*sumabsdiff_t2m26/sum(obst2m6(744:1487))
rt2m26=escorc(t2m26(0:743),obst2m6(744:1487))
tt2m26=rt2m26*sqrt((nt2m16-2)/(1-rt2m26^2))
dft2m26=nt2m16-2
pt2m26=student_t(tt2m26,dft2m26) ;test significance level at the 95% level
if (pt2m26.le.0.05) then
    psig_t2m26="yes"
 else
   psig_t2m26="no"
end if



mbt2m36=sumdiff_t2m36/nt2m16
met2m36=sumabsdiff_t2m36/nt2m16
nmbt2m36=100*sumdiff_t2m36/sum(obst2m6(744:1487))
nmet2m36=100*sumabsdiff_t2m36/sum(obst2m6(744:1487))
rt2m36=escorc(t2m36(0:743),obst2m6(744:1487))
tt2m36=rt2m36*sqrt((nt2m16-2)/(1-rt2m36^2))
dft2m36=nt2m16-2
pt2m36=student_t(tt2m36,dft2m36) ;test significance level at the 95% level
if (pt2m36.le.0.05) then
    psig_t2m36="yes"
 else
   psig_t2m36="no"
end if

mbt2m46=sumdiff_t2m46/nt2m16
met2m46=sumabsdiff_t2m46/nt2m16
nmbt2m46=100*sumdiff_t2m46/sum(obst2m6(744:1487))
nmet2m46=100*sumabsdiff_t2m46/sum(obst2m6(744:1487))
rt2m46=escorc(t2m46(0:743),obst2m6(744:1487))
tt2m46=rt2m46*sqrt((nt2m16-2)/(1-rt2m46^2))
dft2m46=nt2m16-2
pt2m46=student_t(tt2m46,dft2m46) ;test significance level at the 95% level
if (pt2m46.le.0.05) then
    psig_t2m46="yes"
 else
   psig_t2m46="no"
end if

mbt2m17=sumdiff_t2m17/nt2m17
met2m17=sumabsdiff_t2m17/nt2m17
nmbt2m17=100*sumdiff_t2m17/sum(obst2m7(744:1487))
nmet2m17=100*sumabsdiff_t2m17/sum(obst2m7(744:1487))
rt2m17=escorc(t2m17(0:743),obst2m7(744:1487))
tt2m17=rt2m17*sqrt((nt2m17-2)/(1-rt2m17^2))
dft2m17=nt2m17-2
pt2m17=student_t(tt2m17,dft2m17) ;test significance level at the 95% level
if (pt2m17.le.0.05) then
    psig_t2m17="yes"
 else
   psig_t2m17="no"
end if
;print(mbt2m17)
;print(met2m17)
;print(nmbt2m17)
;print(nmet2m17)
;print(rt2m17)
;print(pt2m17)
;print(psig_t2m17)

mbt2m27=sumdiff_t2m27/nt2m17
met2m27=sumabsdiff_t2m27/nt2m17
nmbt2m27=100*sumdiff_t2m27/sum(obst2m7(744:1487))
nmet2m27=100*sumabsdiff_t2m27/sum(obst2m7(744:1487))
rt2m27=escorc(t2m27(0:743),obst2m7(744:1487))
tt2m27=rt2m27*sqrt((nt2m17-2)/(1-rt2m27^2))
dft2m27=nt2m17-2
pt2m27=student_t(tt2m27,dft2m27) ;test significance level at the 95% level
if (pt2m27.le.0.05) then
    psig_t2m27="yes"
 else
   psig_t2m27="no"
end if



mbt2m37=sumdiff_t2m37/nt2m17
met2m37=sumabsdiff_t2m37/nt2m17
nmbt2m37=100*sumdiff_t2m37/sum(obst2m7(744:1487))
nmet2m37=100*sumabsdiff_t2m37/sum(obst2m7(744:1487))
rt2m37=escorc(t2m37(0:743),obst2m7(744:1487))
tt2m37=rt2m37*sqrt((nt2m17-2)/(1-rt2m37^2))
dft2m37=nt2m17-2
pt2m37=student_t(tt2m37,dft2m37) ;test significance level at the 95% level
if (pt2m37.le.0.05) then
    psig_t2m37="yes"
 else
   psig_t2m37="no"
end if

mbt2m47=sumdiff_t2m47/nt2m17
met2m47=sumabsdiff_t2m47/nt2m17
nmbt2m47=100*sumdiff_t2m47/sum(obst2m7(744:1487))
nmet2m47=100*sumabsdiff_t2m47/sum(obst2m7(744:1487))
rt2m47=escorc(t2m47(0:743),obst2m7(744:1487))
tt2m47=rt2m47*sqrt((nt2m17-2)/(1-rt2m47^2))
dft2m47=nt2m17-2
pt2m47=student_t(tt2m47,dft2m47) ;test significance level at the 95% level
if (pt2m47.le.0.05) then
    psig_t2m47="yes"
 else
   psig_t2m47="no"
end if
;************FINISH DOING STATISTICS**************************



;***********BEGIN DOING STATISTICS for WS10m*****************
;MEANS & STDEV
avgws10m11=avg(ws10m11)
avgws10m12=avg(ws10m12)
avgws10m13=avg(ws10m13)
avgws10m14=avg(ws10m14)
avgws10m15=avg(ws10m15)
avgws10m16=avg(ws10m16)
avgws10m17=avg(ws10m17)

stdws10m11=stddev(ws10m11)
stdws10m12=stddev(ws10m12)
stdws10m13=stddev(ws10m13)
stdws10m14=stddev(ws10m14)
stdws10m15=stddev(ws10m15)
stdws10m16=stddev(ws10m16)
stdws10m17=stddev(ws10m17)

;MB,ME,NMB,NME,PCC
nws10m11=0.0
sumdiff_ws10m11=0.0
sumabsdiff_ws10m11=0.0
nws10m12=0.0
sumdiff_ws10m12=0.0
sumabsdiff_ws10m12=0.0
nws10m13=0.0
sumdiff_ws10m13=0.0
sumabsdiff_ws10m13=0.0
nws10m14=0.0
sumdiff_ws10m14=0.0
sumabsdiff_ws10m14=0.0
nws10m15=0.0
sumdiff_ws10m15=0.0
sumabsdiff_ws10m15=0.0
nws10m16=0.0
sumdiff_ws10m16=0.0
sumabsdiff_ws10m16=0.0
nws10m17=0.0
sumdiff_ws10m17=0.0
sumabsdiff_ws10m17=0.0

nws10m21=0.0
sumdiff_ws10m21=0.0
sumabsdiff_ws10m21=0.0
nws10m22=0.0
sumdiff_ws10m22=0.0
sumabsdiff_ws10m22=0.0
nws10m23=0.0
sumdiff_ws10m23=0.0
sumabsdiff_ws10m23=0.0
nws10m24=0.0
sumdiff_ws10m24=0.0
sumabsdiff_ws10m24=0.0
nws10m25=0.0
sumdiff_ws10m25=0.0
sumabsdiff_ws10m25=0.0
nws10m26=0.0
sumdiff_ws10m26=0.0
sumabsdiff_ws10m26=0.0
nws10m27=0.0
sumdiff_ws10m27=0.0
sumabsdiff_ws10m27=0.0

nws10m31=0.0
sumdiff_ws10m31=0.0
sumabsdiff_ws10m31=0.0
nws10m32=0.0
sumdiff_ws10m32=0.0
sumabsdiff_ws10m32=0.0
nws10m33=0.0
sumdiff_ws10m33=0.0
sumabsdiff_ws10m33=0.0
nws10m34=0.0
sumdiff_ws10m34=0.0
sumabsdiff_ws10m34=0.0
nws10m35=0.0
sumdiff_ws10m35=0.0
sumabsdiff_ws10m35=0.0
nws10m36=0.0
sumdiff_ws10m36=0.0
sumabsdiff_ws10m36=0.0
nws10m37=0.0
sumdiff_ws10m37=0.0
sumabsdiff_ws10m37=0.0

nws10m41=0.0
sumdiff_ws10m41=0.0
sumabsdiff_ws10m41=0.0
nws10m42=0.0
sumdiff_ws10m42=0.0
sumabsdiff_ws10m42=0.0
nws10m43=0.0
sumdiff_ws10m43=0.0
sumabsdiff_ws10m43=0.0
nws10m44=0.0
sumdiff_ws10m44=0.0
sumabsdiff_ws10m44=0.0
nws10m45=0.0
sumdiff_ws10m45=0.0
sumabsdiff_ws10m45=0.0
nws10m46=0.0
sumdiff_ws10m46=0.0
sumabsdiff_ws10m46=0.0
nws10m47=0.0
sumdiff_ws10m47=0.0
sumabsdiff_ws10m47=0.0
do j=0,446,1
  i =count(j)

    ;print(i)
    if(.not.ismissing(obsws10m1(i+744)))
     diff_ws10m11=ws10m11(i)-obsws10m1(i+744)
          absdiff_ws10m11=abs(ws10m11(i)-obsws10m1(i+744))
         nws10m11=nws10m11+1
        sumdiff_ws10m11=sumdiff_ws10m11+diff_ws10m11
        sumabsdiff_ws10m11=sumabsdiff_ws10m11+absdiff_ws10m11

        diff_ws10m21=ws10m21(i)-obsws10m1(i+744)
        absdiff_ws10m21=abs(ws10m21(i)-obsws10m1(i+744))
        sumdiff_ws10m21=sumdiff_ws10m21+diff_ws10m21
        sumabsdiff_ws10m21=sumabsdiff_ws10m21+absdiff_ws10m21

        diff_ws10m31=ws10m31(i)-obsws10m1(i+744)
        absdiff_ws10m31=abs(ws10m31(i)-obsws10m1(i+744))
        sumdiff_ws10m31=sumdiff_ws10m31+diff_ws10m31
        sumabsdiff_ws10m31=sumabsdiff_ws10m31+absdiff_ws10m31


        diff_ws10m41=ws10m41(i)-obsws10m1(i+744)
        absdiff_ws10m41=abs(ws10m41(i)-obsws10m1(i+744))
        sumdiff_ws10m41=sumdiff_ws10m41+diff_ws10m41
        sumabsdiff_ws10m41=sumabsdiff_ws10m41+absdiff_ws10m41

       end if

        if(.not.ismissing(obsws10m2(i+744)))
     diff_ws10m12=ws10m12(i)-obsws10m2(i+744)
          absdiff_ws10m12=abs(ws10m12(i)-obsws10m2(i+744))
         nws10m12=nws10m12+1
        sumdiff_ws10m12=sumdiff_ws10m12+diff_ws10m12
        sumabsdiff_ws10m12=sumabsdiff_ws10m12+absdiff_ws10m12

        diff_ws10m22=ws10m21(i)-obsws10m2(i+744)
        absdiff_ws10m22=abs(ws10m22(i)-obsws10m2(i+744))
        sumdiff_ws10m22=sumdiff_ws10m22+diff_ws10m22
        sumabsdiff_ws10m22=sumabsdiff_ws10m22+absdiff_ws10m22

        diff_ws10m32=ws10m32(i)-obsws10m2(i+744)
        absdiff_ws10m32=abs(ws10m32(i)-obsws10m2(i+744))
        sumdiff_ws10m32=sumdiff_ws10m32+diff_ws10m32
        sumabsdiff_ws10m32=sumabsdiff_ws10m32+absdiff_ws10m32


        diff_ws10m42=ws10m42(i)-obsws10m2(i+744)
        absdiff_ws10m42=abs(ws10m42(i)-obsws10m2(i+744))
        sumdiff_ws10m42=sumdiff_ws10m42+diff_ws10m42
        sumabsdiff_ws10m42=sumabsdiff_ws10m42+absdiff_ws10m42

       end if

        if(.not.ismissing(obsws10m3(i+744)))
     diff_ws10m13=ws10m13(i)-obsws10m3(i+744)
          absdiff_ws10m13=abs(ws10m13(i)-obsws10m3(i+744))
         nws10m13=nws10m13+1
        sumdiff_ws10m13=sumdiff_ws10m13+diff_ws10m13
        sumabsdiff_ws10m13=sumabsdiff_ws10m13+absdiff_ws10m13

        diff_ws10m23=ws10m23(i)-obsws10m3(i+744)
        absdiff_ws10m23=abs(ws10m23(i)-obsws10m3(i+744))
        sumdiff_ws10m23=sumdiff_ws10m23+diff_ws10m23
        sumabsdiff_ws10m23=sumabsdiff_ws10m23+absdiff_ws10m23

        diff_ws10m33=ws10m33(i)-obsws10m3(i+744)
        absdiff_ws10m33=abs(ws10m33(i)-obsws10m3(i+744))
        sumdiff_ws10m33=sumdiff_ws10m33+diff_ws10m33
        sumabsdiff_ws10m33=sumabsdiff_ws10m33+absdiff_ws10m33


        diff_ws10m43=ws10m43(i)-obsws10m3(i+744)
        absdiff_ws10m43=abs(ws10m43(i)-obsws10m3(i+744))
        sumdiff_ws10m43=sumdiff_ws10m43+diff_ws10m43
        sumabsdiff_ws10m43=sumabsdiff_ws10m43+absdiff_ws10m43

       end if
      if(.not.ismissing(obsws10m4(i+744)))
     diff_ws10m14=ws10m14(i)-obsws10m4(i+744)
          absdiff_ws10m14=abs(ws10m14(i)-obsws10m4(i+744))
         nws10m14=nws10m14+1
        sumdiff_ws10m14=sumdiff_ws10m14+diff_ws10m14
        sumabsdiff_ws10m14=sumabsdiff_ws10m14+absdiff_ws10m14

        diff_ws10m24=ws10m24(i)-obsws10m4(i+744)
        absdiff_ws10m24=abs(ws10m24(i)-obsws10m4(i+744))
        sumdiff_ws10m24=sumdiff_ws10m24+diff_ws10m24
        sumabsdiff_ws10m24=sumabsdiff_ws10m24+absdiff_ws10m24

        diff_ws10m34=ws10m34(i)-obsws10m4(i+744)
        absdiff_ws10m34=abs(ws10m34(i)-obsws10m4(i+744))
        sumdiff_ws10m34=sumdiff_ws10m34+diff_ws10m34
        sumabsdiff_ws10m34=sumabsdiff_ws10m34+absdiff_ws10m34


        diff_ws10m44=ws10m44(i)-obsws10m4(i+744)
        absdiff_ws10m44=abs(ws10m44(i)-obsws10m4(i+744))
        sumdiff_ws10m44=sumdiff_ws10m44+diff_ws10m44
        sumabsdiff_ws10m44=sumabsdiff_ws10m44+absdiff_ws10m44

       end if

         if(.not.ismissing(obsws10m5(i+744)))
     diff_ws10m15=ws10m15(i)-obsws10m5(i+744)
          absdiff_ws10m15=abs(ws10m15(i)-obsws10m5(i+744))
         nws10m15=nws10m15+1
        sumdiff_ws10m15=sumdiff_ws10m15+diff_ws10m15
        sumabsdiff_ws10m15=sumabsdiff_ws10m15+absdiff_ws10m15

        diff_ws10m25=ws10m25(i)-obsws10m5(i+744)
        absdiff_ws10m25=abs(ws10m25(i)-obsws10m5(i+744))
        sumdiff_ws10m25=sumdiff_ws10m25+diff_ws10m25
        sumabsdiff_ws10m25=sumabsdiff_ws10m25+absdiff_ws10m25

        diff_ws10m35=ws10m35(i)-obsws10m5(i+744)
        absdiff_ws10m35=abs(ws10m35(i)-obsws10m5(i+744))
        sumdiff_ws10m35=sumdiff_ws10m35+diff_ws10m35
        sumabsdiff_ws10m35=sumabsdiff_ws10m35+absdiff_ws10m35


        diff_ws10m45=ws10m45(i)-obsws10m5(i+744)
        absdiff_ws10m45=abs(ws10m45(i)-obsws10m5(i+744))
        sumdiff_ws10m45=sumdiff_ws10m45+diff_ws10m45
        sumabsdiff_ws10m45=sumabsdiff_ws10m45+absdiff_ws10m45

       end if

       if(.not.ismissing(obsws10m6(i+744)))
     diff_ws10m16=ws10m16(i)-obsws10m6(i+744)
          absdiff_ws10m16=abs(ws10m16(i)-obsws10m6(i+744))
         nws10m16=nws10m16+1
        sumdiff_ws10m16=sumdiff_ws10m16+diff_ws10m16
        sumabsdiff_ws10m16=sumabsdiff_ws10m16+absdiff_ws10m16

        diff_ws10m26=ws10m26(i)-obsws10m6(i+744)
        absdiff_ws10m26=abs(ws10m26(i)-obsws10m6(i+744))
        sumdiff_ws10m26=sumdiff_ws10m26+diff_ws10m26
        sumabsdiff_ws10m26=sumabsdiff_ws10m26+absdiff_ws10m26

        diff_ws10m36=ws10m36(i)-obsws10m6(i+744)
        absdiff_ws10m36=abs(ws10m36(i)-obsws10m6(i+744))
        sumdiff_ws10m36=sumdiff_ws10m36+diff_ws10m36
        sumabsdiff_ws10m36=sumabsdiff_ws10m36+absdiff_ws10m36


        diff_ws10m46=ws10m46(i)-obsws10m6(i+744)
        absdiff_ws10m46=abs(ws10m46(i)-obsws10m6(i+744))
        sumdiff_ws10m46=sumdiff_ws10m46+diff_ws10m46
        sumabsdiff_ws10m46=sumabsdiff_ws10m46+absdiff_ws10m46

       end if

       if(.not.ismissing(obsws10m7(i+744)))
     diff_ws10m17=ws10m17(i)-obsws10m7(i+744)
          absdiff_ws10m17=abs(ws10m17(i)-obsws10m7(i+744))
         nws10m17=nws10m17+1
        sumdiff_ws10m17=sumdiff_ws10m17+diff_ws10m17
        sumabsdiff_ws10m17=sumabsdiff_ws10m17+absdiff_ws10m17

        diff_ws10m27=ws10m27(i)-obsws10m7(i+744)
        absdiff_ws10m27=abs(ws10m27(i)-obsws10m7(i+744))
        sumdiff_ws10m27=sumdiff_ws10m27+diff_ws10m27
        sumabsdiff_ws10m27=sumabsdiff_ws10m27+absdiff_ws10m27

        diff_ws10m37=ws10m37(i)-obsws10m7(i+744)
        absdiff_ws10m37=abs(ws10m37(i)-obsws10m7(i+744))
        sumdiff_ws10m37=sumdiff_ws10m37+diff_ws10m37
        sumabsdiff_ws10m37=sumabsdiff_ws10m37+absdiff_ws10m37


        diff_ws10m47=ws10m47(i)-obsws10m7(i+744)
        absdiff_ws10m47=abs(ws10m47(i)-obsws10m7(i+744))
        sumdiff_ws10m47=sumdiff_ws10m47+diff_ws10m47
        sumabsdiff_ws10m47=sumabsdiff_ws10m47+absdiff_ws10m47

       end if

end do
;print(nws10m11)
mbws10m11=sumdiff_ws10m11/nws10m11
mews10m11=sumabsdiff_ws10m11/nws10m11
nmbws10m11=100*sumdiff_ws10m11/sum(obsws10m1(744:1487))
nmews10m11=100*sumabsdiff_ws10m11/sum(obsws10m1(744:1487))
rws10m11=escorc(ws10m11(0:743),obsws10m1(744:1487))
tws10m11=rws10m11*sqrt((nws10m11-2)/(1-rws10m11^2))
dfws10m11=nws10m11-2
pws10m11=student_t(tws10m11,dfws10m11) ;test significance level at the 95% level
if (pws10m11.le.0.05) then
    psig_ws10m11="yes"
 else
   psig_ws10m11="no"
end if
;print(mbws10m11)
;print(mews10m11)
;print(nmbws10m11)
;print(nmews10m11)
;print(rws10m11)
;print(pws10m11)
;print(psig_ws10m11)

mbws10m21=sumdiff_ws10m21/nws10m11
mews10m21=sumabsdiff_ws10m21/nws10m11
nmbws10m21=100*sumdiff_ws10m21/sum(obsws10m1(744:1487))
nmews10m21=100*sumabsdiff_ws10m21/sum(obsws10m1(744:1487))
rws10m21=escorc(ws10m21(0:743),obsws10m1(744:1487))
tws10m21=rws10m21*sqrt((nws10m11-2)/(1-rws10m21^2))
dfws10m21=nws10m11-2
pws10m21=student_t(tws10m21,dfws10m21) ;test significance level at the 95% level
if (pws10m21.le.0.05) then
    psig_ws10m21="yes"
 else
   psig_ws10m21="no"
end if



mbws10m31=sumdiff_ws10m31/nws10m11
mews10m31=sumabsdiff_ws10m31/nws10m11
nmbws10m31=100*sumdiff_ws10m31/sum(obsws10m1(744:1487))
nmews10m31=100*sumabsdiff_ws10m31/sum(obsws10m1(744:1487))
rws10m31=escorc(ws10m31(0:743),obsws10m1(744:1487))
tws10m31=rws10m31*sqrt((nws10m11-2)/(1-rws10m31^2))
dfws10m31=nws10m11-2
pws10m31=student_t(tws10m31,dfws10m31) ;test significance level at the 95% level
if (pws10m31.le.0.05) then
    psig_ws10m31="yes"
 else
   psig_ws10m31="no"
end if

mbws10m41=sumdiff_ws10m41/nws10m11
mews10m41=sumabsdiff_ws10m41/nws10m11
nmbws10m41=100*sumdiff_ws10m41/sum(obsws10m1(744:1487))
nmews10m41=100*sumabsdiff_ws10m41/sum(obsws10m1(744:1487))
rws10m41=escorc(ws10m41(0:743),obsws10m1(744:1487))
tws10m41=rws10m41*sqrt((nws10m11-2)/(1-rws10m41^2))
dfws10m41=nws10m11-2
pws10m41=student_t(tws10m41,dfws10m41) ;test significance level at the 95% level
if (pws10m41.le.0.05) then
    psig_ws10m41="yes"
 else
   psig_ws10m41="no"
end if


mbws10m12=sumdiff_ws10m12/nws10m12
mews10m12=sumabsdiff_ws10m12/nws10m12
nmbws10m12=100*sumdiff_ws10m12/sum(obsws10m2(744:1487))
nmews10m12=100*sumabsdiff_ws10m12/sum(obsws10m2(744:1487))
rws10m12=escorc(ws10m12(0:743),obsws10m2(744:1487))
tws10m12=rws10m12*sqrt((nws10m12-2)/(1-rws10m12^2))
dfws10m12=nws10m12-2
pws10m12=student_t(tws10m12,dfws10m12) ;test significance level at the 95% level
if (pws10m12.le.0.05) then
    psig_ws10m12="yes"
 else
   psig_ws10m12="no"
end if
;print(mbws10m12)
;print(mews10m12)
;print(nmbws10m12)
;print(nmews10m12)
;print(rws10m12)
;print(pws10m12)
;print(psig_ws10m12)

mbws10m22=sumdiff_ws10m22/nws10m12
mews10m22=sumabsdiff_ws10m22/nws10m12
nmbws10m22=100*sumdiff_ws10m22/sum(obsws10m2(744:1487))
nmews10m22=100*sumabsdiff_ws10m22/sum(obsws10m2(744:1487))
rws10m22=escorc(ws10m22(0:743),obsws10m2(744:1487))
tws10m22=rws10m22*sqrt((nws10m12-2)/(1-rws10m22^2))
dfws10m22=nws10m12-2
pws10m22=student_t(tws10m22,dfws10m22) ;test significance level at the 95% level
if (pws10m22.le.0.05) then
    psig_ws10m22="yes"
 else
   psig_ws10m22="no"
end if



mbws10m32=sumdiff_ws10m32/nws10m12
mews10m32=sumabsdiff_ws10m32/nws10m12
nmbws10m32=100*sumdiff_ws10m32/sum(obsws10m2(744:1487))
nmews10m32=100*sumabsdiff_ws10m32/sum(obsws10m2(744:1487))
rws10m32=escorc(ws10m32(0:743),obsws10m2(744:1487))
tws10m32=rws10m32*sqrt((nws10m12-2)/(1-rws10m32^2))
dfws10m32=nws10m12-2
pws10m32=student_t(tws10m32,dfws10m32) ;test significance level at the 95% level
if (pws10m32.le.0.05) then
    psig_ws10m32="yes"
 else
   psig_ws10m32="no"
end if

mbws10m42=sumdiff_ws10m42/nws10m12
mews10m42=sumabsdiff_ws10m42/nws10m12
nmbws10m42=100*sumdiff_ws10m42/sum(obsws10m2(744:1487))
nmews10m42=100*sumabsdiff_ws10m42/sum(obsws10m2(744:1487))
rws10m42=escorc(ws10m42(0:743),obsws10m2(744:1487))
tws10m42=rws10m42*sqrt((nws10m12-2)/(1-rws10m42^2))
dfws10m42=nws10m12-2
pws10m42=student_t(tws10m42,dfws10m42) ;test significance level at the 95% level
if (pws10m42.le.0.05) then
    psig_ws10m42="yes"
 else
   psig_ws10m42="no"
end if

mbws10m13=sumdiff_ws10m13/nws10m13
mews10m13=sumabsdiff_ws10m13/nws10m13
nmbws10m13=100*sumdiff_ws10m13/sum(obsws10m3(744:1487))
nmews10m13=100*sumabsdiff_ws10m13/sum(obsws10m3(744:1487))
rws10m13=escorc(ws10m13(0:743),obsws10m3(744:1487))
tws10m13=rws10m13*sqrt((nws10m13-2)/(1-rws10m13^2))
dfws10m13=nws10m13-2
pws10m13=student_t(tws10m13,dfws10m13) ;test significance level at the 95% level
if (pws10m13.le.0.05) then
    psig_ws10m13="yes"
 else
   psig_ws10m13="no"
end if
;print(mbws10m13)
;print(mews10m13)
;print(nmbws10m13)
;print(nmews10m13)
;print(rws10m13)
;print(pws10m13)
;print(psig_ws10m13)

mbws10m23=sumdiff_ws10m23/nws10m13
mews10m23=sumabsdiff_ws10m23/nws10m13
nmbws10m23=100*sumdiff_ws10m23/sum(obsws10m3(744:1487))
nmews10m23=100*sumabsdiff_ws10m23/sum(obsws10m3(744:1487))
rws10m23=escorc(ws10m23(0:743),obsws10m3(744:1487))
tws10m23=rws10m23*sqrt((nws10m13-2)/(1-rws10m23^2))
dfws10m23=nws10m13-2
pws10m23=student_t(tws10m23,dfws10m23) ;test significance level at the 95% level
if (pws10m23.le.0.05) then
    psig_ws10m23="yes"
 else
   psig_ws10m23="no"
end if



mbws10m33=sumdiff_ws10m33/nws10m13
mews10m33=sumabsdiff_ws10m33/nws10m13
nmbws10m33=100*sumdiff_ws10m33/sum(obsws10m3(744:1487))
nmews10m33=100*sumabsdiff_ws10m33/sum(obsws10m3(744:1487))
rws10m33=escorc(ws10m33(0:743),obsws10m3(744:1487))
tws10m33=rws10m33*sqrt((nws10m13-2)/(1-rws10m33^2))
dfws10m33=nws10m13-2
pws10m33=student_t(tws10m33,dfws10m33) ;test significance level at the 95% level
if (pws10m33.le.0.05) then
    psig_ws10m33="yes"
 else
   psig_ws10m33="no"
end if

mbws10m43=sumdiff_ws10m43/nws10m13
mews10m43=sumabsdiff_ws10m43/nws10m13
nmbws10m43=100*sumdiff_ws10m43/sum(obsws10m3(744:1487))
nmews10m43=100*sumabsdiff_ws10m43/sum(obsws10m3(744:1487))
rws10m43=escorc(ws10m43(0:743),obsws10m3(744:1487))
tws10m43=rws10m43*sqrt((nws10m13-2)/(1-rws10m43^2))
dfws10m43=nws10m13-2
pws10m43=student_t(tws10m43,dfws10m43) ;test significance level at the 95% level
if (pws10m43.le.0.05) then
    psig_ws10m43="yes"
 else
   psig_ws10m43="no"
end if

mbws10m14=sumdiff_ws10m14/nws10m14
mews10m14=sumabsdiff_ws10m14/nws10m14
nmbws10m14=100*sumdiff_ws10m14/sum(obsws10m4(744:1487))
nmews10m14=100*sumabsdiff_ws10m14/sum(obsws10m4(744:1487))
rws10m14=escorc(ws10m14(0:743),obsws10m4(744:1487))
tws10m14=rws10m14*sqrt((nws10m14-2)/(1-rws10m14^2))
dfws10m14=nws10m14-2
pws10m14=student_t(tws10m14,dfws10m14) ;test significance level at the 95% level
if (pws10m14.le.0.05) then
    psig_ws10m14="yes"
 else
   psig_ws10m14="no"
end if
;print(mbws10m14)
;print(mews10m14)
;print(nmbws10m14)
;print(nmews10m14)
;print(rws10m14)
;print(pws10m14)
;print(psig_ws10m14)

mbws10m24=sumdiff_ws10m24/nws10m14
mews10m24=sumabsdiff_ws10m24/nws10m14
nmbws10m24=100*sumdiff_ws10m24/sum(obsws10m4(744:1487))
nmews10m24=100*sumabsdiff_ws10m24/sum(obsws10m4(744:1487))
rws10m24=escorc(ws10m24(0:743),obsws10m4(744:1487))
tws10m24=rws10m24*sqrt((nws10m14-2)/(1-rws10m24^2))
dfws10m24=nws10m14-2
pws10m24=student_t(tws10m24,dfws10m24) ;test significance level at the 95% level
if (pws10m24.le.0.05) then
    psig_ws10m24="yes"
 else
   psig_ws10m24="no"
end if



mbws10m34=sumdiff_ws10m34/nws10m14
mews10m34=sumabsdiff_ws10m34/nws10m14
nmbws10m34=100*sumdiff_ws10m34/sum(obsws10m4(744:1487))
nmews10m34=100*sumabsdiff_ws10m34/sum(obsws10m4(744:1487))
rws10m34=escorc(ws10m34(0:743),obsws10m4(744:1487))
tws10m34=rws10m34*sqrt((nws10m14-2)/(1-rws10m34^2))
dfws10m34=nws10m14-2
pws10m34=student_t(tws10m34,dfws10m34) ;test significance level at the 95% level
if (pws10m34.le.0.05) then
    psig_ws10m34="yes"
 else
   psig_ws10m34="no"
end if

mbws10m44=sumdiff_ws10m44/nws10m14
mews10m44=sumabsdiff_ws10m44/nws10m14
nmbws10m44=100*sumdiff_ws10m44/sum(obsws10m4(744:1487))
nmews10m44=100*sumabsdiff_ws10m44/sum(obsws10m4(744:1487))
rws10m44=escorc(ws10m44(0:743),obsws10m4(744:1487))
tws10m44=rws10m44*sqrt((nws10m14-2)/(1-rws10m44^2))
dfws10m44=nws10m14-2
pws10m44=student_t(tws10m44,dfws10m44) ;test significance level at the 95% level
if (pws10m44.le.0.05) then
    psig_ws10m44="yes"
 else
   psig_ws10m44="no"
end if

mbws10m15=sumdiff_ws10m15/nws10m15
mews10m15=sumabsdiff_ws10m15/nws10m15
nmbws10m15=100*sumdiff_ws10m15/sum(obsws10m5(744:1487))
nmews10m15=100*sumabsdiff_ws10m15/sum(obsws10m5(744:1487))
rws10m15=escorc(ws10m15(0:743),obsws10m5(744:1487))
tws10m15=rws10m15*sqrt((nws10m15-2)/(1-rws10m15^2))
dfws10m15=nws10m15-2
pws10m15=student_t(tws10m15,dfws10m15) ;test significance level at the 95% level
if (pws10m15.le.0.05) then
    psig_ws10m15="yes"
 else
   psig_ws10m15="no"
end if
;print(mbws10m15)
;print(mews10m15)
;print(nmbws10m15)
;print(nmews10m15)
;print(rws10m15)
;print(pws10m15)
;print(psig_ws10m15)

mbws10m25=sumdiff_ws10m25/nws10m15
mews10m25=sumabsdiff_ws10m25/nws10m15
nmbws10m25=100*sumdiff_ws10m25/sum(obsws10m5(744:1487))
nmews10m25=100*sumabsdiff_ws10m25/sum(obsws10m5(744:1487))
rws10m25=escorc(ws10m25(0:743),obsws10m5(744:1487))
tws10m25=rws10m25*sqrt((nws10m15-2)/(1-rws10m25^2))
dfws10m25=nws10m15-2
pws10m25=student_t(tws10m25,dfws10m25) ;test significance level at the 95% level
if (pws10m25.le.0.05) then
    psig_ws10m25="yes"
 else
   psig_ws10m25="no"
end if



mbws10m35=sumdiff_ws10m35/nws10m15
mews10m35=sumabsdiff_ws10m35/nws10m15
nmbws10m35=100*sumdiff_ws10m35/sum(obsws10m5(744:1487))
nmews10m35=100*sumabsdiff_ws10m35/sum(obsws10m5(744:1487))
rws10m35=escorc(ws10m35(0:743),obsws10m5(744:1487))
tws10m35=rws10m35*sqrt((nws10m15-2)/(1-rws10m35^2))
dfws10m35=nws10m15-2
pws10m35=student_t(tws10m35,dfws10m35) ;test significance level at the 95% level
if (pws10m35.le.0.05) then
    psig_ws10m35="yes"
 else
   psig_ws10m35="no"
end if

mbws10m45=sumdiff_ws10m45/nws10m15
mews10m45=sumabsdiff_ws10m45/nws10m15
nmbws10m45=100*sumdiff_ws10m45/sum(obsws10m5(744:1487))
nmews10m45=100*sumabsdiff_ws10m45/sum(obsws10m5(744:1487))
rws10m45=escorc(ws10m45(0:743),obsws10m5(744:1487))
tws10m45=rws10m45*sqrt((nws10m15-2)/(1-rws10m45^2))
dfws10m45=nws10m15-2
pws10m45=student_t(tws10m45,dfws10m45) ;test significance level at the 95% level
if (pws10m45.le.0.05) then
    psig_ws10m45="yes"
 else
   psig_ws10m45="no"
end if

mbws10m16=sumdiff_ws10m16/nws10m16
mews10m16=sumabsdiff_ws10m16/nws10m16
nmbws10m16=100*sumdiff_ws10m16/sum(obsws10m6(744:1487))
nmews10m16=100*sumabsdiff_ws10m16/sum(obsws10m6(744:1487))
rws10m16=escorc(ws10m16(0:743),obsws10m6(744:1487))
tws10m16=rws10m16*sqrt((nws10m16-2)/(1-rws10m16^2))
dfws10m16=nws10m16-2
pws10m16=student_t(tws10m16,dfws10m16) ;test significance level at the 95% level
if (pws10m16.le.0.05) then
    psig_ws10m16="yes"
 else
   psig_ws10m16="no"
end if
;print(mbws10m16)
;print(mews10m16)
;print(nmbws10m16)
;print(nmews10m16)
;print(rws10m16)
;print(pws10m16)
;print(psig_ws10m16)

mbws10m26=sumdiff_ws10m26/nws10m16
mews10m26=sumabsdiff_ws10m26/nws10m16
nmbws10m26=100*sumdiff_ws10m26/sum(obsws10m6(744:1487))
nmews10m26=100*sumabsdiff_ws10m26/sum(obsws10m6(744:1487))
rws10m26=escorc(ws10m26(0:743),obsws10m6(744:1487))
tws10m26=rws10m26*sqrt((nws10m16-2)/(1-rws10m26^2))
dfws10m26=nws10m16-2
pws10m26=student_t(tws10m26,dfws10m26) ;test significance level at the 95% level
if (pws10m26.le.0.05) then
    psig_ws10m26="yes"
 else
   psig_ws10m26="no"
end if



mbws10m36=sumdiff_ws10m36/nws10m16
mews10m36=sumabsdiff_ws10m36/nws10m16
nmbws10m36=100*sumdiff_ws10m36/sum(obsws10m6(744:1487))
nmews10m36=100*sumabsdiff_ws10m36/sum(obsws10m6(744:1487))
rws10m36=escorc(ws10m36(0:743),obsws10m6(744:1487))
tws10m36=rws10m36*sqrt((nws10m16-2)/(1-rws10m36^2))
dfws10m36=nws10m16-2
pws10m36=student_t(tws10m36,dfws10m36) ;test significance level at the 95% level
if (pws10m36.le.0.05) then
    psig_ws10m36="yes"
 else
   psig_ws10m36="no"
end if

mbws10m46=sumdiff_ws10m46/nws10m16
mews10m46=sumabsdiff_ws10m46/nws10m16
nmbws10m46=100*sumdiff_ws10m46/sum(obsws10m6(744:1487))
nmews10m46=100*sumabsdiff_ws10m46/sum(obsws10m6(744:1487))
rws10m46=escorc(ws10m46(0:743),obsws10m6(744:1487))
tws10m46=rws10m46*sqrt((nws10m16-2)/(1-rws10m46^2))
dfws10m46=nws10m16-2
pws10m46=student_t(tws10m46,dfws10m46) ;test significance level at the 95% level
if (pws10m46.le.0.05) then
    psig_ws10m46="yes"
 else
   psig_ws10m46="no"
end if

mbws10m17=sumdiff_ws10m17/nws10m17
mews10m17=sumabsdiff_ws10m17/nws10m17
nmbws10m17=100*sumdiff_ws10m17/sum(obsws10m7(744:1487))
nmews10m17=100*sumabsdiff_ws10m17/sum(obsws10m7(744:1487))
rws10m17=escorc(ws10m17(0:743),obsws10m7(744:1487))
tws10m17=rws10m17*sqrt((nws10m17-2)/(1-rws10m17^2))
dfws10m17=nws10m17-2
pws10m17=student_t(tws10m17,dfws10m17) ;test significance level at the 95% level
if (pws10m17.le.0.05) then
    psig_ws10m17="yes"
 else
   psig_ws10m17="no"
end if
;print(mbws10m17)
;print(mews10m17)
;print(nmbws10m17)
;print(nmews10m17)
;print(rws10m17)
;print(pws10m17)
;print(psig_ws10m17)

mbws10m27=sumdiff_ws10m27/nws10m17
mews10m27=sumabsdiff_ws10m27/nws10m17
nmbws10m27=100*sumdiff_ws10m27/sum(obsws10m7(744:1487))
nmews10m27=100*sumabsdiff_ws10m27/sum(obsws10m7(744:1487))
rws10m27=escorc(ws10m27(0:743),obsws10m7(744:1487))
tws10m27=rws10m27*sqrt((nws10m17-2)/(1-rws10m27^2))
dfws10m27=nws10m17-2
pws10m27=student_t(tws10m27,dfws10m27) ;test significance level at the 95% level
if (pws10m27.le.0.05) then
    psig_ws10m27="yes"
 else
   psig_ws10m27="no"
end if



mbws10m37=sumdiff_ws10m37/nws10m17
mews10m37=sumabsdiff_ws10m37/nws10m17
nmbws10m37=100*sumdiff_ws10m37/sum(obsws10m7(744:1487))
nmews10m37=100*sumabsdiff_ws10m37/sum(obsws10m7(744:1487))
rws10m37=escorc(ws10m37(0:743),obsws10m7(744:1487))
tws10m37=rws10m37*sqrt((nws10m17-2)/(1-rws10m37^2))
dfws10m37=nws10m17-2
pws10m37=student_t(tws10m37,dfws10m37) ;test significance level at the 95% level
if (pws10m37.le.0.05) then
    psig_ws10m37="yes"
 else
   psig_ws10m37="no"
end if

mbws10m47=sumdiff_ws10m47/nws10m17
mews10m47=sumabsdiff_ws10m47/nws10m17
nmbws10m47=100*sumdiff_ws10m47/sum(obsws10m7(744:1487))
nmews10m47=100*sumabsdiff_ws10m47/sum(obsws10m7(744:1487))
rws10m47=escorc(ws10m47(0:743),obsws10m7(744:1487))
tws10m47=rws10m47*sqrt((nws10m17-2)/(1-rws10m47^2))
dfws10m47=nws10m17-2
pws10m47=student_t(tws10m47,dfws10m47) ;test significance level at the 95% level
if (pws10m47.le.0.05) then
    psig_ws10m47="yes"
 else
   psig_ws10m47="no"
end if
;************FINISH DOING STATISTICS**************************



stdrealrh11=stddev(realrh11)
stdrealrh12=stddev(realrh12)
stdrealrh13=stddev(realrh13)
stdrealrh14=stddev(realrh14)
stdrealrh15=stddev(realrh15)
stdrealrh16=stddev(realrh16)
stdrealrh17=stddev(realrh17)

;MB,ME,NMB,NME,PCC
nrealrh11=0.0
sumdiff_realrh11=0.0
sumabsdiff_realrh11=0.0
nrealrh12=0.0
sumdiff_realrh12=0.0
sumabsdiff_realrh12=0.0
nrealrh13=0.0
sumdiff_realrh13=0.0
sumabsdiff_realrh13=0.0
nrealrh14=0.0
sumdiff_realrh14=0.0
sumabsdiff_realrh14=0.0
nrealrh15=0.0
sumdiff_realrh15=0.0
sumabsdiff_realrh15=0.0
nrealrh16=0.0
sumdiff_realrh16=0.0
sumabsdiff_realrh16=0.0
nrealrh17=0.0
sumdiff_realrh17=0.0
sumabsdiff_realrh17=0.0

nrealrh21=0.0
sumdiff_realrh21=0.0
sumabsdiff_realrh21=0.0
nrealrh22=0.0
sumdiff_realrh22=0.0
sumabsdiff_realrh22=0.0
nrealrh23=0.0
sumdiff_realrh23=0.0
sumabsdiff_realrh23=0.0
nrealrh24=0.0
sumdiff_realrh24=0.0
sumabsdiff_realrh24=0.0
nrealrh25=0.0
sumdiff_realrh25=0.0
sumabsdiff_realrh25=0.0
nrealrh26=0.0
sumdiff_realrh26=0.0
sumabsdiff_realrh26=0.0
nrealrh27=0.0
sumdiff_realrh27=0.0
sumabsdiff_realrh27=0.0

nrealrh31=0.0
sumdiff_realrh31=0.0
sumabsdiff_realrh31=0.0
nrealrh32=0.0
sumdiff_realrh32=0.0
sumabsdiff_realrh32=0.0
nrealrh33=0.0
sumdiff_realrh33=0.0
sumabsdiff_realrh33=0.0
nrealrh34=0.0
sumdiff_realrh34=0.0
sumabsdiff_realrh34=0.0
nrealrh35=0.0
sumdiff_realrh35=0.0
sumabsdiff_realrh35=0.0
nrealrh36=0.0
sumdiff_realrh36=0.0
sumabsdiff_realrh36=0.0
nrealrh37=0.0
sumdiff_realrh37=0.0
sumabsdiff_realrh37=0.0

nrealrh41=0.0
sumdiff_realrh41=0.0
sumabsdiff_realrh41=0.0
nrealrh42=0.0
sumdiff_realrh42=0.0
sumabsdiff_realrh42=0.0
nrealrh43=0.0
sumdiff_realrh43=0.0
sumabsdiff_realrh43=0.0
nrealrh44=0.0
sumdiff_realrh44=0.0
sumabsdiff_realrh44=0.0
nrealrh45=0.0
sumdiff_realrh45=0.0
sumabsdiff_realrh45=0.0
nrealrh46=0.0
sumdiff_realrh46=0.0
sumabsdiff_realrh46=0.0
nrealrh47=0.0
sumdiff_realrh47=0.0
sumabsdiff_realrh47=0.0
do j=0,446,1
i =count(j)
    ;print(i)
    if(.not.ismissing(obsrh1(i+744)))
     diff_realrh11=realrh11(i)-obsrh1(i+744)
          absdiff_realrh11=abs(realrh11(i)-obsrh1(i+744))
         nrealrh11=nrealrh11+1
        sumdiff_realrh11=sumdiff_realrh11+diff_realrh11
        sumabsdiff_realrh11=sumabsdiff_realrh11+absdiff_realrh11

        diff_realrh21=realrh21(i)-obsrh1(i+744)
        absdiff_realrh21=abs(realrh21(i)-obsrh1(i+744))
        sumdiff_realrh21=sumdiff_realrh21+diff_realrh21
        sumabsdiff_realrh21=sumabsdiff_realrh21+absdiff_realrh21

        diff_realrh31=realrh31(i)-obsrh1(i+744)
        absdiff_realrh31=abs(realrh31(i)-obsrh1(i+744))
        sumdiff_realrh31=sumdiff_realrh31+diff_realrh31
        sumabsdiff_realrh31=sumabsdiff_realrh31+absdiff_realrh31


        diff_realrh41=realrh41(i)-obsrh1(i+744)
        absdiff_realrh41=abs(realrh41(i)-obsrh1(i+744))
        sumdiff_realrh41=sumdiff_realrh41+diff_realrh41
        sumabsdiff_realrh41=sumabsdiff_realrh41+absdiff_realrh41

       end if

        if(.not.ismissing(obsrh2(i+744)))
     diff_realrh12=realrh12(i)-obsrh2(i+744)
          absdiff_realrh12=abs(realrh12(i)-obsrh2(i+744))
         nrealrh12=nrealrh12+1
        sumdiff_realrh12=sumdiff_realrh12+diff_realrh12
        sumabsdiff_realrh12=sumabsdiff_realrh12+absdiff_realrh12

        diff_realrh22=realrh21(i)-obsrh2(i+744)
        absdiff_realrh22=abs(realrh22(i)-obsrh2(i+744))
        sumdiff_realrh22=sumdiff_realrh22+diff_realrh22
        sumabsdiff_realrh22=sumabsdiff_realrh22+absdiff_realrh22

        diff_realrh32=realrh32(i)-obsrh2(i+744)
        absdiff_realrh32=abs(realrh32(i)-obsrh2(i+744))
        sumdiff_realrh32=sumdiff_realrh32+diff_realrh32
        sumabsdiff_realrh32=sumabsdiff_realrh32+absdiff_realrh32


        diff_realrh42=realrh42(i)-obsrh2(i+744)
        absdiff_realrh42=abs(realrh42(i)-obsrh2(i+744))
        sumdiff_realrh42=sumdiff_realrh42+diff_realrh42
        sumabsdiff_realrh42=sumabsdiff_realrh42+absdiff_realrh42

       end if

        if(.not.ismissing(obsrh3(i+744)))
     diff_realrh13=realrh13(i)-obsrh3(i+744)
          absdiff_realrh13=abs(realrh13(i)-obsrh3(i+744))
         nrealrh13=nrealrh13+1
        sumdiff_realrh13=sumdiff_realrh13+diff_realrh13
        sumabsdiff_realrh13=sumabsdiff_realrh13+absdiff_realrh13

        diff_realrh23=realrh23(i)-obsrh3(i+744)
        absdiff_realrh23=abs(realrh23(i)-obsrh3(i+744))
        sumdiff_realrh23=sumdiff_realrh23+diff_realrh23
        sumabsdiff_realrh23=sumabsdiff_realrh23+absdiff_realrh23

        diff_realrh33=realrh33(i)-obsrh3(i+744)
        absdiff_realrh33=abs(realrh33(i)-obsrh3(i+744))
        sumdiff_realrh33=sumdiff_realrh33+diff_realrh33
        sumabsdiff_realrh33=sumabsdiff_realrh33+absdiff_realrh33


        diff_realrh43=realrh43(i)-obsrh3(i+744)
        absdiff_realrh43=abs(realrh43(i)-obsrh3(i+744))
        sumdiff_realrh43=sumdiff_realrh43+diff_realrh43
        sumabsdiff_realrh43=sumabsdiff_realrh43+absdiff_realrh43

       end if
      if(.not.ismissing(obsrh4(i+744)))
     diff_realrh14=realrh14(i)-obsrh4(i+744)
          absdiff_realrh14=abs(realrh14(i)-obsrh4(i+744))
         nrealrh14=nrealrh14+1
        sumdiff_realrh14=sumdiff_realrh14+diff_realrh14
        sumabsdiff_realrh14=sumabsdiff_realrh14+absdiff_realrh14

        diff_realrh24=realrh24(i)-obsrh4(i+744)
        absdiff_realrh24=abs(realrh24(i)-obsrh4(i+744))
        sumdiff_realrh24=sumdiff_realrh24+diff_realrh24
        sumabsdiff_realrh24=sumabsdiff_realrh24+absdiff_realrh24

        diff_realrh34=realrh34(i)-obsrh4(i+744)
        absdiff_realrh34=abs(realrh34(i)-obsrh4(i+744))
        sumdiff_realrh34=sumdiff_realrh34+diff_realrh34
        sumabsdiff_realrh34=sumabsdiff_realrh34+absdiff_realrh34


        diff_realrh44=realrh44(i)-obsrh4(i+744)
        absdiff_realrh44=abs(realrh44(i)-obsrh4(i+744))
        sumdiff_realrh44=sumdiff_realrh44+diff_realrh44
        sumabsdiff_realrh44=sumabsdiff_realrh44+absdiff_realrh44

       end if

         if(.not.ismissing(obsrh5(i+744)))
     diff_realrh15=realrh15(i)-obsrh5(i+744)
          absdiff_realrh15=abs(realrh15(i)-obsrh5(i+744))
         nrealrh15=nrealrh15+1
        sumdiff_realrh15=sumdiff_realrh15+diff_realrh15
        sumabsdiff_realrh15=sumabsdiff_realrh15+absdiff_realrh15

        diff_realrh25=realrh25(i)-obsrh5(i+744)
        absdiff_realrh25=abs(realrh25(i)-obsrh5(i+744))
        sumdiff_realrh25=sumdiff_realrh25+diff_realrh25
        sumabsdiff_realrh25=sumabsdiff_realrh25+absdiff_realrh25

        diff_realrh35=realrh35(i)-obsrh5(i+744)
        absdiff_realrh35=abs(realrh35(i)-obsrh5(i+744))
        sumdiff_realrh35=sumdiff_realrh35+diff_realrh35
        sumabsdiff_realrh35=sumabsdiff_realrh35+absdiff_realrh35


        diff_realrh45=realrh45(i)-obsrh5(i+744)
        absdiff_realrh45=abs(realrh45(i)-obsrh5(i+744))
        sumdiff_realrh45=sumdiff_realrh45+diff_realrh45
        sumabsdiff_realrh45=sumabsdiff_realrh45+absdiff_realrh45

       end if

       if(.not.ismissing(obsrh6(i+744)))
     diff_realrh16=realrh16(i)-obsrh6(i+744)
          absdiff_realrh16=abs(realrh16(i)-obsrh6(i+744))
         nrealrh16=nrealrh16+1
        sumdiff_realrh16=sumdiff_realrh16+diff_realrh16
        sumabsdiff_realrh16=sumabsdiff_realrh16+absdiff_realrh16

        diff_realrh26=realrh26(i)-obsrh6(i+744)
        absdiff_realrh26=abs(realrh26(i)-obsrh6(i+744))
        sumdiff_realrh26=sumdiff_realrh26+diff_realrh26
        sumabsdiff_realrh26=sumabsdiff_realrh26+absdiff_realrh26

        diff_realrh36=realrh36(i)-obsrh6(i+744)
        absdiff_realrh36=abs(realrh36(i)-obsrh6(i+744))
        sumdiff_realrh36=sumdiff_realrh36+diff_realrh36
        sumabsdiff_realrh36=sumabsdiff_realrh36+absdiff_realrh36


        diff_realrh46=realrh46(i)-obsrh6(i+744)
        absdiff_realrh46=abs(realrh46(i)-obsrh6(i+744))
        sumdiff_realrh46=sumdiff_realrh46+diff_realrh46
        sumabsdiff_realrh46=sumabsdiff_realrh46+absdiff_realrh46

       end if

       if(.not.ismissing(obsrh7(i+744)))
     diff_realrh17=realrh17(i)-obsrh7(i+744)
          absdiff_realrh17=abs(realrh17(i)-obsrh7(i+744))
         nrealrh17=nrealrh17+1
        sumdiff_realrh17=sumdiff_realrh17+diff_realrh17
        sumabsdiff_realrh17=sumabsdiff_realrh17+absdiff_realrh17

        diff_realrh27=realrh27(i)-obsrh7(i+744)
        absdiff_realrh27=abs(realrh27(i)-obsrh7(i+744))
        sumdiff_realrh27=sumdiff_realrh27+diff_realrh27
        sumabsdiff_realrh27=sumabsdiff_realrh27+absdiff_realrh27

        diff_realrh37=realrh37(i)-obsrh7(i+744)
        absdiff_realrh37=abs(realrh37(i)-obsrh7(i+744))
        sumdiff_realrh37=sumdiff_realrh37+diff_realrh37
        sumabsdiff_realrh37=sumabsdiff_realrh37+absdiff_realrh37


        diff_realrh47=realrh47(i)-obsrh7(i+744)
        absdiff_realrh47=abs(realrh47(i)-obsrh7(i+744))
        sumdiff_realrh47=sumdiff_realrh47+diff_realrh47
        sumabsdiff_realrh47=sumabsdiff_realrh47+absdiff_realrh47

       end if
  end do 

;print(nrealrh11)
mbrealrh11=sumdiff_realrh11/nrealrh11
merealrh11=sumabsdiff_realrh11/nrealrh11
nmbrealrh11=100*sumdiff_realrh11/sum(obsrh1(744:1487))
nmerealrh11=100*sumabsdiff_realrh11/sum(obsrh1(744:1487))
rrealrh11=escorc(realrh11(0:743),obsrh1(744:1487))
trealrh11=rrealrh11*sqrt((nrealrh11-2)/(1-rrealrh11^2))
dfrealrh11=nrealrh11-2
prealrh11=student_t(trealrh11,dfrealrh11) ;test significance level at the 95% level
if (prealrh11.le.0.05) then
    psig_realrh11="yes"
 else
   psig_realrh11="no"
end if
;print(mbrealrh11)
;print(merealrh11)
;print(nmbrealrh11)
;print(nmerealrh11)
;print(rrealrh11)
;print(prealrh11)
;print(psig_realrh11)

mbrealrh21=sumdiff_realrh21/nrealrh11
merealrh21=sumabsdiff_realrh21/nrealrh11
nmbrealrh21=100*sumdiff_realrh21/sum(obsrh1(744:1487))
nmerealrh21=100*sumabsdiff_realrh21/sum(obsrh1(744:1487))
rrealrh21=escorc(realrh21(0:743),obsrh1(744:1487))
trealrh21=rrealrh21*sqrt((nrealrh11-2)/(1-rrealrh21^2))
dfrealrh21=nrealrh11-2
prealrh21=student_t(trealrh21,dfrealrh21) ;test significance level at the 95% level
if (prealrh21.le.0.05) then
    psig_realrh21="yes"
 else
   psig_realrh21="no"
end if



mbrealrh31=sumdiff_realrh31/nrealrh11
merealrh31=sumabsdiff_realrh31/nrealrh11
nmbrealrh31=100*sumdiff_realrh31/sum(obsrh1(744:1487))
nmerealrh31=100*sumabsdiff_realrh31/sum(obsrh1(744:1487))
rrealrh31=escorc(realrh31(0:743),obsrh1(744:1487))
trealrh31=rrealrh31*sqrt((nrealrh11-2)/(1-rrealrh31^2))
dfrealrh31=nrealrh11-2
prealrh31=student_t(trealrh31,dfrealrh31) ;test significance level at the 95% level
if (prealrh31.le.0.05) then
    psig_realrh31="yes"
 else
   psig_realrh31="no"
end if

mbrealrh41=sumdiff_realrh41/nrealrh11
merealrh41=sumabsdiff_realrh41/nrealrh11
nmbrealrh41=100*sumdiff_realrh41/sum(obsrh1(744:1487))
nmerealrh41=100*sumabsdiff_realrh41/sum(obsrh1(744:1487))
rrealrh41=escorc(realrh41(0:743),obsrh1(744:1487))
trealrh41=rrealrh41*sqrt((nrealrh11-2)/(1-rrealrh41^2))
dfrealrh41=nrealrh11-2
prealrh41=student_t(trealrh41,dfrealrh41) ;test significance level at the 95% level
if (prealrh41.le.0.05) then
    psig_realrh41="yes"
 else
   psig_realrh41="no"
end if


mbrealrh12=sumdiff_realrh12/nrealrh12
merealrh12=sumabsdiff_realrh12/nrealrh12
nmbrealrh12=100*sumdiff_realrh12/sum(obsrh2(744:1487))
nmerealrh12=100*sumabsdiff_realrh12/sum(obsrh2(744:1487))
rrealrh12=escorc(realrh12(0:743),obsrh2(744:1487))
trealrh12=rrealrh12*sqrt((nrealrh12-2)/(1-rrealrh12^2))
dfrealrh12=nrealrh12-2
prealrh12=student_t(trealrh12,dfrealrh12) ;test significance level at the 95% level
if (prealrh12.le.0.05) then
    psig_realrh12="yes"
 else
   psig_realrh12="no"
end if
;print(mbrealrh12)
;print(merealrh12)
;print(nmbrealrh12)
;print(nmerealrh12)
;print(rrealrh12)
;print(prealrh12)
;print(psig_realrh12)

mbrealrh22=sumdiff_realrh22/nrealrh12
merealrh22=sumabsdiff_realrh22/nrealrh12
nmbrealrh22=100*sumdiff_realrh22/sum(obsrh2(744:1487))
nmerealrh22=100*sumabsdiff_realrh22/sum(obsrh2(744:1487))
rrealrh22=escorc(realrh22(0:743),obsrh2(744:1487))
trealrh22=rrealrh22*sqrt((nrealrh12-2)/(1-rrealrh22^2))
dfrealrh22=nrealrh12-2
prealrh22=student_t(trealrh22,dfrealrh22) ;test significance level at the 95% level
if (prealrh22.le.0.05) then
    psig_realrh22="yes"
 else
   psig_realrh22="no"
end if



mbrealrh32=sumdiff_realrh32/nrealrh12
merealrh32=sumabsdiff_realrh32/nrealrh12
nmbrealrh32=100*sumdiff_realrh32/sum(obsrh2(744:1487))
nmerealrh32=100*sumabsdiff_realrh32/sum(obsrh2(744:1487))
rrealrh32=escorc(realrh32(0:743),obsrh2(744:1487))
trealrh32=rrealrh32*sqrt((nrealrh12-2)/(1-rrealrh32^2))
dfrealrh32=nrealrh12-2
prealrh32=student_t(trealrh32,dfrealrh32) ;test significance level at the 95% level
if (prealrh32.le.0.05) then
    psig_realrh32="yes"
 else
   psig_realrh32="no"
end if

mbrealrh42=sumdiff_realrh42/nrealrh12
merealrh42=sumabsdiff_realrh42/nrealrh12
nmbrealrh42=100*sumdiff_realrh42/sum(obsrh2(744:1487))
nmerealrh42=100*sumabsdiff_realrh42/sum(obsrh2(744:1487))
rrealrh42=escorc(realrh42(0:743),obsrh2(744:1487))
trealrh42=rrealrh42*sqrt((nrealrh12-2)/(1-rrealrh42^2))
dfrealrh42=nrealrh12-2
prealrh42=student_t(trealrh42,dfrealrh42) ;test significance level at the 95% level
if (prealrh42.le.0.05) then
    psig_realrh42="yes"
 else
   psig_realrh42="no"
end if

mbrealrh13=sumdiff_realrh13/nrealrh13
merealrh13=sumabsdiff_realrh13/nrealrh13
nmbrealrh13=100*sumdiff_realrh13/sum(obsrh3(744:1487))
nmerealrh13=100*sumabsdiff_realrh13/sum(obsrh3(744:1487))
rrealrh13=escorc(realrh13(0:743),obsrh3(744:1487))
trealrh13=rrealrh13*sqrt((nrealrh13-2)/(1-rrealrh13^2))
dfrealrh13=nrealrh13-2
prealrh13=student_t(trealrh13,dfrealrh13) ;test significance level at the 95% level
if (prealrh13.le.0.05) then
    psig_realrh13="yes"
 else
   psig_realrh13="no"
end if
;print(mbrealrh13)
;print(merealrh13)
;print(nmbrealrh13)
;print(nmerealrh13)
;print(rrealrh13)
;print(prealrh13)
;print(psig_realrh13)

mbrealrh23=sumdiff_realrh23/nrealrh13
merealrh23=sumabsdiff_realrh23/nrealrh13
nmbrealrh23=100*sumdiff_realrh23/sum(obsrh3(744:1487))
nmerealrh23=100*sumabsdiff_realrh23/sum(obsrh3(744:1487))
rrealrh23=escorc(realrh23(0:743),obsrh3(744:1487))
trealrh23=rrealrh23*sqrt((nrealrh13-2)/(1-rrealrh23^2))
dfrealrh23=nrealrh13-2
prealrh23=student_t(trealrh23,dfrealrh23) ;test significance level at the 95% level
if (prealrh23.le.0.05) then
    psig_realrh23="yes"
 else
   psig_realrh23="no"
end if



mbrealrh33=sumdiff_realrh33/nrealrh13
merealrh33=sumabsdiff_realrh33/nrealrh13
nmbrealrh33=100*sumdiff_realrh33/sum(obsrh3(744:1487))
nmerealrh33=100*sumabsdiff_realrh33/sum(obsrh3(744:1487))
rrealrh33=escorc(realrh33(0:743),obsrh3(744:1487))
trealrh33=rrealrh33*sqrt((nrealrh13-2)/(1-rrealrh33^2))
dfrealrh33=nrealrh13-2
prealrh33=student_t(trealrh33,dfrealrh33) ;test significance level at the 95% level
if (prealrh33.le.0.05) then
    psig_realrh33="yes"
 else
   psig_realrh33="no"
end if

mbrealrh43=sumdiff_realrh43/nrealrh13
merealrh43=sumabsdiff_realrh43/nrealrh13
nmbrealrh43=100*sumdiff_realrh43/sum(obsrh3(744:1487))
nmerealrh43=100*sumabsdiff_realrh43/sum(obsrh3(744:1487))
rrealrh43=escorc(realrh43(0:743),obsrh3(744:1487))
trealrh43=rrealrh43*sqrt((nrealrh13-2)/(1-rrealrh43^2))
dfrealrh43=nrealrh13-2
prealrh43=student_t(trealrh43,dfrealrh43) ;test significance level at the 95% level
if (prealrh43.le.0.05) then
    psig_realrh43="yes"
 else
   psig_realrh43="no"
end if

mbrealrh14=sumdiff_realrh14/nrealrh14
merealrh14=sumabsdiff_realrh14/nrealrh14
nmbrealrh14=100*sumdiff_realrh14/sum(obsrh4(744:1487))
nmerealrh14=100*sumabsdiff_realrh14/sum(obsrh4(744:1487))
rrealrh14=escorc(realrh14(0:743),obsrh4(744:1487))
trealrh14=rrealrh14*sqrt((nrealrh14-2)/(1-rrealrh14^2))
dfrealrh14=nrealrh14-2
prealrh14=student_t(trealrh14,dfrealrh14) ;test significance level at the 95% level
if (prealrh14.le.0.05) then
    psig_realrh14="yes"
 else
   psig_realrh14="no"
end if
;print(mbrealrh14)
;print(merealrh14)
;print(nmbrealrh14)
;print(nmerealrh14)
;print(rrealrh14)
;print(prealrh14)
;print(psig_realrh14)

mbrealrh24=sumdiff_realrh24/nrealrh14
merealrh24=sumabsdiff_realrh24/nrealrh14
nmbrealrh24=100*sumdiff_realrh24/sum(obsrh4(744:1487))
nmerealrh24=100*sumabsdiff_realrh24/sum(obsrh4(744:1487))
rrealrh24=escorc(realrh24(0:743),obsrh4(744:1487))
trealrh24=rrealrh24*sqrt((nrealrh14-2)/(1-rrealrh24^2))
dfrealrh24=nrealrh14-2
prealrh24=student_t(trealrh24,dfrealrh24) ;test significance level at the 95% level
if (prealrh24.le.0.05) then
    psig_realrh24="yes"
 else
   psig_realrh24="no"
end if



mbrealrh34=sumdiff_realrh34/nrealrh14
merealrh34=sumabsdiff_realrh34/nrealrh14
nmbrealrh34=100*sumdiff_realrh34/sum(obsrh4(744:1487))
nmerealrh34=100*sumabsdiff_realrh34/sum(obsrh4(744:1487))
rrealrh34=escorc(realrh34(0:743),obsrh4(744:1487))
trealrh34=rrealrh34*sqrt((nrealrh14-2)/(1-rrealrh34^2))
dfrealrh34=nrealrh14-2
prealrh34=student_t(trealrh34,dfrealrh34) ;test significance level at the 95% level
if (prealrh34.le.0.05) then
    psig_realrh34="yes"
 else
   psig_realrh34="no"
end if

mbrealrh44=sumdiff_realrh44/nrealrh14
merealrh44=sumabsdiff_realrh44/nrealrh14
nmbrealrh44=100*sumdiff_realrh44/sum(obsrh4(744:1487))
nmerealrh44=100*sumabsdiff_realrh44/sum(obsrh4(744:1487))
rrealrh44=escorc(realrh44(0:743),obsrh4(744:1487))
trealrh44=rrealrh44*sqrt((nrealrh14-2)/(1-rrealrh44^2))
dfrealrh44=nrealrh14-2
prealrh44=student_t(trealrh44,dfrealrh44) ;test significance level at the 95% level
if (prealrh44.le.0.05) then
    psig_realrh44="yes"
 else
   psig_realrh44="no"
end if

mbrealrh15=sumdiff_realrh15/nrealrh15
merealrh15=sumabsdiff_realrh15/nrealrh15
nmbrealrh15=100*sumdiff_realrh15/sum(obsrh5(744:1487))
nmerealrh15=100*sumabsdiff_realrh15/sum(obsrh5(744:1487))
rrealrh15=escorc(realrh15(0:743),obsrh5(744:1487))
trealrh15=rrealrh15*sqrt((nrealrh15-2)/(1-rrealrh15^2))
dfrealrh15=nrealrh15-2
prealrh15=student_t(trealrh15,dfrealrh15) ;test significance level at the 95% level
if (prealrh15.le.0.05) then
    psig_realrh15="yes"
 else
   psig_realrh15="no"
end if
;print(mbrealrh15)
;print(merealrh15)
;print(nmbrealrh15)
;print(nmerealrh15)
;print(rrealrh15)
;print(prealrh15)
;print(psig_realrh15)

mbrealrh25=sumdiff_realrh25/nrealrh15
merealrh25=sumabsdiff_realrh25/nrealrh15
nmbrealrh25=100*sumdiff_realrh25/sum(obsrh5(744:1487))
nmerealrh25=100*sumabsdiff_realrh25/sum(obsrh5(744:1487))
rrealrh25=escorc(realrh25(0:743),obsrh5(744:1487))
trealrh25=rrealrh25*sqrt((nrealrh15-2)/(1-rrealrh25^2))
dfrealrh25=nrealrh15-2
prealrh25=student_t(trealrh25,dfrealrh25) ;test significance level at the 95% level
if (prealrh25.le.0.05) then
    psig_realrh25="yes"
 else
   psig_realrh25="no"
end if



mbrealrh35=sumdiff_realrh35/nrealrh15
merealrh35=sumabsdiff_realrh35/nrealrh15
nmbrealrh35=100*sumdiff_realrh35/sum(obsrh5(744:1487))
nmerealrh35=100*sumabsdiff_realrh35/sum(obsrh5(744:1487))
rrealrh35=escorc(realrh35(0:743),obsrh5(744:1487))
trealrh35=rrealrh35*sqrt((nrealrh15-2)/(1-rrealrh35^2))
dfrealrh35=nrealrh15-2
prealrh35=student_t(trealrh35,dfrealrh35) ;test significance level at the 95% level
if (prealrh35.le.0.05) then
    psig_realrh35="yes"
 else
   psig_realrh35="no"
end if

mbrealrh45=sumdiff_realrh45/nrealrh15
merealrh45=sumabsdiff_realrh45/nrealrh15
nmbrealrh45=100*sumdiff_realrh45/sum(obsrh5(744:1487))
nmerealrh45=100*sumabsdiff_realrh45/sum(obsrh5(744:1487))
rrealrh45=escorc(realrh45(0:743),obsrh5(744:1487))
trealrh45=rrealrh45*sqrt((nrealrh15-2)/(1-rrealrh45^2))
dfrealrh45=nrealrh15-2
prealrh45=student_t(trealrh45,dfrealrh45) ;test significance level at the 95% level
if (prealrh45.le.0.05) then
    psig_realrh45="yes"
 else
   psig_realrh45="no"
end if

mbrealrh16=sumdiff_realrh16/nrealrh16
merealrh16=sumabsdiff_realrh16/nrealrh16
nmbrealrh16=100*sumdiff_realrh16/sum(obsrh6(744:1487))
nmerealrh16=100*sumabsdiff_realrh16/sum(obsrh6(744:1487))
rrealrh16=escorc(realrh16(0:743),obsrh6(744:1487))
trealrh16=rrealrh16*sqrt((nrealrh16-2)/(1-rrealrh16^2))
dfrealrh16=nrealrh16-2
prealrh16=student_t(trealrh16,dfrealrh16) ;test significance level at the 95% level
if (prealrh16.le.0.05) then
    psig_realrh16="yes"
 else
   psig_realrh16="no"
end if
;print(mbrealrh16)
;print(merealrh16)
;print(nmbrealrh16)
;print(nmerealrh16)
;print(rrealrh16)
;print(prealrh16)
;print(psig_realrh16)

mbrealrh26=sumdiff_realrh26/nrealrh16
merealrh26=sumabsdiff_realrh26/nrealrh16
nmbrealrh26=100*sumdiff_realrh26/sum(obsrh6(744:1487))
nmerealrh26=100*sumabsdiff_realrh26/sum(obsrh6(744:1487))
rrealrh26=escorc(realrh26(0:743),obsrh6(744:1487))
trealrh26=rrealrh26*sqrt((nrealrh16-2)/(1-rrealrh26^2))
dfrealrh26=nrealrh16-2
prealrh26=student_t(trealrh26,dfrealrh26) ;test significance level at the 95% level
if (prealrh26.le.0.05) then
    psig_realrh26="yes"
 else
   psig_realrh26="no"
end if



mbrealrh36=sumdiff_realrh36/nrealrh16
merealrh36=sumabsdiff_realrh36/nrealrh16
nmbrealrh36=100*sumdiff_realrh36/sum(obsrh6(744:1487))
nmerealrh36=100*sumabsdiff_realrh36/sum(obsrh6(744:1487))
rrealrh36=escorc(realrh36(0:743),obsrh6(744:1487))
trealrh36=rrealrh36*sqrt((nrealrh16-2)/(1-rrealrh36^2))
dfrealrh36=nrealrh16-2
prealrh36=student_t(trealrh36,dfrealrh36) ;test significance level at the 95% level
if (prealrh36.le.0.05) then
    psig_realrh36="yes"
 else
   psig_realrh36="no"
end if

mbrealrh46=sumdiff_realrh46/nrealrh16
merealrh46=sumabsdiff_realrh46/nrealrh16
nmbrealrh46=100*sumdiff_realrh46/sum(obsrh6(744:1487))
nmerealrh46=100*sumabsdiff_realrh46/sum(obsrh6(744:1487))
rrealrh46=escorc(realrh46(0:743),obsrh6(744:1487))
trealrh46=rrealrh46*sqrt((nrealrh16-2)/(1-rrealrh46^2))
dfrealrh46=nrealrh16-2
prealrh46=student_t(trealrh46,dfrealrh46) ;test significance level at the 95% level
if (prealrh46.le.0.05) then
    psig_realrh46="yes"
 else
   psig_realrh46="no"
end if

mbrealrh17=sumdiff_realrh17/nrealrh17
merealrh17=sumabsdiff_realrh17/nrealrh17
nmbrealrh17=100*sumdiff_realrh17/sum(obsrh7(744:1487))
nmerealrh17=100*sumabsdiff_realrh17/sum(obsrh7(744:1487))
rrealrh17=escorc(realrh17(0:743),obsrh7(744:1487))
trealrh17=rrealrh17*sqrt((nrealrh17-2)/(1-rrealrh17^2))
dfrealrh17=nrealrh17-2
prealrh17=student_t(trealrh17,dfrealrh17) ;test significance level at the 95% level
if (prealrh17.le.0.05) then
    psig_realrh17="yes"
 else
   psig_realrh17="no"
end if
;print(mbrealrh17)
;print(merealrh17)
;print(nmbrealrh17)
;print(nmerealrh17)
;print(rrealrh17)
;print(prealrh17)
;print(psig_realrh17)

mbrealrh27=sumdiff_realrh27/nrealrh17
merealrh27=sumabsdiff_realrh27/nrealrh17
nmbrealrh27=100*sumdiff_realrh27/sum(obsrh7(744:1487))
nmerealrh27=100*sumabsdiff_realrh27/sum(obsrh7(744:1487))
rrealrh27=escorc(realrh27(0:743),obsrh7(744:1487))
trealrh27=rrealrh27*sqrt((nrealrh17-2)/(1-rrealrh27^2))
dfrealrh27=nrealrh17-2
prealrh27=student_t(trealrh27,dfrealrh27) ;test significance level at the 95% level
if (prealrh27.le.0.05) then
    psig_realrh27="yes"
 else
   psig_realrh27="no"
end if



mbrealrh37=sumdiff_realrh37/nrealrh17
merealrh37=sumabsdiff_realrh37/nrealrh17
nmbrealrh37=100*sumdiff_realrh37/sum(obsrh7(744:1487))
nmerealrh37=100*sumabsdiff_realrh37/sum(obsrh7(744:1487))
rrealrh37=escorc(realrh37(0:743),obsrh7(744:1487))
trealrh37=rrealrh37*sqrt((nrealrh17-2)/(1-rrealrh37^2))
dfrealrh37=nrealrh17-2
prealrh37=student_t(trealrh37,dfrealrh37) ;test significance level at the 95% level
if (prealrh37.le.0.05) then
    psig_realrh37="yes"
 else
   psig_realrh37="no"
end if

mbrealrh47=sumdiff_realrh47/nrealrh17
merealrh47=sumabsdiff_realrh47/nrealrh17
nmbrealrh47=100*sumdiff_realrh47/sum(obsrh7(744:1487))
nmerealrh47=100*sumabsdiff_realrh47/sum(obsrh7(744:1487))
rrealrh47=escorc(realrh47(0:743),obsrh7(744:1487))
trealrh47=rrealrh47*sqrt((nrealrh17-2)/(1-rrealrh47^2))
dfrealrh47=nrealrh17-2
prealrh47=student_t(trealrh47,dfrealrh47) ;test significance level at the 95% level
if (prealrh47.le.0.05) then
    psig_realrh47="yes"
 else
   psig_realrh47="no"
end if
avgnewobst2m=(/avgnewobst2m1,avgnewobst2m2,avgnewobst2m3,avgnewobst2m4,avgnewobst2m5,avgnewobst2m6,avgnewobst2m7/)
stddevnewobst2m=(/stddevnewobst2m1,stddevnewobst2m2,stddevnewobst2m3,stddevnewobst2m4,stddevnewobst2m5,stddevnewobst2m6,stddevnewobst2m7/)
avgnewobsws10m=(/avgnewobsws10m1,avgnewobsws10m2,avgnewobsws10m3,avgnewobsws10m4,avgnewobsws10m5,avgnewobsws10m6,avgnewobsws10m7/)
stddevnewobsws10m=(/stddevnewobsws10m1,stddevnewobsws10m2,stddevnewobsws10m3,stddevnewobsws10m4,stddevnewobsws10m5,stddevnewobsws10m6,stddevnewobsws10m7/)
avgnewobsrh=(/avgnewobsrh1,avgnewobsrh2,avgnewobsrh3,avgnewobsrh4,avgnewobsrh5,avgnewobsrh6,avgnewobsrh7/)
stddevnewobsrh=(/stddevnewobsrh1,stddevnewobsrh2,stddevnewobsrh3,stddevnewobsrh4,stddevnewobsrh5,stddevnewobsrh6,stddevnewobsrh7/)


avgobst2m=(/avgobst2m1,avgobst2m2,avgobst2m3,avgobst2m4,avgobst2m5,avgobst2m6,avgobst2m7/)
stddevobst2m=(/stddevobst2m1,stddevobst2m2,stddevobst2m3,stddevobst2m4,stddevobst2m5,stddevobst2m6,stddevobst2m7/)
mbt2m1=(/mbt2m11,mbt2m12,mbt2m13,mbt2m14,mbt2m15,mbt2m16,mbt2m17/)
;print(mbt2m1)
mbt2m2=(/mbt2m21,mbt2m22,mbt2m23,mbt2m24,mbt2m25,mbt2m26,mbt2m27/)
mbt2m3=(/mbt2m31,mbt2m32,mbt2m33,mbt2m34,mbt2m35,mbt2m36,mbt2m37/)
mbt2m4=(/mbt2m41,mbt2m42,mbt2m43,mbt2m44,mbt2m45,mbt2m46,mbt2m47/)

met2m1=(/met2m11,met2m12,met2m13,met2m14,met2m15,met2m16,met2m17/)
;print(met2m1)
met2m2=(/met2m21,met2m22,met2m23,met2m24,met2m25,met2m26,met2m27/)
met2m3=(/met2m31,met2m32,met2m33,met2m34,met2m35,met2m36,met2m37/)
met2m4=(/met2m41,met2m42,met2m43,met2m44,met2m45,met2m46,met2m47/)

nmbt2m1=(/nmbt2m11,nmbt2m12,nmbt2m13,nmbt2m14,nmbt2m15,nmbt2m16,nmbt2m17/)
;print(nmbt2m1)
nmbt2m2=(/nmbt2m21,nmbt2m22,nmbt2m23,nmbt2m24,nmbt2m25,nmbt2m26,nmbt2m27/)
nmbt2m3=(/nmbt2m31,nmbt2m32,nmbt2m33,nmbt2m34,nmbt2m35,nmbt2m36,nmbt2m37/)
nmbt2m4=(/nmbt2m41,nmbt2m42,nmbt2m43,nmbt2m44,nmbt2m45,nmbt2m46,nmbt2m47/)

nmet2m1=(/nmet2m11,nmet2m12,nmet2m13,nmet2m14,nmet2m15,nmet2m16,nmet2m17/)
;print(nmet2m1)
nmet2m2=(/nmet2m21,nmet2m22,nmet2m23,nmet2m24,nmet2m25,nmet2m26,nmet2m27/)
nmet2m3=(/nmet2m31,nmet2m32,nmet2m33,nmet2m34,nmet2m35,nmet2m36,nmet2m37/)
nmet2m4=(/nmet2m41,nmet2m42,nmet2m43,nmet2m44,nmet2m45,nmet2m46,nmet2m47/)

rt2m1=(/rt2m11,rt2m12,rt2m13,rt2m14,rt2m15,rt2m16,rt2m17/)
;print(rt2m1)
rt2m2=(/rt2m21,rt2m22,rt2m23,rt2m24,rt2m25,rt2m26,rt2m27/)
rt2m3=(/rt2m31,rt2m32,rt2m33,rt2m34,rt2m35,rt2m36,rt2m37/)
rt2m4=(/rt2m41,rt2m42,rt2m43,rt2m44,rt2m45,rt2m46,rt2m47/)
psig_t2m1=(/psig_t2m11,psig_t2m12,psig_t2m13,psig_t2m14,psig_t2m15,psig_t2m16,psig_t2m17/)
psig_t2m2=(/psig_t2m21,psig_t2m22,psig_t2m23,psig_t2m24,psig_t2m25,psig_t2m26,psig_t2m27/)
psig_t2m3=(/psig_t2m31,psig_t2m32,psig_t2m33,psig_t2m34,psig_t2m35,psig_t2m36,psig_t2m37/)
psig_t2m4=(/psig_t2m41,psig_t2m42,psig_t2m43,psig_t2m44,psig_t2m45,psig_t2m46,psig_t2m47/)



avgobsws10m=(/avgobsws10m1,avgobsws10m2,avgobsws10m3,avgobsws10m4,avgobsws10m5,avgobsws10m6,avgobsws10m7/)
stddevobsws10m=(/stddevobsws10m1,stddevobsws10m2,stddevobsws10m3,stddevobsws10m4,stddevobsws10m5,stddevobsws10m6,stddevobsws10m7/)
mbws10m1=(/mbws10m11,mbws10m12,mbws10m13,mbws10m14,mbws10m15,mbws10m16,mbws10m17/)
;print(mbws10m1)
mbws10m2=(/mbws10m21,mbws10m22,mbws10m23,mbws10m24,mbws10m25,mbws10m26,mbws10m27/)
mbws10m3=(/mbws10m31,mbws10m32,mbws10m33,mbws10m34,mbws10m35,mbws10m36,mbws10m37/)
mbws10m4=(/mbws10m41,mbws10m42,mbws10m43,mbws10m44,mbws10m45,mbws10m46,mbws10m47/)

mews10m1=(/mews10m11,mews10m12,mews10m13,mews10m14,mews10m15,mews10m16,mews10m17/)
;print(mews10m1)
mews10m2=(/mews10m21,mews10m22,mews10m23,mews10m24,mews10m25,mews10m26,mews10m27/)
mews10m3=(/mews10m31,mews10m32,mews10m33,mews10m34,mews10m35,mews10m36,mews10m37/)
mews10m4=(/mews10m41,mews10m42,mews10m43,mews10m44,mews10m45,mews10m46,mews10m47/)

nmbws10m1=(/nmbws10m11,nmbws10m12,nmbws10m13,nmbws10m14,nmbws10m15,nmbws10m16,nmbws10m17/)
;print(nmbws10m1)
nmbws10m2=(/nmbws10m21,nmbws10m22,nmbws10m23,nmbws10m24,nmbws10m25,nmbws10m26,nmbws10m27/)
nmbws10m3=(/nmbws10m31,nmbws10m32,nmbws10m33,nmbws10m34,nmbws10m35,nmbws10m36,nmbws10m37/)
nmbws10m4=(/nmbws10m41,nmbws10m42,nmbws10m43,nmbws10m44,nmbws10m45,nmbws10m46,nmbws10m47/)

nmews10m1=(/nmews10m11,nmews10m12,nmews10m13,nmews10m14,nmews10m15,nmews10m16,nmews10m17/)
;print(nmews10m1)
nmews10m2=(/nmews10m21,nmews10m22,nmews10m23,nmews10m24,nmews10m25,nmews10m26,nmews10m27/)
nmews10m3=(/nmews10m31,nmews10m32,nmews10m33,nmews10m34,nmews10m35,nmews10m36,nmews10m37/)
nmews10m4=(/nmews10m41,nmews10m42,nmews10m43,nmews10m44,nmews10m45,nmews10m46,nmews10m47/)

rws10m1=(/rws10m11,rws10m12,rws10m13,rws10m14,rws10m15,rws10m16,rws10m17/)
;print(rws10m1)
rws10m2=(/rws10m21,rws10m22,rws10m23,rws10m24,rws10m25,rws10m26,rws10m27/)
rws10m3=(/rws10m31,rws10m32,rws10m33,rws10m34,rws10m35,rws10m36,rws10m37/)
rws10m4=(/rws10m41,rws10m42,rws10m43,rws10m44,rws10m45,rws10m46,rws10m47/)
psig_ws10m1=(/psig_ws10m11,psig_ws10m12,psig_ws10m13,psig_ws10m14,psig_ws10m15,psig_ws10m16,psig_ws10m17/)
psig_ws10m2=(/psig_ws10m21,psig_ws10m22,psig_ws10m23,psig_ws10m24,psig_ws10m25,psig_ws10m26,psig_ws10m27/)
psig_ws10m3=(/psig_ws10m31,psig_ws10m32,psig_ws10m33,psig_ws10m34,psig_ws10m35,psig_ws10m36,psig_ws10m37/)
psig_ws10m4=(/psig_ws10m41,psig_ws10m42,psig_ws10m43,psig_ws10m44,psig_ws10m45,psig_ws10m46,psig_ws10m47/)

avgobsrh=(/avgobsrh1,avgobsrh2,avgobsrh3,avgobsrh4,avgobsrh5,avgobsrh6,avgobsrh7/)
stddevobsrh=(/stddevobsrh1,stddevobsrh2,stddevobsrh3,stddevobsrh4,stddevobsrh5,stddevobsrh6,stddevobsrh7/)
mbrealrh1=(/mbrealrh11,mbrealrh12,mbrealrh13,mbrealrh14,mbrealrh15,mbrealrh16,mbrealrh17/)
;print(mbrealrh1)
mbrealrh2=(/mbrealrh21,mbrealrh22,mbrealrh23,mbrealrh24,mbrealrh25,mbrealrh26,mbrealrh27/)
mbrealrh3=(/mbrealrh31,mbrealrh32,mbrealrh33,mbrealrh34,mbrealrh35,mbrealrh36,mbrealrh37/)
mbrealrh4=(/mbrealrh41,mbrealrh42,mbrealrh43,mbrealrh44,mbrealrh45,mbrealrh46,mbrealrh47/)

merealrh1=(/merealrh11,merealrh12,merealrh13,merealrh14,merealrh15,merealrh16,merealrh17/)
;print(merealrh1)
merealrh2=(/merealrh21,merealrh22,merealrh23,merealrh24,merealrh25,merealrh26,merealrh27/)
merealrh3=(/merealrh31,merealrh32,merealrh33,merealrh34,merealrh35,merealrh36,merealrh37/)
merealrh4=(/merealrh41,merealrh42,merealrh43,merealrh44,merealrh45,merealrh46,merealrh47/)

nmbrealrh1=(/nmbrealrh11,nmbrealrh12,nmbrealrh13,nmbrealrh14,nmbrealrh15,nmbrealrh16,nmbrealrh17/)
;print(nmbrealrh1)
nmbrealrh2=(/nmbrealrh21,nmbrealrh22,nmbrealrh23,nmbrealrh24,nmbrealrh25,nmbrealrh26,nmbrealrh27/)
nmbrealrh3=(/nmbrealrh31,nmbrealrh32,nmbrealrh33,nmbrealrh34,nmbrealrh35,nmbrealrh36,nmbrealrh37/)
nmbrealrh4=(/nmbrealrh41,nmbrealrh42,nmbrealrh43,nmbrealrh44,nmbrealrh45,nmbrealrh46,nmbrealrh47/)

nmerealrh1=(/nmerealrh11,nmerealrh12,nmerealrh13,nmerealrh14,nmerealrh15,nmerealrh16,nmerealrh17/)
;print(nmerealrh1)
nmerealrh2=(/nmerealrh21,nmerealrh22,nmerealrh23,nmerealrh24,nmerealrh25,nmerealrh26,nmerealrh27/)
nmerealrh3=(/nmerealrh31,nmerealrh32,nmerealrh33,nmerealrh34,nmerealrh35,nmerealrh36,nmerealrh37/)
nmerealrh4=(/nmerealrh41,nmerealrh42,nmerealrh43,nmerealrh44,nmerealrh45,nmerealrh46,nmerealrh47/)

rrealrh1=(/rrealrh11,rrealrh12,rrealrh13,rrealrh14,rrealrh15,rrealrh16,rrealrh17/)
;;print(rrealrh1)
rrealrh2=(/rrealrh21,rrealrh22,rrealrh23,rrealrh24,rrealrh25,rrealrh26,rrealrh27/)
rrealrh3=(/rrealrh31,rrealrh32,rrealrh33,rrealrh34,rrealrh35,rrealrh36,rrealrh37/)
rrealrh4=(/rrealrh41,rrealrh42,rrealrh43,rrealrh44,rrealrh45,rrealrh46,rrealrh47/)
psig_realrh1=(/psig_realrh11,psig_realrh12,psig_realrh13,psig_realrh14,psig_realrh15,psig_realrh16,psig_realrh17/)
psig_realrh2=(/psig_realrh21,psig_realrh22,psig_realrh23,psig_realrh24,psig_realrh25,psig_realrh26,psig_realrh27/)
psig_realrh3=(/psig_realrh31,psig_realrh32,psig_realrh33,psig_realrh34,psig_realrh35,psig_realrh36,psig_realrh37/)
psig_realrh4=(/psig_realrh41,psig_realrh42,psig_realrh43,psig_realrh44,psig_realrh45,psig_realrh46,psig_realrh47/)

csv_filename="./Met_Stat_NonPCAPs.csv"
header=[/"obs_t2m"+",stdev_t2m"+",MB_t2m_ACM2"+",MB_t2m_YSU"+",MB_t2m_MYJ"+",MB_t2m_MYNN"+",ME_t2m_ACM2"+",ME_t2m_YSU"+",ME_t2m_MYJ"+",ME_t2m_MYNN"+",NMB_t2m_ACM2"+",NMB_t2m_YSU"+",NMB_t2m_MYJ"+",NMB_t2m_MYNN"+",NME_t2m_ACM2"+",NME_t2m_YSU"+",NME_t2m_MYJ"+",NME_t2m_MYNN"+",R_t2m_ACM2"+",R_t2m_YSU"+",R_t2m_MYJ"+",R_t2m_MYNN"+",Psig_t2m_ACM2"+",Psig_t2m_YSU"+",Psig_t2m_MYJ"+",Psig_t2m_MYNN"+",obs_ws10m"+",stdev_ws10m"+",MB_ws10m_ACM2"+",MB_ws10m_YSU"+",MB_ws10m_MYJ"+",MB_ws10m_MYNN"+",ME_ws10m_ACM2"+",ME_ws10m_YSU"+",ME_ws10m_MYJ"+",ME_ws10m_MYNN"+",NMB_ws10m_ACM2"+",NMB_ws10m_YSU"+",NMB_ws10m_MYJ"+",NMB_ws10m_MYNN"+",NME_ws10m_ACM2"+",NME_ws10m_YSU"+",NME_ws10m_MYJ"+",NME_ws10m_MYNN"+",R_ws10m_ACM2"+",R_ws10m_YSU"+",R_ws10m_MYJ"+",R_ws10m_MYNN"+",Psig_ws10m_ACM2"+",Psig_ws10m_YSU"+",Psig_ws10m_MYJ"+",Psig_ws10m_MYNN"+",obs_rh"+",stdev_rh"+",MB_rh_ACM2"+",MB_rh_YSU"+",MB_rh_MYJ"+",MB_rh_MYNN"+",ME_rh_ACM2"+",ME_rh_YSU"+",ME_rh_MYJ"+",ME_rh_MYNN"+",NMB_rh_ACM2"+",NMB_rh_YSU"+",NMB_rh_MYJ"+",NMB_rh_MYNN"+",NME_rh_ACM2"+",NME_rh_YSU"+",NME_rh_MYJ"+",NME_rh_MYNN"+",R_rh_ACM2"+",R_rh_YSU"+",R_rh_MYJ"+",R_rh_MYNN"+",Psig_rh_ACM2"+",Psig_rh_YSU"+",Psig_rh_MYJ"+",Psig_rh_MYNN"/]
write_table(csv_filename,"w",header,"%s")
;do i=0,6,1
alist=[/avgnewobst2m,stddevnewobst2m,mbt2m1,mbt2m2,mbt2m3,mbt2m4,met2m1,met2m2,met2m3,met2m4,nmbt2m1,nmbt2m2,nmbt2m3,nmbt2m4,nmet2m1,nmet2m2,nmet2m3,nmet2m4,rt2m1,rt2m3,rt2m3,rt2m4,psig_t2m1,psig_t2m2,psig_t2m3,psig_t2m4,avgnewobsws10m,stddevnewobsws10m,mbws10m1,mbws10m2,mbws10m3,mbws10m4,mews10m1,mews10m2,mews10m3,mews10m4,nmbws10m1,nmbws10m2,nmbws10m3,nmbws10m4,nmews10m1,nmews10m2,nmews10m3,nmews10m4,rws10m1,rws10m3,rws10m3,rws10m4,psig_ws10m1,psig_ws10m2,psig_ws10m3,psig_ws10m4,avgnewobsrh,stddevnewobsrh,mbrealrh1,mbrealrh2,mbrealrh3,mbrealrh4,merealrh1,merealrh2,merealrh3,merealrh4,nmbrealrh1,nmbrealrh2,nmbrealrh3,nmbrealrh4,nmerealrh1,nmerealrh2,nmerealrh3,nmerealrh4,rrealrh1,rrealrh3,rrealrh3,rrealrh4,psig_realrh1,psig_realrh2,psig_realrh3,psig_realrh4/]
format="%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%s,%s,%s,%s,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%s,%s,%s,%s,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%s,%s,%s,%s"
write_table(csv_filename, "a", alist, format)

end
