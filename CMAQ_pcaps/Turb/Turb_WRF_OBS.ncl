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
csv_filename="./Turb_WRF_OBS_7sites.csv"
header=[/"Time(UTC)"+",H_site1_acm2(WRF)"+",H_site1_acm2(mcip)"+",LH_site1_acm2(WRF)"+",LH_site1_acm2(mcip)"+",ust_site1_acm2(WRF)"+",ust_site1_acm2(mcip)"+",H_site1_ysu(WRF)"+",H_site1_ysu(mcip)"+",LH_site1_ysu(WRF)"+",LH_site1_ysu(mcip)"+",ust_site1_ysu(WRF)"+",ust_site1_ysu(mcip)"+",H_site1_myj(WRF)"+",H_site1_myj(mcip)"+",LH_site1_myj(WRF)"+",LH_site1_myj(mcip)"+",ust_site1_myj(WRF)"+",ust_site1_myj(mcip)"/]
write_table(csv_filename,"w",header,"%s")

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

  H1=f1[:]->HFX
  H11=H1(:,locY1,locX1)
  H12=H1(:,locY2,locX2)
  H13=H1(:,locY3,locX3)
  H14=H1(:,locY4,locX4)
  H15=H1(:,locY5,locX5)
  H16=H1(:,locY6,locX6)
  H17=H1(:,locY7,locX7)

  H2=f2[:]->HFX
  H21=H2(:,locY1,locX1)
  H22=H2(:,locY2,locX2)
  H23=H2(:,locY3,locX3)
  H24=H2(:,locY4,locX4)
  H25=H2(:,locY5,locX5)
  H26=H2(:,locY6,locX6)
  H27=H2(:,locY7,locX7)

  H3=f3[:]->HFX
  H31=H3(:,locY1,locX1)
  H32=H3(:,locY2,locX2)
  H33=H3(:,locY3,locX3)
  H34=H3(:,locY4,locX4)
  H35=H3(:,locY5,locX5)
  H36=H3(:,locY6,locX6)
  H37=H3(:,locY7,locX7)

   H4=f4->HFX
  H41=H4(72:815,0,locY11,locX11)
  H42=H4(72:815,0,locY22,locX22)
  H43=H4(72:815,0,locY33,locX33)
  H44=H4(72:815,0,locY44,locX44)
  H45=H4(72:815,0,locY55,locX55)
  H46=H4(72:815,0,locY66,locX66)
  H47=H4(72:815,0,locY77,locX77)
  H5=f5->HFX
  H51=H5(72:815,0,locY11,locX11)
  H52=H5(72:815,0,locY22,locX22)
  H53=H5(72:815,0,locY33,locX33)
  H54=H5(72:815,0,locY44,locX44)
  H55=H5(72:815,0,locY55,locX55)
  H56=H5(72:815,0,locY66,locX66)
  H57=H5(72:815,0,locY77,locX77)
  H6=f6->HFX
  H61=H6(72:815,0,locY11,locX11)
  H62=H6(72:815,0,locY22,locX22)
  H63=H6(72:815,0,locY33,locX33)
  H64=H6(72:815,0,locY44,locX44)
  H65=H6(72:815,0,locY55,locX55)
  H66=H6(72:815,0,locY66,locX66)
  H67=H6(72:815,0,locY77,locX77)

  LH1=f1[:]->LH
  LH11=LH1(:,locY1,locX1)
  LH12=LH1(:,locY2,locX2)
  LH13=LH1(:,locY3,locX3)
  LH14=LH1(:,locY4,locX4)
  LH15=LH1(:,locY5,locX5)
  LH16=LH1(:,locY6,locX6)
  LH17=LH1(:,locY7,locX7)

  LH2=f2[:]->LH
  LH21=LH2(:,locY1,locX1)
  LH22=LH2(:,locY2,locX2)
  LH23=LH2(:,locY3,locX3)
  LH24=LH2(:,locY4,locX4)
  LH25=LH2(:,locY5,locX5)
  LH26=LH2(:,locY6,locX6)
  LH27=LH2(:,locY7,locX7)

  LH3=f3[:]->LH
  LH31=LH3(:,locY1,locX1)
  LH32=LH3(:,locY2,locX2)
  LH33=LH3(:,locY3,locX3)
  LH34=LH3(:,locY4,locX4)
  LH35=LH3(:,locY5,locX5)
  LH36=LH3(:,locY6,locX6)
  LH37=LH3(:,locY7,locX7)
  LH4=f4->LH
  LH41=LH4(72:815,0,locY11,locX11)
  LH42=LH4(72:815,0,locY22,locX22)
  LH43=LH4(72:815,0,locY33,locX33)
  LH44=LH4(72:815,0,locY44,locX44)
  LH45=LH4(72:815,0,locY55,locX55)
  LH46=LH4(72:815,0,locY66,locX66)
  LH47=LH4(72:815,0,locY77,locX77)
  LH5=f5->LH
  LH51=LH5(72:815,0,locY11,locX11)
  LH52=LH5(72:815,0,locY22,locX22)
  LH53=LH5(72:815,0,locY33,locX33)
  LH54=LH5(72:815,0,locY44,locX44)
  LH55=LH5(72:815,0,locY55,locX55)
  LH56=LH5(72:815,0,locY66,locX66)
  LH57=LH5(72:815,0,locY77,locX77)
  LH6=f6->LH
  LH61=LH6(72:815,0,locY11,locX11)
  LH62=LH6(72:815,0,locY22,locX22)
  LH63=LH6(72:815,0,locY33,locX33)
  LH64=LH6(72:815,0,locY44,locX44)
  LH65=LH6(72:815,0,locY55,locX55)
  LH66=LH6(72:815,0,locY66,locX66)
  LH67=LH6(72:815,0,locY77,locX77)

 ust1=f1[:]->UST
  ust11=ust1(:,locY1,locX1)
  ust12=ust1(:,locY2,locX2)
  ust13=ust1(:,locY3,locX3)
  ust14=ust1(:,locY4,locX4)
  ust15=ust1(:,locY5,locX5)
  ust16=ust1(:,locY6,locX6)
  ust17=ust1(:,locY7,locX7)

  ust2=f2[:]->UST
  ust21=ust2(:,locY1,locX1)
  ust22=ust2(:,locY2,locX2)
  ust23=ust2(:,locY3,locX3)
  ust24=ust2(:,locY4,locX4)
  ust25=ust2(:,locY5,locX5)
  ust26=ust2(:,locY6,locX6)
  ust27=ust2(:,locY7,locX7)

  ust3=f3[:]->UST
  ust31=ust3(:,locY1,locX1)
  ust32=ust3(:,locY2,locX2)
  ust33=ust3(:,locY3,locX3)
  ust34=ust3(:,locY4,locX4)
  ust35=ust3(:,locY5,locX5)
  ust36=ust3(:,locY6,locX6)
  ust37=ust3(:,locY7,locX7)

  ust4=f4->USTAR
  ust41=ust4(72:815,0,locY11,locX11)
  ust42=ust4(72:815,0,locY22,locX22)
  ust43=ust4(72:815,0,locY33,locX33)
  ust44=ust4(72:815,0,locY44,locX44)
  ust45=ust4(72:815,0,locY55,locX55)
  ust46=ust4(72:815,0,locY66,locX66)
  ust47=ust4(72:815,0,locY77,locX77)
  ust5=f5->USTAR
  ust51=ust5(72:815,0,locY11,locX11)
  ust52=ust5(72:815,0,locY22,locX22)
  ust53=ust5(72:815,0,locY33,locX33)
  ust54=ust5(72:815,0,locY44,locX44)
  ust55=ust5(72:815,0,locY55,locX55)
  ust56=ust5(72:815,0,locY66,locX66)
  ust57=ust5(72:815,0,locY77,locX77)
  ust6=f6->USTAR
  ust61=ust6(72:815,0,locY11,locX11)
  ust62=ust6(72:815,0,locY22,locX22)
  ust63=ust6(72:815,0,locY33,locX33)
  ust64=ust6(72:815,0,locY44,locX44)
  ust65=ust6(72:815,0,locY55,locX55)
  ust66=ust6(72:815,0,locY66,locX66)
  ust67=ust6(72:815,0,locY77,locX77)
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
  time=wrf_user_getvar(f1, "times", -1)
  

 alist=[/time,H11,H41,LH11,LH41,ust11,ust41,H21,H51,LH21,LH51,ust21,ust51,H31,H61,LH31,LH61,ust31,ust61/]
