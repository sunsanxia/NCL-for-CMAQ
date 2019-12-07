;******Code for calculate Valley Heat Deficit H22. This code is written for WRF outputs. 
;*******Written by Xia Sun, 26 Sep 2018, emsunxia@gmail.com***************
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
fils4 = systemfunc("ls /data/gpfs/home/xsun/CMAQ_v5.2/data/wrf/MYNN_pcaps/wrfout_d02_2011-01*")
f4=addfiles(fils4, "r")
csv_filename="./H22_WRF_HW.csv"
header=[/"Time(UTC)"+",ACM2_H22"+",YSU_H22"+",MYJ_H22"+",MYNN_H22"/]
write_table(csv_filename,"w",header,"%s")

hwlat=40.7364
hwlon=-111.872
 llres = True
  llres@ReturnInt = True ; Return integer values
    locij1 = wrf_user_ll_to_ij(f1, hwlon, hwlat, llres)
  locij1 = locij1 -1
  locX = locij1(0)
  locY = locij1(1)

height1=wrf_user_getvar(f1, "height", -1)
height2=wrf_user_getvar(f2, "height", -1)
height3=wrf_user_getvar(f3, "height", -1)
height4=wrf_user_getvar(f4, "height", -1)
print(height1(0,:,0,0))
print(height2(0,:,0,0))
print(height3(0,:,0,0))
pressure1=wrf_user_getvar(f1, "pressure", -1)
pressure2=wrf_user_getvar(f2, "pressure", -1)
pressure3=wrf_user_getvar(f3, "pressure", -1)
pressure4=wrf_user_getvar(f4, "pressure", -1)


tk1=wrf_user_getvar(f1, "tk", -1)
tk2=wrf_user_getvar(f2, "tk", -1)
tk3=wrf_user_getvar(f3, "tk", -1)
tk4=wrf_user_getvar(f4, "tk", -1)

th1=wrf_user_getvar(f1, "th", -1)
th2=wrf_user_getvar(f2, "th", -1)
th3=wrf_user_getvar(f3, "th", -1)
th4=wrf_user_getvar(f4, "th", -1)
hh=2200.0 ;integral height,m
cp=1005.0 ;J kg-1 K-1
R=287.05 ;for calculation of air density
;vars=new((/110,436,20/),string)
;vars=(/"c","a","b"/)
z=21
time=wrf_user_getvar(f1, "times", -1)
timen=dimsizes(time)
print(time)
print(timen)
print(height4(10,21,locY,locX))
do j=0,timen-1,1
    sumh1=0.0
    maxth1=th1(j,21,locY,locX)
    sumh2=0.0
    maxth2=th2(j,21,locY,locX)
    sumh3=0.0
    maxth3=th3(j,21,locY,locX)
     sumh4=0.0
    maxth4=th4(j,21,locY,locX)
do i=0,z,1
    
 avelayerp1= (pressure1(j,i,locY,locX)+pressure1(j,i+1,locY,locX))/2.0
 avedensity1= 100.00*(pressure1(j,i,locY,locX)/tk1(j,i,locY,locX)+pressure1(j,i+1,locY,locX)/tk1(j,i+1,locY,locX))/(2.0*R)  ;kg m-3
   ; print(p(i)/t(i))
   avelayerth1 = (th1(j,i,locY,locX)+th1(j,i+1,locY,locX))/2.0
  ; print(avelayerth)
   ;print(maxth)
   hlayer1 = cp*(height1(j,i+1,locY,locX)-height1(j,i,locY,locX))*(maxth1-avelayerth1)*avedensity1
   sumh1=sumh1+hlayer1

    avelayerp2= (pressure2(j,i,locY,locX)+pressure2(j,i+1,locY,locX))/2.0
 avedensity2= 100.00*(pressure2(j,i,locY,locX)/tk2(j,i,locY,locX)+pressure2(j,i+1,locY,locX)/tk2(j,i+1,locY,locX))/(2.0*R)  ;kg m-3
   ; print(p(i)/t(i))
   avelayerth2 = (th2(j,i,locY,locX)+th2(j,i+1,locY,locX))/2.0
  ; print(avelayerth)
   ;print(maxth)
   hlayer2 = cp*(height2(j,i+1,locY,locX)-height2(j,i,locY,locX))*(maxth2-avelayerth2)*avedensity2
   sumh2=sumh2+hlayer2

    avelayerp3= (pressure3(j,i,locY,locX)+pressure3(j,i+1,locY,locX))/2.0
 avedensity3= 100.00*(pressure3(j,i,locY,locX)/tk3(j,i,locY,locX)+pressure3(j,i+1,locY,locX)/tk3(j,i+1,locY,locX))/(2.0*R)  ;kg m-3
   ; print(p(i)/t(i))
   avelayerth3 = (th3(j,i,locY,locX)+th3(j,i+1,locY,locX))/2.0
  ; print(avelayerth)
   ;print(maxth)
   hlayer3 = cp*(height3(j,i+1,locY,locX)-height3(j,i,locY,locX))*(maxth3-avelayerth3)*avedensity3
   sumh3=sumh3+hlayer3

    avelayerp4= (pressure4(j,i,locY,locX)+pressure4(j,i+1,locY,locX))/2.0
 avedensity4= 100.00*(pressure4(j,i,locY,locX)/tk4(j,i,locY,locX)+pressure4(j,i+1,locY,locX)/tk4(j,i+1,locY,locX))/(2.0*R)  ;kg m-3
   ; print(p(i)/t(i))
   avelayerth4 = (th4(j,i,locY,locX)+th4(j,i+1,locY,locX))/2.0
  ; print(avelayerth)
   ;print(maxth)
   hlayer4 = cp*(height4(j,i+1,locY,locX)-height4(j,i,locY,locX))*(maxth4-avelayerth4)*avedensity4
   sumh4=sumh4+hlayer4
 end do
 H22_acm2=sumh1*(1e-6)
  H22_ysu=sumh2*(1e-6)
   H22_myj=sumh3*(1e-6)
    H22_mynn=sumh4*(1e-6)

ntime=time(j)
print(H22_acm2)
alist=[/ntime,H22_acm2,H22_ysu,H22_myj,H22_mynn/]
format="%s,%g,%g,%g,%g"
write_table(csv_filename, "a", alist, format)

end do

;alist=[/fili(nf),H22/]
;format="%s,%g"
;write_table(csv_filename, "a", alist, format)
;vars=(/"a","b","c"/)





end
