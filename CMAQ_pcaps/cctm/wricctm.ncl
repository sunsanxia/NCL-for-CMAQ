load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
begin
f1=addfile("/data/gpfs/assoc/ataq/xsun/soft/CMAQ/CMAQ_v5.2/data/POST/COMBINE_ACONC_v52_intel_4UTWY1_ACM2_201101.nc","r")
f2=addfile("/data/gpfs/assoc/ataq/xsun/soft/CMAQ/CMAQ_v5.2/data/POST/COMBINE_ACONC_v52_intel_4UTWY1_YSU_201101.nc","r")
f3=addfile("/data/gpfs/assoc/ataq/xsun/soft/CMAQ/CMAQ_v5.2/data/POST/COMBINE_ACONC_v52_intel_4UTWY1_MYJ_201101.nc","r")
csv_filename="./combines.csv"
header=[/"Date"+",Time"+",NH3_ACM2"+",NH3_YSU"+",NH3_MYJ"+",N2O5_ACM2"+",N2O5_YSU"+",N2O5_MYJ"+",NHX_ACM2"+",NHX_YSU"+",NHX_MYJ"+",PM25_NH4_ACM2"+",PM25_NH4_YSU"+",PM25_NH4_MYJ"+",PM25_NO3_ACM2"+",PM25_NO3_YSU"+",PM25_NO3_MYJ"+",PM25_OC_ACM2"+",PM25_OC_YSU"+",PM25_OC_MYJ"+",PM25_EC_ACM2"+",PM25_EC_YSU"+",PM25_EC_MYJ"+",PM25_SO4_ACM2"+",PM25_SO4_YSU"+",PM25_SO4_MYJ"/]
write_table(csv_filename,"w",header,"%s")

fils4 = systemfunc("ls /data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/wrfoutJan/ACM2/wrfout_d02*")
f4 = addfiles(fils4,"r")
siteidlat=40.7364  ;Hathorone site
siteidlon=-111.8722
llres = True
  llres@ReturnInt = True ; Return integer values
    locij1 = wrf_user_ll_to_ij(f4, siteidlon, siteidlat, llres)
  locij1 = locij1 -1
  locX = locij1(0)
  locY = locij1(1)

  locX1= locX-22           ;MCIP grids
  locY1= locY-25            ;MCIP grids
nh31=f1->NH3
nh32=f2->NH3
nh33=f3->NH3

N2O51=f1->N2O5
N2O52=f2->N2O5
N2O53=f3->N2O5

NHX1=f1->NHX
NHX2=f2->NHX
NHX3=f3->NHX

PM25_NH41=f1->PM25_NH4
PM25_NH42=f2->PM25_NH4
PM25_NH43=f3->PM25_NH4

PM25_NO31=f1->PM25_NO3
PM25_NO32=f2->PM25_NO3
PM25_NO33=f3->PM25_NO3

PM25_OC1=f1->PM25_OC
PM25_OC2=f2->PM25_OC
PM25_OC3=f3->PM25_OC

PM25_EC1=f1->PM25_EC
PM25_EC2=f2->PM25_EC
PM25_EC3=f3->PM25_EC

PM25_SO41=f1->PM25_SO4
PM25_SO42=f2->PM25_SO4
PM25_SO43=f3->PM25_SO4

hnh31=nh31(:,0,locY1,locX1)
hnh32=nh32(:,0,locY1,locX1)
hnh33=nh33(:,0,locY1,locX1)

hN2O51=N2O51(:,0,locY1,locX1)
hN2O52=N2O52(:,0,locY1,locX1)
hN2O53=N2O53(:,0,locY1,locX1)

hNHX1=NHX1(:,0,locY1,locX1)
hNHX2=NHX2(:,0,locY1,locX1)
hNHX3=NHX3(:,0,locY1,locX1)

hPM25_NH41=PM25_NH41(:,0,locY1,locX1)
hPM25_NH42=PM25_NH42(:,0,locY1,locX1)
hPM25_NH43=PM25_NH43(:,0,locY1,locX1)

hPM25_NO31=PM25_NO31(:,0,locY1,locX1)
hPM25_NO32=PM25_NO32(:,0,locY1,locX1)
hPM25_NO33=PM25_NO33(:,0,locY1,locX1)

hPM25_OC1=PM25_OC1(:,0,locY1,locX1)
hPM25_OC2=PM25_OC2(:,0,locY1,locX1)
hPM25_OC3=PM25_OC3(:,0,locY1,locX1)

hPM25_EC1=PM25_EC1(:,0,locY1,locX1)
hPM25_EC2=PM25_EC2(:,0,locY1,locX1)
hPM25_EC3=PM25_EC3(:,0,locY1,locX1)

hPM25_SO41=PM25_SO41(:,0,locY1,locX1)
hPM25_SO42=PM25_SO42(:,0,locY1,locX1)
hPM25_SO43=PM25_SO43(:,0,locY1,locX1)

timecctm=f1->TFLAG
cctmdate=timecctm(:,0,0)
cctmtime=timecctm(:,0,1)
alist=[/cctmdate,cctmtime,hnh31,hnh32,hnh33,hN2O51,hN2O52,hN2O53,hNHX1,hNHX2,hNHX3,hPM25_NH41,hPM25_NH42,hPM25_NH43,hPM25_NO31,hPM25_NO32,hPM25_NO33,hPM25_OC1,hPM25_OC2,hPM25_OC3,hPM25_EC1,hPM25_EC2,hPM25_EC3,hPM25_SO41,hPM25_SO42,hPM25_SO43/]
format="%i,%i,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g"
write_table(csv_filename, "a", alist, format)

end