format="%s,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g"
write_table(csv_filename, "a", alist, format)


;*********READ OBS FILES**************************
obsname =  "turbulence_pcaps _hourly_FillValue.csv"
obsvars=asciiread(obsname, -1, "string")
delim=","
timemst=str_get_field(obsvars(1::), 2, delim)
print(timemst(744))
obsH1=tofloat(str_get_field(obsvars(1::), 3, delim))
print(obsH1(0))
obsLH1=tofloat(str_get_field(obsvars(1::), 4, delim))
obsust1=tofloat(str_get_field(obsvars(1::), 7, delim))
print(obsLH1(0))
print(obsust1(0))

obsH2=tofloat(str_get_field(obsvars(1::), 8, delim))
print(obsH2(0))
obsLH2=tofloat(str_get_field(obsvars(1::), 9, delim))
obsust2=tofloat(str_get_field(obsvars(1::), 12, delim))

obsH3=tofloat(str_get_field(obsvars(1::), 13, delim))
print(obsH3(0))
obsLH3=tofloat(str_get_field(obsvars(1::), 14, delim))
obsust3=tofloat(str_get_field(obsvars(1::), 17, delim))

obsH4=tofloat(str_get_field(obsvars(1::), 18, delim))
print(obsH4(0))
obsLH4=tofloat(str_get_field(obsvars(1::), 19, delim))
obsust4=tofloat(str_get_field(obsvars(1::), 22, delim))

obsH5=tofloat(str_get_field(obsvars(1::), 23, delim))
print(obsH5(0))
obsLH5=tofloat(str_get_field(obsvars(1::), 24, delim))
obsust5=tofloat(str_get_field(obsvars(1::), 27, delim))

