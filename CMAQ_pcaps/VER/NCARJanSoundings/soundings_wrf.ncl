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
datename="/data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/NCARJanSoundings/NCARJanSounding.csv"
delim=","
vars=asciiread(datename, -1, "string")
obsname=str_get_field(vars(1::), 1, delim)
print(obsname)
obsdate=tointeger(str_get_field(vars(1::), 2, delim))
print(obsdate)
obstime=tointeger(str_get_field(vars(1::), 3, delim))
print(obstime)
fils1 = systemfunc("ls /data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/wrfoutJan/ACM2/wrfout_d02*")
f1 = addfiles(fils1,"r")
fils2 = systemfunc("ls /data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/wrfoutJan/YSU/wrfout_d02*")
f2 = addfiles(fils2,"r")
fils3 = systemfunc("ls /data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/wrfoutJan/MYJ/wrfout_d02*")
f3 = addfiles(fils3,"r")
ncarlat=40.6006
ncarlon=-111.9252 
 llres = True
  llres@ReturnInt = True ; Return integer values
    locij1 = wrf_user_ll_to_ij(f1, ncarlon, ncarlat, llres)
  locij1 = locij1 -1
  locX = locij1(0)
  locY = locij1(1)

time1=wrf_user_getvar(f1,"times",-1)
print(time1)
;wrfi=(obsdate-20110101)*24+obstime ;soundings should be UTC time
;print(wrfi)
;print(time1(wrfi))
height1=wrf_user_getvar(f1, "height", -1)
height2=wrf_user_getvar(f2, "height", -1)
height3=wrf_user_getvar(f3, "height", -1)

nheight1=height1(:,:,locY,locX)
nheight2=height2(:,:,locY,locX)
nheight3=height3(:,:,locY,locX)

tk1=wrf_user_getvar(f1, "tk", -1)
tk2=wrf_user_getvar(f2, "tk", -1)
tk3=wrf_user_getvar(f3, "tk", -1)

ntk1=tk1(:,:,locY,locX)
ntk2=tk2(:,:,locY,locX)
ntk3=tk3(:,:,locY,locX)

th1=wrf_user_getvar(f1, "th", -1)
th2=wrf_user_getvar(f2, "th", -1)
th3=wrf_user_getvar(f3, "th", -1)

nth1=th1(:,:,locY,locX)
nth2=th2(:,:,locY,locX)
nth3=th3(:,:,locY,locX)

tk1=wrf_user_getvar(f1, "tk", -1)
tk2=wrf_user_getvar(f2, "tk", -1)
tk3=wrf_user_getvar(f3, "tk", -1)

ntk1=tk1(:,:,locY,locX)
ntk2=tk2(:,:,locY,locX)
ntk3=tk3(:,:,locY,locX)

ua1=wrf_user_getvar(f1, "ua", -1)
ua2=wrf_user_getvar(f2, "ua", -1)
ua3=wrf_user_getvar(f3, "ua", -1)

nua1=ua1(:,:,locY,locX)
nua2=ua2(:,:,locY,locX)
nua3=ua3(:,:,locY,locX)

va1=wrf_user_getvar(f1, "va", -1)
va2=wrf_user_getvar(f2, "va", -1)
va3=wrf_user_getvar(f3, "va", -1)

nva1=va1(:,:,locY,locX)
nva2=va2(:,:,locY,locX)
nva3=va3(:,:,locY,locX)

nws1=sqrt(nua1^2+nva1^2)
nws2=sqrt(nua2^2+nva2^2)
nws3=sqrt(nua3^2+nva3^2)

nwdir1=wind_direction(nua1, nva1, 0)
nwdir2=wind_direction(nua2, nva2, 0)
nwdir3=wind_direction(nua3, nva3, 0)

 QVAPOR1=wrf_user_getvar(f1, "QVAPOR", -1)
QVAPOR2=wrf_user_getvar(f2, "QVAPOR", -1)
QVAPOR3=wrf_user_getvar(f3, "QVAPOR", -1)

nQVAPOR1=1000.0*QVAPOR1(:,:,locY,locX)  ;model output is kg/kg, multiple by 1000, unit is converted to g/kg now
nQVAPOR2=1000.0*QVAPOR2(:,:,locY,locX)
nQVAPOR3=1000.0*QVAPOR3(:,:,locY,locX)
res=True
res@gsnDraw=False
res@tiYAxisString="Height (km)"
res@xyExplicitLegendLabels = (/"NAM_ACM2","NAM_YSU","NAM_MYJ","OBS"/)
res@xyLineColors=(/"red","blue","greeen","black"/)
res@xyLineThicknessF=3
res@trYMinF=1.0
res@trYMaxF=3.0
;res@tiMainString=nobsname
res1=res
res1@tiXAxisString="T (k)"
res2=res
res2@tiXAxisString="POT (k)"
res3=res
res3@tiXAxisString="WS (m/s)"
res4=res
res4@tiXAxisString="Wdir (deg)"
res5=res
res5@tiXAxisString="Qv (g/kg)"

