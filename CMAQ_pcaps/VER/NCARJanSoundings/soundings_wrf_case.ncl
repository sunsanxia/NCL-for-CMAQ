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
datename="/data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/NCARJanSoundings/NCARJanSounding_case.csv"
delim=","
vars=asciiread(datename, -1, "string")
obsname=str_get_field(vars(1::), 1, delim)
print(obsname)
obsdate=tointeger(str_get_field(vars(1::), 2, delim))
print(obsdate)
obstime=tointeger(str_get_field(vars(1::), 3, delim))
print(obstime)
wrfname=str_get_field(vars(1::), 4, delim)
wrftime=tointeger(str_get_field(vars(1::), 5, delim))
ncarlat=40.6006
ncarlon=-111.9252 
f0=addfile("/data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/wrfoutJan/ACM2/wrfout_d02_2011-01-01_00:00:00", "r")
 llres = True
  llres@ReturnInt = True ; Return integer values
    locij1 = wrf_user_ll_to_ij(f0, ncarlon, ncarlat, llres)
  locij1 = locij1 -1
  locX = locij1(0)
  locY = locij1(1)

  res=True
  res@pmLegendDisplayMode = "Always"
  res@gsnMaximize = True
res@gsnDraw=False
res@xyDashPattern=0
res@xyMarkLineMode="MarkLines"
res@xyMarkers=(/4,4,4/)
res@xyMarkerColors=(/"green","blue","red"/)
res@tiYAxisString="Height (km)"
res@xyExplicitLegendLabels = (/"NAM_MYJ","NAM_YSU","NAM_ACM2"/)
res@xyLineColors=(/"green","blue","red"/)
res@xyLineThicknessF=5
res@trYMinF=1.2
res@trYMaxF=3.0
res@lgPerimOn = False
res@lgLabelFontHeightF=0.02
res@lgBoxMinorExtentF=0.1
res@pmLegendHeightF=0.085
res@pmLegendParallelPosF=0.8
res@pmLegendOrthogonalPosF=-1.15
;res@pmLegendWidthF = 0.4
  ;res@lgPerimOn = False  ;turn off box around

;res@tiMainString=nobsname
res1=res
res1@tiXAxisString="T (k)"
;res1@trXMinF=248   
;res1@trXMaxF=268
resobs=True
resobs@gsnMaximize = True
 resobs@pmLegendDisplayMode = "Always"
resobs@xyExplicitLegendLabels = (/"OBS"/)
resobs@xyLineColor="black"
resobs@trYMinF=1.2
resobs@trYMaxF=3.0
resobs@lgPerimOn = False
resobs@lgLabelFontHeightF=0.02
resobs@lgBoxMinorExtentF=0.1
resobs@pmLegendHeightF=0.06
resobs@pmLegendParallelPosF=0.72
resobs@pmLegendOrthogonalPosF=-0.88
resobs@xyMarkLineMode="Markers"
resobs@xyMarker=16
resobs@xyMarkerColor="black"
;resobs@pmLegendWidthF = 0.04
res11=resobs
;res11@trXMinF=248   
;res11@trXMaxF=268


res2=res
res2@tiXAxisString="POT (k)"
;res2@trXMinF=260    
;res2@trXMaxF=290
res22=resobs
;res22@trXMinF=260    
;res22@trXMaxF=290
res3=res
res3@tiXAxisString="WS (m/s)"
res3@trXMinF=0   
res3@trXMaxF=16
res33=resobs
res33@trXMinF=0   
res33@trXMaxF=16
res4=res
res4@tiXAxisString="Wdir (deg)"
res4@trXMinF=0   
res4@trXMaxF=360
res44=resobs
res44@trXMinF=0   
res44@trXMaxF=360
res5=res
res5@tiXAxisString="Qv (g/kg)"
;res5@trXMinF=0.4   
;res5@trXMaxF=2.0
res55=resobs
;res55@trXMinF=0.4   
;res55@trXMaxF=2.0