obsH6=tofloat(str_get_field(obsvars(1::), 28, delim))
print(obsH6(0))
obsLH6=tofloat(str_get_field(obsvars(1::), 29, delim))
obsust6=tofloat(str_get_field(obsvars(1::), 32, delim))

obsH7=tofloat(str_get_field(obsvars(1::), 33, delim))
print(obsH7(0))
obsLH7=tofloat(str_get_field(obsvars(1::), 34, delim))
obsust7=tofloat(str_get_field(obsvars(1::), 37, delim))

obsH1@_FillValue = 999
obsLH1@_FillValue = 999
obsust1@_FillValue = 999

obsH2@_FillValue = 999
obsLH2@_FillValue = 999
obsust2@_FillValue = 999

obsH3@_FillValue = 999
obsLH3@_FillValue = 999
obsust3@_FillValue = 999

obsH4@_FillValue = 999
obsLH4@_FillValue = 999
obsust4@_FillValue = 999

obsH5@_FillValue = 999
obsLH5@_FillValue = 999
obsust5@_FillValue = 999

obsH6@_FillValue = 999
obsLH6@_FillValue = 999
obsust6@_FillValue = 999

obsH7@_FillValue = 999
obsLH7@_FillValue = 999
obsust7@_FillValue = 999
;*********READ OBS FILES**************************

;************PLOT RESOURCES*************************************
wks1=gsn_open_wks("png", "H_site1_WRF_OBS_Jan2011")
wks2=gsn_open_wks("png", "LH_site1_WRF_OBS_Jan2011")
wks3=gsn_open_wks("png", "ust_site1_WRF_OBS_Jan2011")



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
res1@tiYAxisString="H (W.m~S~-2~N~)"

res2=res
res2@tiYAxisString="LH (W.m~S~-2~N~)"
res3=res
res3@tiYAxisString="UST (m/s)"
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

dataH1=new((/3,744/),float)
dataH1(0,:)=H31
dataH1(1,:)=H21
dataH1(2,:)=H11
wrfH1=(/H11(:),H21(:),H31(:)/)
maxwrfH1=max(wrfH1)
maxobsH1=max(obsH1(744:1487))
maxwrfobsH1=(/maxwrfH1,maxobsH1/)

minwrfH1=min(wrfH1)
minobsH1=min(obsH1(744:1487))
minwrfobsH1=(/minwrfH1,minobsH1/)

dataLH1=new((/3,744/),float)
dataLH1(0,:)=LH31
dataLH1(1,:)=LH21
dataLH1(2,:)=LH11

wrfLH1=(/LH11(:),LH21(:),LH31(:)/)
maxwrfLH1=max(wrfLH1)
maxobsLH1=max(obsLH1(744:1487))
maxwrfobsLH1=(/maxwrfLH1,maxobsLH1/)

minwrfLH1=min(wrfLH1)
minobsLH1=min(obsLH1(744:1487))
minwrfobsLH1=(/minwrfLH1,minobsLH1/)

dataust1=new((/3,744/),float)
dataust1(0,:)=ust31
dataust1(1,:)=ust21
dataust1(2,:)=ust11
wrfust1=(/ust11(:),ust21(:),ust31(:)/)
maxwrfust1=max(wrfust1)
maxobsust1=max(obsust1(744:1487))
maxwrfobsust1=(/maxwrfust1,maxobsust1/)

minwrfust1=min(wrfust1)
minobsust1=min(obsust1(744:1487))
minwrfobsust1=(/minwrfust1,minobsust1/)

dataH2=new((/3,744/),float)
dataH2(0,:)=H32
dataH2(1,:)=H22
dataH2(2,:)=H12
wrfH2=(/H12(:),H22(:),H32(:)/)
maxwrfH2=max(wrfH2)
maxobsH2=max(obsH2(744:1487))
maxwrfobsH2=(/maxwrfH2,maxobsH2/)

minwrfH2=min(wrfH2)
minobsH2=min(obsH2(744:1487))
minwrfobsH2=(/minwrfH2,minobsH2/)

dataLH2=new((/3,744/),float)
dataLH2(0,:)=LH32
dataLH2(1,:)=LH22
dataLH2(2,:)=LH12

wrfLH2=(/LH12(:),LH22(:),LH32(:)/)
maxwrfLH2=max(wrfLH2)
maxobsLH2=max(obsLH2(744:1487))
maxwrfobsLH2=(/maxwrfLH2,maxobsLH2/)

minwrfLH2=min(wrfLH2)
minobsLH2=min(obsLH2(744:1487))
minwrfobsLH2=(/minwrfLH2,minobsLH2/)

dataust2=new((/3,744/),float)
dataust2(0,:)=ust32
dataust2(1,:)=ust22
dataust2(2,:)=ust12
wrfust2=(/ust12(:),ust22(:),ust32(:)/)
maxwrfust2=max(wrfust2)
maxobsust2=max(obsust2(744:1487))
maxwrfobsust2=(/maxwrfust2,maxobsust2/)

minwrfust2=min(wrfust2)
minobsust2=min(obsust2(744:1487))
minwrfobsust2=(/minwrfust2,minobsust2/)