do i=0,65,1
    nobsname=obsname(i)
    nobsvars=asciiread(nobsname, -1, "string")
    delim = " "
    wks1=gsn_open_wks("png","./T"+obsname(i))
    print(nobsname)
    ;wks2=gsn_open_wks("png","./WS"+obsname(i))
    ;wks3=gsn_open_wks("png","./Qv"+obsname(i))
    ;wks4=gsn_open_wks("png","./Wdir"+obsname(i))
    ;wks5=gsn_open_wks("png","./th"+obsname(i))
    res1@tiMainString=nobsname
  height=tofloat(str_get_field(nobsvars(8::), 1, delim))*0.001
tmp = tofloat(str_get_field(nobsvars(8::), 3, delim))+273.15
mx=tofloat(str_get_field(obsvars(8::), 6, delim))
pot=tofloat(str_get_field(obsvars(8::), 9, delim))
ws=tofloat(str_get_field(obsvars(8::), 12, delim))
wdir=tofloat(str_get_field(obsvars(8::), 13, delim))
wrfi=(obsdate(i)-20110101)*24+obstime(i)
height1_point=nheight1(wrfi,:)*0.001
height2_point=nheight2(wrfi,:)*0.001
height3_point=nheight3(wrfi,:)*0.001
tk1_point=ntk1(wrfi,:)
tk2_point=ntk2(wrfi,:)
tk3_point=ntk3(wrfi,:)
th1_point=nth1(wrfi,:)
th2_point=nth2(wrfi,:)
th3_point=nth3(wrfi,:)
ws1_point=nws1(wrfi,:)
ws2_point=nws2(wrfi,:)
ws3_point=nws3(wrfi,:)
wdir1_point=nwdir1(wrfi,:)
wdir2_point=nwdir2(wrfi,:)
wdir3_point=nwdir3(wrfi,:)
QVAPOR1_point=nQVAPOR1(wrfi,:)
QVAPOR2_point=nQVAPOR2(wrfi,:)
QVAPOR3_point=nQVAPOR3(wrfi,:)

datatk=new((/3,41/),float)
datatk(0,:)=tk1_point
datatk(1,:)=tk2_point
datatk(2,:)=tk3_point


datath=new((/3,41/),float)
datath(0,:)=th1_point
datath(1,:)=th2_point
datath(2,:)=th3_point


dataws=new((/3,41/),float)
dataws(0,:)=ws1_point
dataws(1,:)=ws2_point
dataws(2,:)=ws3_point


datawdir=new((/3,41/),float)
datawdir(0,:)=wdir1_point
datawdir(1,:)=wdir2_point
datawdir(2,:)=wdir3_point


dataQVAPOR=new((/3,41/),float)
dataQVAPOR(0,:)=QVAPOR1_point
dataQVAPOR(1,:)=QVAPOR2_point
dataQVAPOR(2,:)=QVAPOR3_point


plot1=gsn_csm_x2y2(wk1,datatk,tmp,height1_point,height,res1,res1)
;plot2=gsn_csm_x2y2(wk2,dataws,ws,height1_point,height,res3,res3)
;plot3=gsn_csm_x2y2(wk3,dataQVAPOR,mx,height1_point,height,res5,res5)
;plot4=gsn_csm_x2y2(wk4,datawdir,wdir,height1_point,height,res4,res4)
;plot5=gsn_csm_x2y2(wk5,datath,pot,height1_point,height,res2,res2)
draw(plot1)
;draw(plot2)
;draw(plot3)
;draw(plot4)
;draw(plot5)
frame(wks1)
;frame(wks2)
;frame(wks3)
;frame(wks4)
;frame(wks5)
delete([/height1_point,height2_point,height3_point,tk1_point,tk2_point,tk3_point,th1_point,th2_point,th3_point,ws1_point,ws2_point,ws3_point,wdir1_point,wdir2_point,wdir3_point,QVPOR1_point,QVPOR2_point,QVPOR3_point/])
delete([/datatk,datath,dataws,datawdir,dataQVAPOR/])
delete([/wks1,plot1/])
end do
end
