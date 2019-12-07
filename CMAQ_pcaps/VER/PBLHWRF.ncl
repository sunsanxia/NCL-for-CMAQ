;******Code for extract PBL heights*************************************
;*******Written by Xia Sun, 27 Sep 2018, emsunxia@gmail.com***************
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

;f4 = addfile("/data/gpfs/home/xsun/CMAQ_v5.2/data/mcip/ACM2_pcaps/METCRO2D_PCAPs_ACM2.nc","r")
;f5 = addfile("/data/gpfs/home/xsun/CMAQ_v5.2/data/mcip/YSU_pcaps/METCRO2D_PCAPs_YSU.nc","r")
;f6 = addfile("/data/gpfs/home/xsun/CMAQ_v5.2/data/mcip/MYJ_pcaps/METCRO2D_PCAPs_MYJ.nc","r")
fils4=systemfunc("ls /data/gpfs/assoc/ataq/xsun/soft/CMAQ/CMAQ_v5.2/data/POST/COMBINE_CONC_v52_intel_4UTWY1_ACM2_201*")
f4= addfiles(fils4, "r")
fils5=systemfunc("ls /data/gpfs/assoc/ataq/xsun/soft/CMAQ/CMAQ_v5.2/data/POST/COMBINE_CONC_v52_intel_4UTWY1_YSU_201*")
f5= addfiles(fils5, "r")
fils6=systemfunc("ls /data/gpfs/assoc/ataq/xsun/soft/CMAQ/CMAQ_v5.2/data/POST/COMBINE_CONC_v52_intel_4UTWY1_MYJ_201*")
f6= addfiles(fils6, "r")

csv_filename="./PBLH_WRF_MCIP_NACR.csv"
header=[/"Time(UTC)"+",ACM2_PBLH(WRF)"+",ACM2_PBLH(MCIP)"+",YSU_PBLH(WRF)"+",YSU_PBLH(MCIP)"+",MYJ_PBLH(WRF)"+",MYJ_PBLH(MCIP)"/]
write_table(csv_filename,"w",header,"%s")

ncarlat=40.6006
ncarlon=-111.9252 
 llres = True
  llres@ReturnInt = True ; Return integer values
    locij1 = wrf_user_ll_to_ij(f1, ncarlon, ncarlat, llres)
  locij1 = locij1 -1
  locX = locij1(0)
  locY = locij1(1)

  locX1= locX-22           ;MCIP grids
  locY1= locY-25            ;MCIP grids
  ;****check the lat and lon from wrfout and mcip***************
  mcipfile = addfile("/data/gpfs/home/xsun/CMAQ_v5.2/data/mcip/ACM2_pcaps/GRIDCRO2D_PCAPs_ACM2.nc","r")
  latmcip=mcipfile->LAT
  lonmcip=mcipfile->LON

  wrffile = addfile("/data/gpfs/home/xsun/modify/ACM2_MPI/WRFV3/run_ACM2_pcaps7/wrfout_d02_2011-01-27_00:00:00","r")
  latwrf=wrffile->XLAT
  lonwrf=wrffile->XLONG
  latmcip0=latmcip(0,0,locY1,locX1)
  lonmcip0=lonmcip(0,0,locY1,locX1)
  latwrf0=latwrf(0,locY,locX)
   lonwrf0=lonwrf(0,locY,locX)
   print(latwrf0)
  print(lonwrf0)
  print(latmcip0)
  print(lonmcip0)
;****check the lat and lon from wrfout and mcip***************
  time=wrf_user_getvar(f1, "times", -1)
  PBLH1=wrf_user_getvar(f1, "PBLH", -1)
  PBLH2=wrf_user_getvar(f2, "PBLH", -1)
  PBLH3=wrf_user_getvar(f3, "PBLH", -1)
  nPBLH1=PBLH1(:,locY,locX)
   nPBLH2=PBLH2(:,locY,locX)
    nPBLH3=PBLH3(:,locY,locX)
;timemcip=f4->TFLAG ;timestamp for Jan 01 2011 0000 is i=72, for Jan 31 2011 2300 is i =815
;peekdate=timemcip(:,0,0)
;peektime=timemcip(:,0,1)
;print("date="+peekdate +" time" +peektime)

 PBLH4=f4[:]->PBLH
 PBLH5=f5[:]->PBLH
 PBLH6=f6[:]->PBLH
nPBLH4=PBLH4(72:815,0,locY1,locX1)
nPBLH5=PBLH5(72:815,0,locY1,locX1)
nPBLH6=PBLH6(72:815,0,locY1,locX1)


alist=[/time,nPBLH1,nPBLH4,nPBLH2,nPBLH5,nPBLH3,nPBLH6/]
format="%s,%g,%g,%g,%g,%g,%g"
write_table(csv_filename, "a", alist, format)

wks=gsn_open_wks("png", "WRF_MCIP_PBLH")
res=True
res@gsnMaximize=True
res@pmLegendDisplayMode="Always"
res@tiYAxisString="PBLH (m)"
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

resmcip=True
resmcip@gsnMaximize=True
resmcip@pmLegendDisplayMode="Always"
resmcip@xyExplicitLegendLabels = (/"MCIP"/)
;resmcip@xyLineColors=(/"orange"/)
resmcip@xyMarkLineMode="Markers"
resmcip@xyMarker=16
resmcip@xyMarkerColor="orange"
resmcip@lgPerimOn = False
resmcip@lgLabelFontHeightF=0.02
resmcip@lgBoxMinorExtentF=0.1
resmcip@pmLegendHeightF=0.06
resmcip@pmLegendParallelPosF=0.72
resmcip@pmLegendOrthogonalPosF=-0.88
;resmcip@trXMinF=2011001
;resmcip@trXMaxF=2011031

datapbl=new((/3,744/),float)
datapbl(0,:)=nPBLH3
datapbl(1,:)=nPBLH2
datapbl(2,:)=nPBLH1

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
plot1=gsn_csm_xy(wks,utahtime,datapbl,res)
draw(plot1)
frame(wks)
end