dataH3=new((/3,744/),float)
dataH3(0,:)=H33
dataH3(1,:)=H23
dataH3(2,:)=H13
wrfH3=(/H13(:),H23(:),H33(:)/)
maxwrfH3=max(wrfH3)
maxobsH3=max(obsH3(744:1487))
maxwrfobsH3=(/maxwrfH3,maxobsH3/)

minwrfH3=min(wrfH3)
minobsH3=min(obsH3(744:1487))
minwrfobsH3=(/minwrfH3,minobsH3/)

dataLH3=new((/3,744/),float)
dataLH3(0,:)=LH33
dataLH3(1,:)=LH23
dataLH3(2,:)=LH13

wrfLH3=(/LH13(:),LH23(:),LH33(:)/)
maxwrfLH3=max(wrfLH3)
maxobsLH3=max(obsLH3(744:1487))
maxwrfobsLH3=(/maxwrfLH3,maxobsLH3/)

minwrfLH3=min(wrfLH3)
minobsLH3=min(obsLH3(744:1487))
minwrfobsLH3=(/minwrfLH3,minobsLH3/)

dataust3=new((/3,744/),float)
dataust3(0,:)=ust33
dataust3(1,:)=ust23
dataust3(2,:)=ust13
wrfust3=(/ust13(:),ust23(:),ust33(:)/)
maxwrfust3=max(wrfust3)
maxobsust3=max(obsust3(744:1487))
maxwrfobsust3=(/maxwrfust3,maxobsust3/)

minwrfust3=min(wrfust3)
minobsust3=min(obsust3(744:1487))
minwrfobsust3=(/minwrfust3,minobsust3/)

dataH4=new((/3,744/),float)
dataH4(0,:)=H34
dataH4(1,:)=H24
dataH4(2,:)=H14
wrfH4=(/H14(:),H24(:),H34(:)/)
maxwrfH4=max(wrfH4)
maxobsH4=max(obsH4(744:1487))
maxwrfobsH4=(/maxwrfH4,maxobsH4/)

minwrfH4=min(wrfH4)
minobsH4=min(obsH4(744:1487))
minwrfobsH4=(/minwrfH4,minobsH4/)

dataLH4=new((/3,744/),float)
dataLH4(0,:)=LH34
dataLH4(1,:)=LH24
dataLH4(2,:)=LH14

wrfLH4=(/LH14(:),LH24(:),LH34(:)/)
maxwrfLH4=max(wrfLH4)
maxobsLH4=max(obsLH4(744:1487))
maxwrfobsLH4=(/maxwrfLH4,maxobsLH4/)

minwrfLH4=min(wrfLH4)
minobsLH4=min(obsLH4(744:1487))
minwrfobsLH4=(/minwrfLH4,minobsLH4/)

dataust4=new((/3,744/),float)
dataust4(0,:)=ust34
dataust4(1,:)=ust24
dataust4(2,:)=ust14
wrfust4=(/ust14(:),ust24(:),ust34(:)/)
maxwrfust4=max(wrfust4)
maxobsust4=max(obsust4(744:1487))
maxwrfobsust4=(/maxwrfust4,maxobsust4/)

minwrfust4=min(wrfust4)
minobsust4=min(obsust4(744:1487))
minwrfobsust4=(/minwrfust4,minobsust4/)

dataH5=new((/3,744/),float)
dataH5(0,:)=H35
dataH5(1,:)=H25
dataH5(2,:)=H15
wrfH5=(/H15(:),H25(:),H35(:)/)
maxwrfH5=max(wrfH5)
maxobsH5=max(obsH5(744:1487))
maxwrfobsH5=(/maxwrfH5,maxobsH5/)

minwrfH5=min(wrfH5)
minobsH5=min(obsH5(744:1487))
minwrfobsH5=(/minwrfH5,minobsH5/)

dataLH5=new((/3,744/),float)
dataLH5(0,:)=LH35
dataLH5(1,:)=LH25
dataLH5(2,:)=LH15

wrfLH5=(/LH15(:),LH25(:),LH35(:)/)
maxwrfLH5=max(wrfLH5)
maxobsLH5=max(obsLH5(744:1487))
maxwrfobsLH5=(/maxwrfLH5,maxobsLH5/)

minwrfLH5=min(wrfLH5)
minobsLH5=min(obsLH5(744:1487))
minwrfobsLH5=(/minwrfLH5,minobsLH5/)

dataust5=new((/3,744/),float)
dataust5(0,:)=ust35
dataust5(1,:)=ust25
dataust5(2,:)=ust15
wrfust5=(/ust15(:),ust25(:),ust35(:)/)
maxwrfust5=max(wrfust5)
maxobsust5=max(obsust5(744:1487))
maxwrfobsust5=(/maxwrfust5,maxobsust5/)

minwrfust5=min(wrfust5)
minobsust5=min(obsust5(744:1487))
minwrfobsust5=(/minwrfust5,minobsust5/)