do i=0,65,1
  f1=addfile("/data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/wrfoutJan/ACM2/"+wrfname(i), "r")
  f2=addfile("/data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/wrfoutJan/YSU/"+wrfname(i), "r")
  f3=addfile("/data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/wrfoutJan/MYJ/"+wrfname(i), "r")
  height1=wrf_user_getvar(f1, "height", -1)
  height2=wrf_user_getvar(f2, "height", -1)
  height3=wrf_user_getvar(f3, "height", -1)
  nheight1=height1(wrftime(i),:,locY,locX)*0.001
  nheight2=height2(wrftime(i),:,locY,locX)*0.001
   nheight3=height3(wrftime(i),:,locY,locX)*0.001
   print(nheight1)
time1=wrf_user_getvar(f1,"times",-1)
print(time1(wrftime(i)))

tk1=wrf_user_getvar(f1, "tk", -1)
tk2=wrf_user_getvar(f2, "tk", -1)
tk3=wrf_user_getvar(f3, "tk", -1)

ntk1=tk1(wrftime(i),:,locY,locX)
ntk2=tk2(wrftime(i),:,locY,locX)
ntk3=tk3(wrftime(i),:,locY,locX)
print(ntk1)

th1=wrf_user_getvar(f1, "th", -1)
th2=wrf_user_getvar(f2, "th", -1)
th3=wrf_user_getvar(f3, "th", -1)

nth1=th1(wrftime(i),:,locY,locX)
nth2=th2(wrftime(i),:,locY,locX)
nth3=th3(wrftime(i),:,locY,locX)

ua1=wrf_user_getvar(f1, "ua", -1)
ua2=wrf_user_getvar(f2, "ua", -1)
ua3=wrf_user_getvar(f3, "ua", -1)

nua1=ua1(wrftime(i),:,locY,locX)
nua2=ua2(wrftime(i),:,locY,locX)
nua3=ua3(wrftime(i),:,locY,locX)

va1=wrf_user_getvar(f1, "va", -1)
va2=wrf_user_getvar(f2, "va", -1)
va3=wrf_user_getvar(f3, "va", -1)

nva1=va1(wrftime(i),:,locY,locX)
nva2=va2(wrftime(i),:,locY,locX)
nva3=va3(wrftime(i),:,locY,locX)

nws1=sqrt(nua1^2+nva1^2)
nws2=sqrt(nua2^2+nva2^2)
nws3=sqrt(nua3^2+nva3^2)

nwdir1=wind_direction(nua1, nva1, 0)
nwdir2=wind_direction(nua2, nva2, 0)
nwdir3=wind_direction(nua3, nva3, 0)

 QVAPOR1=wrf_user_getvar(f1, "QVAPOR", -1)
QVAPOR2=wrf_user_getvar(f2, "QVAPOR", -1)
QVAPOR3=wrf_user_getvar(f3, "QVAPOR", -1)

nQVAPOR1=1000.0*QVAPOR1(wrftime(i),:,locY,locX)  ;model output is kg/kg, multiple by 1000, unit is converted to g/kg now
nQVAPOR2=1000.0*QVAPOR2(wrftime(i),:,locY,locX)
nQVAPOR3=1000.0*QVAPOR3(wrftime(i),:,locY,locX)

    nobsname=obsname(i)
    nobsvars=asciiread(nobsname, -1, "string")
    delim = " "
    wks1=gsn_open_wks("png","./T"+obsname(i))
    print(nobsname)
    wks2=gsn_open_wks("png","./WS"+obsname(i))
    wks3=gsn_open_wks("png","./Qv"+obsname(i))
    wks4=gsn_open_wks("png","./Wdir"+obsname(i))
    wks5=gsn_open_wks("png","./th"+obsname(i))
    res1@tiMainString=nobsname
  height=tofloat(str_get_field(nobsvars(8::), 1, delim))*0.001
tmp = tofloat(str_get_field(nobsvars(8::), 3, delim))+273.15
mx=tofloat(str_get_field(nobsvars(8::), 6, delim))
pot=tofloat(str_get_field(nobsvars(8::), 9, delim))
ws=tofloat(str_get_field(nobsvars(8::), 12, delim))
wdir=tofloat(str_get_field(nobsvars(8::), 13, delim))
print(height(0))
print(tmp(0))
print(mx(0))