dataH6=new((/3,744/),float)
dataH6(0,:)=H36
dataH6(1,:)=H26
dataH6(2,:)=H16
wrfH6=(/H16(:),H26(:),H36(:)/)
maxwrfH6=max(wrfH6)
maxobsH6=max(obsH6(744:1487))
maxwrfobsH6=(/maxwrfH6,maxobsH6/)

minwrfH6=min(wrfH6)
minobsH6=min(obsH6(744:1487))
minwrfobsH6=(/minwrfH6,minobsH6/)

dataLH6=new((/3,744/),float)
dataLH6(0,:)=LH36
dataLH6(1,:)=LH26
dataLH6(2,:)=LH16

wrfLH6=(/LH16(:),LH26(:),LH36(:)/)
maxwrfLH6=max(wrfLH6)
maxobsLH6=max(obsLH6(744:1487))
maxwrfobsLH6=(/maxwrfLH6,maxobsLH6/)

minwrfLH6=min(wrfLH6)
minobsLH6=min(obsLH6(744:1487))
minwrfobsLH6=(/minwrfLH6,minobsLH6/)

dataust6=new((/3,744/),float)
dataust6(0,:)=ust36
dataust6(1,:)=ust26
dataust6(2,:)=ust16
wrfust6=(/ust16(:),ust26(:),ust36(:)/)
maxwrfust6=max(wrfust6)
maxobsust6=max(obsust6(744:1487))
maxwrfobsust6=(/maxwrfust6,maxobsust6/)

minwrfust6=min(wrfust6)
minobsust6=min(obsust6(744:1487))
minwrfobsust6=(/minwrfust6,minobsust6/)

dataH7=new((/3,744/),float)
dataH7(0,:)=H37
dataH7(1,:)=H27
dataH7(2,:)=H17
wrfH7=(/H17(:),H27(:),H37(:)/)
maxwrfH7=max(wrfH7)
maxobsH7=max(obsH7(744:1487))
maxwrfobsH7=(/maxwrfH7,maxobsH7/)

minwrfH7=min(wrfH7)
minobsH7=min(obsH7(744:1487))
minwrfobsH7=(/minwrfH7,minobsH7/)

dataLH7=new((/3,744/),float)
dataLH7(0,:)=LH37
dataLH7(1,:)=LH27
dataLH7(2,:)=LH17

wrfLH7=(/LH17(:),LH27(:),LH37(:)/)
maxwrfLH7=max(wrfLH7)
maxobsLH7=max(obsLH7(744:1487))
maxwrfobsLH7=(/maxwrfLH7,maxobsLH7/)

minwrfLH7=min(wrfLH7)
minobsLH7=min(obsLH7(744:1487))
minwrfobsLH7=(/minwrfLH7,minobsLH7/)

dataust7=new((/3,744/),float)
dataust7(0,:)=ust37
dataust7(1,:)=ust27
dataust7(2,:)=ust17
wrfust7=(/ust17(:),ust27(:),ust37(:)/)
maxwrfust7=max(wrfust7)
maxobsust7=max(obsust7(744:1487))
maxwrfobsust7=(/maxwrfust7,maxobsust7/)

minwrfust7=min(wrfust7)
minobsust7=min(obsust7(744:1487))
minwrfobsust7=(/minwrfust7,minobsust7/)

ctime=wrf_times_c(f1[:]->Times,0)
utahtime=ctime-7 ;MST time

res@trXMinF=utahtime(0)
res@trXMaxF=utahtime(743)

copy_VarAtts(ctime, utahtime)
res11=res1
res11@trXMinF=utahtime(0)
res11@trXMaxF=utahtime(743)
res11@trYMinF=min(minwrfobsH1)-10.0
res11@trYMaxF=max(maxwrfobsH1)+10.0
resobs11=resobs
resobs11@trXMinF=utahtime(0)
resobs11@trXMaxF=utahtime(743)
resobs11@trYMinF=min(minwrfobsH1)-10.0
resobs11@trYMaxF=max(maxwrfobsH1)+10.0
res12=res2
res12@trXMinF=utahtime(0)
res12@trXMaxF=utahtime(743)
res12@trYMinF=min(minwrfobsLH1)-10.0
res12@trYMaxF=max(maxwrfobsLH1)+10.0
resobs12=resobs
resobs12@trXMinF=utahtime(0)
resobs12@trXMaxF=utahtime(743)
resobs12@trYMinF=min(minwrfobsLH1)-10.0
resobs12@trYMaxF=max(maxwrfobsLH1)+10.0
res13=res3
res13@trXMinF=utahtime(0)
res13@trXMaxF=utahtime(743)
res13@trYMinF=min(minwrfobsust1)-0.1
res13@trYMaxF=max(maxwrfobsust1)+0.1
resobs13=resobs
resobs13@trXMinF=utahtime(0)
resobs13@trXMaxF=utahtime(743)
resobs13@trYMinF=min(minwrfobsust1)-0.1
resobs13@trYMaxF=max(maxwrfobsust1)+0.1

res21=res1
res21@trXMinF=utahtime(0)
res21@trXMaxF=utahtime(743)
res21@trYMinF=min(minwrfobsH2)-10.0
res21@trYMaxF=max(maxwrfobsH2)+10.0
resobs21=resobs
resobs21@trXMinF=utahtime(0)
resobs21@trXMaxF=utahtime(743)
resobs21@trYMinF=min(minwrfobsH2)-10.0
resobs21@trYMaxF=max(maxwrfobsH2)+10.0
res22=res2
res22@trXMinF=utahtime(0)
res22@trXMaxF=utahtime(743)
res22@trYMinF=min(minwrfobsLH2)-10.0
res22@trYMaxF=max(maxwrfobsLH2)+10.0
resobs22=resobs
resobs22@trXMinF=utahtime(0)
resobs22@trXMaxF=utahtime(743)
resobs22@trYMinF=min(minwrfobsLH2)-10.0
resobs22@trYMaxF=max(maxwrfobsLH2)+10.0
res23=res3
res23@trXMinF=utahtime(0)
res23@trXMaxF=utahtime(743)
res23@trYMinF=min(minwrfobsust2)-0.1
res23@trYMaxF=max(maxwrfobsust2)+0.1
resobs23=resobs
resobs23@trXMinF=utahtime(0)
resobs23@trXMaxF=utahtime(743)
resobs23@trYMinF=min(minwrfobsust2)-0.1
resobs23@trYMaxF=max(maxwrfobsust2)+0.1

res31=res1
res31@trXMinF=utahtime(0)
res31@trXMaxF=utahtime(743)
res31@trYMinF=min(minwrfobsH3)-10.0
res31@trYMaxF=max(maxwrfobsH3)+10.0
resobs31=resobs
resobs31@trXMinF=utahtime(0)
resobs31@trXMaxF=utahtime(743)
resobs31@trYMinF=min(minwrfobsH3)-10.0
resobs31@trYMaxF=max(maxwrfobsH3)+10.0
res32=res2
res32@trXMinF=utahtime(0)
res32@trXMaxF=utahtime(743)
res32@trYMinF=min(minwrfobsLH3)-10.0
res32@trYMaxF=max(maxwrfobsLH3)+10.0
resobs32=resobs
resobs32@trXMinF=utahtime(0)
resobs32@trXMaxF=utahtime(743)
resobs32@trYMinF=min(minwrfobsLH3)-10.0
resobs32@trYMaxF=max(maxwrfobsLH3)+10.0
res33=res3
res33@trXMinF=utahtime(0)
res33@trXMaxF=utahtime(743)
res33@trYMinF=min(minwrfobsust3)-0.1
res33@trYMaxF=max(maxwrfobsust3)+0.1
resobs33=resobs
resobs33@trXMinF=utahtime(0)
resobs33@trXMaxF=utahtime(743)
resobs33@trYMinF=min(minwrfobsust3)-0.1
resobs33@trYMaxF=max(maxwrfobsust3)+0.1

res41=res1
res41@trXMinF=utahtime(0)
res41@trXMaxF=utahtime(743)
res41@trYMinF=min(minwrfobsH4)-10.0
res41@trYMaxF=max(maxwrfobsH4)+10.0
resobs41=resobs
resobs41@trXMinF=utahtime(0)
resobs41@trXMaxF=utahtime(743)
resobs41@trYMinF=min(minwrfobsH4)-10.0
resobs41@trYMaxF=max(maxwrfobsH4)+10.0
res42=res2
res42@trXMinF=utahtime(0)
res42@trXMaxF=utahtime(743)
res42@trYMinF=min(minwrfobsLH4)-10.0
res42@trYMaxF=max(maxwrfobsLH4)+10.0
resobs42=resobs
resobs42@trXMinF=utahtime(0)
resobs42@trXMaxF=utahtime(743)
resobs42@trYMinF=min(minwrfobsLH4)-10.0
resobs42@trYMaxF=max(maxwrfobsLH4)+10.0
res43=res3
res43@trXMinF=utahtime(0)
res43@trXMaxF=utahtime(743)
res43@trYMinF=min(minwrfobsust4)-0.1
res43@trYMaxF=max(maxwrfobsust4)+0.1
resobs43=resobs
resobs43@trXMinF=utahtime(0)
resobs43@trXMaxF=utahtime(743)
resobs43@trYMinF=min(minwrfobsust4)-0.1
resobs43@trYMaxF=max(maxwrfobsust4)+0.1

res51=res1
res51@trXMinF=utahtime(0)
res51@trXMaxF=utahtime(743)
res51@trYMinF=min(minwrfobsH5)-10.0
res51@trYMaxF=max(maxwrfobsH5)+10.0
resobs51=resobs
resobs51@trXMinF=utahtime(0)
resobs51@trXMaxF=utahtime(743)
resobs51@trYMinF=min(minwrfobsH5)-10.0
resobs51@trYMaxF=max(maxwrfobsH5)+10.0
res52=res2
res52@trXMinF=utahtime(0)
res52@trXMaxF=utahtime(743)
res52@trYMinF=min(minwrfobsLH5)-10.0
res52@trYMaxF=max(maxwrfobsLH5)+10.0
resobs52=resobs
resobs52@trXMinF=utahtime(0)
resobs52@trXMaxF=utahtime(743)
resobs52@trYMinF=min(minwrfobsLH5)-10.0
resobs52@trYMaxF=max(maxwrfobsLH5)+10.0
res53=res3
res53@trXMinF=utahtime(0)
res53@trXMaxF=utahtime(743)
res53@trYMinF=min(minwrfobsust5)-0.1
res53@trYMaxF=max(maxwrfobsust5)+0.1
resobs53=resobs
resobs53@trXMinF=utahtime(0)
resobs53@trXMaxF=utahtime(743)
resobs53@trYMinF=min(minwrfobsust5)-0.1
resobs53@trYMaxF=max(maxwrfobsust5)+0.1