maxtmpobs=max(tmp(0:169))
mintmpobs=min(tmp(0:169))
print(maxtmpobs)
maxtmpwrf=max(ntk1(0:28))
mintmpwrf=min(ntk1(0:28))
print(maxtmpwrf)
max_tmp=(/maxtmpobs,maxtmpwrf/)
min_tmp=(/mintmpobs,mintmpwrf/)
res1@trXMaxF=max(max_tmp)+2
res1@trXMinF=min(min_tmp)-2
res11@trXMaxF=max(max_tmp)+2
res11@trXMinF=min(min_tmp)-2

maxpotobs=max(pot(0:169))
minpotobs=min(pot(0:169))
print(maxpotobs)
maxpotwrf=max(nth1(0:28))
minpotwrf=min(nth1(0:28))
print(maxpotwrf)
max_pot=(/maxpotobs,maxpotwrf/)
min_pot=(/minpotobs,minpotwrf/)
res2@trXMaxF=max(max_pot)+2
res2@trXMinF=min(min_pot)-2
res22@trXMaxF=max(max_pot)+2
res22@trXMinF=min(min_pot)-2

maxmxobs=max(mx(0:169))
minmxobs=min(mx(0:169))
print(maxmxobs)
maxmxwrf=max(nQVAPOR1(0:28))
minmxwrf=min(nQVAPOR1(0:28))
print(maxmxwrf)
max_mx=(/maxmxobs,maxmxwrf/)
min_mx=(/minmxobs,minmxwrf/)
res5@trXMaxF=max(max_mx)+0.1
res5@trXMinF=min(min_mx)-0.1
res55@trXMaxF=max(max_mx)+0.1
res55@trXMinF=min(min_mx)-0.1

datatk=new((/3,41/),float)
datatk(0,0:40)=ntk3
datatk(1,0:40)=ntk2
datatk(2,0:40)=ntk1


datath=new((/3,41/),float)
datath(0,:)=nth3
datath(1,:)=nth2
datath(2,:)=nth1


dataws=new((/3,41/),float)
dataws(0,:)=nws3
dataws(1,:)=nws2
dataws(2,:)=nws1


datawdir=new((/3,41/),float)
datawdir(0,:)=nwdir3
datawdir(1,:)=nwdir2
datawdir(2,:)=nwdir1


dataQVAPOR=new((/3,41/),float)
dataQVAPOR(0,:)=nQVAPOR3
dataQVAPOR(1,:)=nQVAPOR2
dataQVAPOR(2,:)=nQVAPOR1

;plot1=gsn_csm_xy(wks1,datatk,nheight1,res1)
plot1=gsn_csm_x2y2(wks1,datatk,tmp,nheight1,height,res1,res11)
plot2=gsn_csm_x2y2(wks2,dataws,ws,nheight1,height,res3,res33)
plot3=gsn_csm_x2y2(wks3,dataQVAPOR,mx,nheight1,height,res5,res55)
plot4=gsn_csm_x2y2(wks4,datawdir,wdir,nheight1,height,res4,res44)
plot5=gsn_csm_x2y2(wks5,datath,pot,nheight1,height,res2,res22)
draw(plot1)
draw(plot2)
draw(plot3)
draw(plot4)
draw(plot5)
frame(wks1)
frame(wks2)
frame(wks3)
frame(wks4)
frame(wks5)
delete([/height1,height2,height3,nheight1,nheight2,nheight3,tk1,tk2,tk3,ntk1,ntk2,ntk3,th1,th2,th3,nth1,nth2,nth3,nws1,nws2,nws3,nwdir1,nwdir2,nwdir3,QVAPOR1,QVAPOR2,QVAPOR3,nQVAPOR1,nQVAPOR2,nQVAPOR3/])
delete([/datatk,datath,dataws,datawdir,dataQVAPOR/])
delete([/wks1,plot1/])
end do
end