res61=res1
res61@trXMinF=utahtime(0)
res61@trXMaxF=utahtime(743)
res61@trYMinF=min(minwrfobsH6)-10.0
res61@trYMaxF=max(maxwrfobsH6)+10.0
resobs61=resobs
resobs61@trXMinF=utahtime(0)
resobs61@trXMaxF=utahtime(743)
resobs61@trYMinF=min(minwrfobsH6)-10.0
resobs61@trYMaxF=max(maxwrfobsH6)+10.0
res62=res2
res62@trXMinF=utahtime(0)
res62@trXMaxF=utahtime(743)
res62@trYMinF=min(minwrfobsLH6)-10.0
res62@trYMaxF=max(maxwrfobsLH6)+10.0
resobs62=resobs
resobs62@trXMinF=utahtime(0)
resobs62@trXMaxF=utahtime(743)
resobs62@trYMinF=min(minwrfobsLH6)-10.0
resobs62@trYMaxF=max(maxwrfobsLH6)+10.0
res63=res3
res63@trXMinF=utahtime(0)
res63@trXMaxF=utahtime(743)
res63@trYMinF=min(minwrfobsust6)-0.1
res63@trYMaxF=max(maxwrfobsust6)+0.1
resobs63=resobs
resobs63@trXMinF=utahtime(0)
resobs63@trXMaxF=utahtime(743)
resobs63@trYMinF=min(minwrfobsust6)-0.1
resobs63@trYMaxF=max(maxwrfobsust6)+0.1

res71=res1
res71@trXMinF=utahtime(0)
res71@trXMaxF=utahtime(743)
res71@trYMinF=min(minwrfobsH7)-10.0
res71@trYMaxF=max(maxwrfobsH7)+10.0
resobs71=resobs
resobs71@trXMinF=utahtime(0)
resobs71@trXMaxF=utahtime(743)
resobs71@trYMinF=min(minwrfobsH7)-10.0
resobs71@trYMaxF=max(maxwrfobsH7)+10.0
res72=res2
res72@trXMinF=utahtime(0)
res72@trXMaxF=utahtime(743)
res72@trYMinF=min(minwrfobsLH7)-10.0
res72@trYMaxF=max(maxwrfobsLH7)+10.0
resobs72=resobs
resobs72@trXMinF=utahtime(0)
resobs72@trXMaxF=utahtime(743)
resobs72@trYMinF=min(minwrfobsLH7)-10.0
resobs72@trYMaxF=max(maxwrfobsLH7)+10.0
res73=res3
res73@trXMinF=utahtime(0)
res73@trXMaxF=utahtime(743)
res73@trYMinF=min(minwrfobsust7)-0.1
res73@trYMaxF=max(maxwrfobsust7)+0.1
resobs73=resobs
resobs73@trXMinF=utahtime(0)
resobs73@trXMaxF=utahtime(743)
resobs73@trYMinF=min(minwrfobsust7)-0.1
resobs73@trYMaxF=max(maxwrfobsust7)+0.1
restick=True
restick@ttmFormat="%D-%c"
time_axis_labels(utahtime, res11, restick)
time_axis_labels(utahtime, res12, restick)
time_axis_labels(utahtime, res13, restick)

time_axis_labels(utahtime, res21, restick)
time_axis_labels(utahtime, res22, restick)
time_axis_labels(utahtime, res23, restick)

time_axis_labels(utahtime, res31, restick)
time_axis_labels(utahtime, res32, restick)
time_axis_labels(utahtime, res33, restick)

time_axis_labels(utahtime, res41, restick)
time_axis_labels(utahtime, res42, restick)
time_axis_labels(utahtime, res43, restick)

time_axis_labels(utahtime, res51, restick)
time_axis_labels(utahtime, res52, restick)
time_axis_labels(utahtime, res53, restick)

time_axis_labels(utahtime, res61, restick)
time_axis_labels(utahtime, res62, restick)
time_axis_labels(utahtime, res63, restick)

time_axis_labels(utahtime, res71, restick)
time_axis_labels(utahtime, res72, restick)
time_axis_labels(utahtime, res73, restick)


;plot1=gsn_csm_xy(wks1,utahtime,dataH1,res1)
plot1=gsn_csm_xy2(wks1,utahtime,dataH1,obsH1(744:1487),res11,resobs11)
plot2=gsn_csm_xy2(wks2,utahtime,dataLH1,obsLH1(744:1487),res12,resobs12)
plot3=gsn_csm_xy2(wks3,utahtime,dataust1,obsust1(744:1487),res13,resobs13)
draw(plot1)
frame(wks1)
draw(plot2)
frame(wks2)
draw(plot3)
frame(wks3)

delete([/wks1,wks2,wks3/])
wks12=gsn_open_wks("png", "H_site2_WRF_OBS_Jan2011")
wks22=gsn_open_wks("png", "LH_site2_WRF_OBS_Jan2011")
wks32=gsn_open_wks("png", "ust_site2_WRF_OBS_Jan2011")

plot12=gsn_csm_xy2(wks12,utahtime,dataH2,obsH2(744:1487),res21,resobs21)
plot22=gsn_csm_xy2(wks22,utahtime,dataLH2,obsLH2(744:1487),res22,resobs22)
plot32=gsn_csm_xy2(wks32,utahtime,dataust2,obsust2(744:1487),res23,resobs23)
draw(plot12)
frame(wks12)
draw(plot22)
frame(wks22)
draw(plot32)
frame(wks32)
delete([/wks12,wks22,wks32/])
wks13=gsn_open_wks("png", "H_site3_WRF_OBS_Jan2011")
wks23=gsn_open_wks("png", "LH_site3_WRF_OBS_Jan2011")
wks33=gsn_open_wks("png", "ust_site3_WRF_OBS_Jan2011")
plot13=gsn_csm_xy2(wks13,utahtime,dataH3,obsH3(744:1487),res31,resobs31)
plot23=gsn_csm_xy2(wks23,utahtime,dataLH3,obsLH3(744:1487),res32,resobs32)
plot33=gsn_csm_xy2(wks33,utahtime,dataust3,obsust3(744:1487),res33,resobs33)
draw(plot13)
frame(wks13)
draw(plot23)
frame(wks23)
draw(plot33)
frame(wks33)
delete([/wks13,wks23,wks33/])
wks14=gsn_open_wks("png", "H_site4_WRF_OBS_Jan2011")
wks24=gsn_open_wks("png", "LH_site4_WRF_OBS_Jan2011")
wks34=gsn_open_wks("png", "ust_site4_WRF_OBS_Jan2011")

plot14=gsn_csm_xy2(wks14,utahtime,dataH4,obsH4(744:1487),res41,resobs41)
plot24=gsn_csm_xy2(wks24,utahtime,dataLH4,obsLH4(744:1487),res42,resobs42)
plot34=gsn_csm_xy2(wks34,utahtime,dataust4,obsust4(744:1487),res43,resobs43)
draw(plot14)
frame(wks14)
draw(plot24)
frame(wks24)
draw(plot34)
frame(wks34)
delete([/wks14,wks24,wks34/])
wks15=gsn_open_wks("png", "H_site5_WRF_OBS_Jan2011")
wks25=gsn_open_wks("png", "LH_site5_WRF_OBS_Jan2011")
wks35=gsn_open_wks("png", "ust_site5_WRF_OBS_Jan2011")
plot15=gsn_csm_xy2(wks15,utahtime,dataH5,obsH5(744:1487),res51,resobs51)
plot25=gsn_csm_xy2(wks25,utahtime,dataLH5,obsLH5(744:1487),res52,resobs52)
plot35=gsn_csm_xy2(wks35,utahtime,dataust5,obsust5(744:1487),res53,resobs53)
draw(plot15)
frame(wks15)
draw(plot25)
frame(wks25)
draw(plot35)
frame(wks35)
delete([/wks15,wks25,wks35/])
wks16=gsn_open_wks("png", "H_site6_WRF_OBS_Jan2011")
wks26=gsn_open_wks("png", "LH_site6_WRF_OBS_Jan2011")
wks36=gsn_open_wks("png", "ust_site6_WRF_OBS_Jan2011")
plot16=gsn_csm_xy2(wks16,utahtime,dataH6,obsH6(744:1487),res61,resobs61)
plot26=gsn_csm_xy2(wks26,utahtime,dataLH6,obsLH6(744:1487),res62,resobs62)
plot36=gsn_csm_xy2(wks36,utahtime,dataust6,obsust6(744:1487),res63,resobs63)
draw(plot16)
frame(wks16)
draw(plot26)
frame(wks26)
draw(plot36)
frame(wks36)
delete([/wks16,wks26,wks36/])
wks17=gsn_open_wks("png", "H_site7_WRF_OBS_Jan2011")
wks27=gsn_open_wks("png", "LH_site7_WRF_OBS_Jan2011")
wks37=gsn_open_wks("png", "ust_site7_WRF_OBS_Jan2011")
plot17=gsn_csm_xy2(wks17,utahtime,dataH7,obsH7(744:1487),res71,resobs71)
plot27=gsn_csm_xy2(wks27,utahtime,dataLH7,obsLH7(744:1487),res72,resobs72)
plot37=gsn_csm_xy2(wks37,utahtime,dataust7,obsust7(744:1487),res73,resobs73)
draw(plot17)
frame(wks17)
draw(plot27)
frame(wks27)
draw(plot37)
frame(wks37)
delete([/wks17,wks27,wks37/])
;************PLOT RESOURCES*************************************
end
