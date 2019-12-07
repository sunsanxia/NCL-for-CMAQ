
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
begin
;---------------------------------------------------------------------
fils1 = systemfunc("ls /data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/wrfoutJan/ACM2/wrfout_d02*")
f1 = addfiles(fils1,"r")
fils2 = systemfunc("ls /data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/wrfoutJan/YSU/wrfout_d02*")
f2 = addfiles(fils2,"r")
fils3 = systemfunc("ls /data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/wrfoutJan/MYJ/wrfout_d02*")
f3 = addfiles(fils3,"r")
fils4 = systemfunc("ls /data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/wrfoutJan/MYNN/wrfout_d02*")
f4 = addfiles(fils4,"r")
;----------------------------------------------------------------------------
 ; lat1 = 40.6006  ;NCAR location
 ; lon1 = -111.9252
 ; lat1 = 40.77250  ;KSLC location
  ;lon1 = -111.95472
  lat1=40.7364  ;HW location
lon1=-111.872
 ;lat1 = 40.779
 ; lon1 = -112.103
  llres = True
  llres@ReturnInt = True ; Return integer values
  locij = wrf_user_ll_to_ij(f1, lon1, lat1, llres)
  locij = locij -1
  locX = locij(0)
  locY = locij(1)
 XLAT=f1[:]->XLAT(0,locY,locX)
XLONG=f1[:]->XLONG(0,locY,locX)
 print(locX)
print(locY)
print(XLAT)
print(XLONG)
Ricrit=0.25
interheight11=0.0
interheight22=0.0
interheight33=0.0
interheight44=0.0

;------------------------------------------------------------------------------
;  th = wrf_user_getvar(f2, "th", -1)
;height = wrf_user_getvar(f2, "z", -1)
;th = wrf_user_getvar(f1, "th", -1)
;height = wrf_user_getvar(f1, "z", -1)
; th = wrf_user_getvar(f3, "th", -1)
; height = wrf_user_getvar(f3, "z", -1)
;th = wrf_user_getvar(f4, "th", -1)
;height = wrf_user_getvar(f4, "z", -1)
 ;th = wrf_user_getvar(f5, "th", -1)
 ;height = wrf_user_getvar(f5, "z", -1)
 
 ;height = wrf_user_getvar(f6, "z", -1)
 ;HGT = f3->HGT(44,locY,locX)  ; HGT at 54 times
 ;ZNWW = f1->ZNW(0,:) ;eta whole levels
 csv_filename = "./WRF_GRi_PBL_HW.csv"
 ;header = [/"ntime(UTC)"+",ACM2(No-nudge)"+",ACM2"+",ACM2(NARR)"+",ACM2*"+",YSU*"+",MYJ*"+",YSU*(NARR)"+",MYJ*(NARR)"/]
header = [/"ntime(UTC)"+",ACM2"+",YSU"+",MYJ"+",MYNN"/]
system("rm -rf" + csv_filename)
write_table(csv_filename, "w", header, "%s")
time=wrf_user_getvar(f2, "times", -1)
 do i=0,744,1  ;timestamp
  times=time(i)
  ;time = wrf_user_getvar(f2, "times",i)
  
   height1 = wrf_user_getvar(f1, "height", i)
  ; baseheight = f1->HGT(i,0,locY,locX)
   baseheight1 = height1(0,locY,locX)
   t1 = wrf_user_getvar(f1, "tk", i)
   qv1=wrf_user_getvar(f1, "QVAPOR", i)
   vt1=wrf_virtual_temp(t1, qv1)
 ua1=wrf_user_getvar(f1, "ua", i)
   va1=wrf_user_getvar(f1, "va", i)
   ws1=sqrt(ua1^2+va1^2)

   vts1=vt1(0,locY,locX)        ;lowest level virtual potential temperature
   wss1=ws1(0,locY,locX)        ;lowest level wind speed , fixed value
    uaa1=ua1(0,locY,locX)
    vaa1=va1(0,locY,locX)
   th1 = wrf_user_getvar(f1, "th", i)
  ;print(height)
   print(baseheight1)
    th_base1 = th1(0,locY,locX)
    th_crite1 = th_base1+1.5   ;one of the popular mixing height definitions 
   ;do j=1,4000,1
thv1=th1*(1.0+0.61*qv1)
thvs1=thv1(0,locY,locX)
;vtk1=temp_virtual(t1,qv1,(/1,0,1/))


     interheight1= baseheight1+10
      ws_plane1= wrf_user_intrp3d(ws1, height1, "h", interheight1, 0., False)
      ua_plane1=wrf_user_intrp3d(ua1, height1, "h", interheight1, 0., False)
      va_plane1=wrf_user_intrp3d(va1, height1, "h", interheight1, 0., False)
     vt_plane1=wrf_user_intrp3d(vt1, height1, "h", interheight1, 0., False)
    ws_point1=ws_plane1(locY,locX)
    vt_point1=vt_plane1(locY,locX)
    ua_point1=ua_plane1(locY,locX)
    va_point1=va_plane1(locY,locX)
thv_plane1=wrf_user_intrp3d(thv1, height1, "h", interheight1, 0., False)
    thv_point1=thv_plane1(locY,locX)

uvgradient_base1=(ua_point1-uaa1)^2+(va_point1-vaa1)^2
Ri1=9.8/vt_point1*(thv_point1-thvs1)/(interheight1-baseheight1)/uvgradient_base1

    th_plane1 = wrf_user_intrp3d(th1,height1, "h", interheight1, 0., False)
    th_point1 = th_plane1(locY,locX)


   
   height2 = wrf_user_getvar(f2, "height", i)
  ; baseheight = f2->HGT(i,0,locY,locX)
   baseheight2 = height2(0,locY,locX)


   th2 = wrf_user_getvar(f2, "th", i)
  ;print(height)
   print(baseheight2)
    th_base2 = th2(0,locY,locX)
    th_crite2 = th_base2+1.5   ;one of the popular mixing height definitions 
   ;do j=1,4000,1

t2 = wrf_user_getvar(f2, "tk", i)
   qv2=wrf_user_getvar(f2, "QVAPOR", i)
   vt2=wrf_virtual_temp(t2, qv2)
 ua2=wrf_user_getvar(f2, "ua", i)
   va2=wrf_user_getvar(f2, "va", i)
   ws2=sqrt(ua2^2+va2^2)

   vts2=vt2(0,locY,locX)        ;lowest level virtual potential temperature
   wss2=ws2(0,locY,locX)        ;lowest level wind speed , fixed value
thv2=th2*(1.0+0.61*qv2)
thvs2=thv2(0,locY,locX)
uaa2=ua2(0,locY,locX)
    vaa2=va2(0,locY,locX)

     interheight2= baseheight2+10
    th_plane2 = wrf_user_intrp3d(th2,height2, "h", interheight2, 0., False)
    th_point2 = th_plane2(locY,locX)

ws_plane2= wrf_user_intrp3d(ws2, height2, "h", interheight2, 0., False)
ua_plane2=wrf_user_intrp3d(ua2, height2, "h", interheight2, 0., False)
      va_plane2=wrf_user_intrp3d(va2, height2, "h", interheight2, 0., False)
     vt_plane2=wrf_user_intrp3d(vt2, height2, "h", interheight2, 0., False)
     ua_point2=ua_plane2(locY,locX)
    va_point2=va_plane2(locY,locX)
    ws_point2=ws_plane2(locY,locX)
    vt_point2=vt_plane2(locY,locX)
thv_plane2=wrf_user_intrp3d(thv2, height2, "h", interheight2, 0., False)
    thv_point2=thv_plane2(locY,locX)

uvgradient_base2=(ua_point2-uaa2)^2+(va_point2-vaa2)^2
Ri2=9.8/vt_point2*(thv_point2-thvs2)/(interheight2-baseheight2)/uvgradient_base2


   ;time = wrf_user_getvar(f2, "times",i)
   height3 = wrf_user_getvar(f3, "height", i)
  ; baseheight = f3->HGT(i,0,locY,locX)
   baseheight3 = height3(0,locY,locX)
t3 = wrf_user_getvar(f3, "tk", i)
   qv3=wrf_user_getvar(f3, "QVAPOR", i)
   vt3=wrf_virtual_temp(t3, qv3)
 ua3=wrf_user_getvar(f3, "ua", i)
   va3=wrf_user_getvar(f3, "va", i)
   ws3=sqrt(ua3^2+va3^2)

   vts3=vt3(0,locY,locX)        ;lowest level virtual potential temperature
   wss3=ws3(0,locY,locX)        ;lowest level wind speed , fixed value
uaa3=ua3(0,locY,locX)
    vaa3=va3(0,locY,locX)
   th3 = wrf_user_getvar(f3, "th", i)
  ;print(height)
   print(baseheight3)
    th_base3 = th3(0,locY,locX)
    th_crite3 = th_base3+1.5   ;one of the popular mixing height definitions '
       ;do j=1,4000,1
thv3=th3*(1.0+0.61*qv3)
thvs3=thv3(0,locY,locX)


     interheight3= baseheight3+10
    th_plane3 = wrf_user_intrp3d(th3,height3, "h", interheight3, 0., False)
     th_point3 = th_plane3(locY,locX)
ws_plane3= wrf_user_intrp3d(ws3, height3, "h", interheight3, 0., False)
ua_plane3=wrf_user_intrp3d(ua3, height3, "h", interheight3, 0., False)
      va_plane3=wrf_user_intrp3d(va3, height3, "h", interheight3, 0., False)
         ua_point3=ua_plane3(locY,locX)
    va_point3=va_plane3(locY,locX)
     vt_plane3=wrf_user_intrp3d(vt3, height3, "h", interheight3, 0., False)
    ws_point3=ws_plane3(locY,locX)
    vt_point3=vt_plane3(locY,locX)

thv_plane3=wrf_user_intrp3d(thv3, height3, "h", interheight3, 0., False)
    thv_point3=thv_plane3(locY,locX)
uvgradient_base3=(ua_point3-uaa3)^2+(va_point3-vaa3)^2

Ri3=9.8/vt_point3*(thv_point3-thvs3)/(interheight3-baseheight3)/uvgradient_base3



   height4 = wrf_user_getvar(f4, "height", i)
  ; baseheight = f4->HGT(i,0,locY,locX)
   baseheight4 = height4(0,locY,locX)
   t4 = wrf_user_getvar(f4, "tk", i)
   qv4=wrf_user_getvar(f4, "QVAPOR", i)
   vt4=wrf_virtual_temp(t4, qv4)
 ua4=wrf_user_getvar(f4, "ua", i)
   va4=wrf_user_getvar(f4, "va", i)
   ws4=sqrt(ua4^2+va4^2)

   vts4=vt4(0,locY,locX)        ;lowest level virtual potential temperature
   wss4=ws4(0,locY,locX)        ;lowest level wind speed , fixed value
uaa4=ua4(0,locY,locX)
    vaa4=va4(0,locY,locX)
   th4 = wrf_user_getvar(f4, "th", i)
  ;print(height)
   print(baseheight4)
    th_base4 = th4(0,locY,locX)
    th_crite4 = th_base4+1.5   ;one of the popular mixing height definitions 
   ;do j=1,4000,1

thv4=th4*(1.0+0.61*qv4)
thvs4=thv4(0,locY,locX)

     interheight4= baseheight4+10
    th_plane4 = wrf_user_intrp3d(th4,height4, "h", interheight4, 0., False)
    th_point4 = th_plane4(locY,locX)
ws_plane4= wrf_user_intrp3d(ws4, height4, "h", interheight4, 0., False)
     vt_plane4=wrf_user_intrp3d(vt4, height4, "h", interheight4, 0., False)
     ua_plane4=wrf_user_intrp3d(ua4, height4, "h", interheight4, 0., False)
      va_plane4=wrf_user_intrp3d(va4, height4, "h", interheight4, 0., False)
         ua_point4=ua_plane4(locY,locX)
    va_point4=va_plane4(locY,locX)
    ws_point4=ws_plane4(locY,locX)
    vt_point4=vt_plane4(locY,locX)

uvgradient_base4=(ua_point4-uaa4)^2+(va_point4-vaa4)^2

thv_plane4=wrf_user_intrp3d(thv4, height4, "h", interheight4, 0., False)
    thv_point4=thv_plane4(locY,locX)


Ri4=9.8/vt_point4*(thv_point4-thvs4)/(interheight4-baseheight4)/uvgradient_base4
   
  

;print(Ri7)

     


      do while (Ri1.lt.Ricrit)
       interheight1 =interheight1+10
       th_plane1 = wrf_user_intrp3d(th1,height1, "h", interheight1, 0., False)
       th_point1 = th_plane1(locY,locX)
ua_plane1=wrf_user_intrp3d(ua1, height1, "h", interheight1, 0., False)
      va_plane1=wrf_user_intrp3d(va1, height1, "h", interheight1, 0., False)
         ua_point1=ua_plane1(locY,locX)
    va_point1=va_plane1(locY,locX)
       ws_plane1= wrf_user_intrp3d(ws1, height1, "h", interheight1, 0., False)
     vt_plane1=wrf_user_intrp3d(vt1, height1, "h", interheight1, 0., False)
    ws_point1=ws_plane1(locY,locX)
    vt_point1=vt_plane1(locY,locX)


thv_plane1=wrf_user_intrp3d(thv1, height1, "h", interheight1, 0., False)
    thv_point1=thv_plane1(locY,locX)

    interheight11 =interheight1+10
       th_plane11 = wrf_user_intrp3d(th1,height1, "h", interheight11, 0., False)
       th_point11 = th_plane11(locY,locX)
ua_plane11=wrf_user_intrp3d(ua1, height1, "h", interheight11, 0., False)
      va_plane11=wrf_user_intrp3d(va1, height1, "h", interheight11, 0., False)
         ua_point11=ua_plane11(locY,locX)
    va_point11=va_plane11(locY,locX)
       ws_plane11= wrf_user_intrp3d(ws1, height1, "h", interheight11, 0., False)
     vt_plane11=wrf_user_intrp3d(vt1, height1, "h", interheight11, 0., False)
  
    vt_point11=vt_plane11(locY,locX)


thv_plane11=wrf_user_intrp3d(thv1, height1, "h", interheight11, 0., False)
    thv_point11=thv_plane11(locY,locX)
copy_VarAtts(interheight1, interheight11)
copy_VarAtts(th_point1, th_point11)
copy_VarAtts(ua_point1, ua_point11)
copy_VarAtts(va_point1, va_point11)
copy_VarAtts(vt_point1, vt_point11)
;copy_VarAtts(ws_point1, ws_point11)
uvgradient1=(ua_point11-ua_point1)^2+(va_point11-va_point1)^2
if(uvgradient1.ne.0.0) then
Ri1=9.8/vt_point11*(thv_point11-thv_point1)/(interheight11-interheight1)/uvgradient1
end if
      end do


      do while (Ri2.lt.Ricrit)
       interheight2 =interheight2+10
       th_plane2 = wrf_user_intrp3d(th2,height2, "h", interheight2, 0., False)
       th_point2 = th_plane2(locY,locX)
ua_plane2=wrf_user_intrp3d(ua2, height2, "h", interheight2, 0., False)
      va_plane2=wrf_user_intrp3d(va2, height2, "h", interheight2, 0., False)
         ua_point2=ua_plane2(locY,locX)
    va_point2=va_plane2(locY,locX)
       ws_plane2= wrf_user_intrp3d(ws2, height2, "h", interheight2, 0., False)
     vt_plane2=wrf_user_intrp3d(vt2, height2, "h", interheight2, 0., False)
    ws_point2=ws_plane2(locY,locX)
    vt_point2=vt_plane2(locY,locX)


thv_plane2=wrf_user_intrp3d(thv2, height2, "h", interheight2, 0., False)
    thv_point2=thv_plane2(locY,locX)


    interheight22 =interheight2+10
       th_plane22 = wrf_user_intrp3d(th2,height2, "h", interheight22, 0., False)
       th_point22 = th_plane22(locY,locX)
ua_plane22=wrf_user_intrp3d(ua2, height2, "h", interheight22, 0., False)
      va_plane22=wrf_user_intrp3d(va2, height2, "h", interheight22, 0., False)
         ua_point22=ua_plane22(locY,locX)
    va_point22=va_plane22(locY,locX)
       ws_plane22= wrf_user_intrp3d(ws2, height2, "h", interheight22, 0., False)
     vt_plane22=wrf_user_intrp3d(vt2, height2, "h", interheight22, 0., False)
    ws_point22=ws_plane22(locY,locX)
    vt_point22=vt_plane22(locY,locX)


thv_plane22=wrf_user_intrp3d(thv2, height2, "h", interheight22, 0., False)
    thv_point22=thv_plane22(locY,locX)
copy_VarAtts(interheight2, interheight22)
copy_VarAtts(th_point2, th_point22)
copy_VarAtts(ua_point2, ua_point22)
copy_VarAtts(va_point2, va_point22)
copy_VarAtts(vt_point2, vt_point22)
copy_VarAtts(ws_point2, ws_point22)
uvgradient2=(ua_point22-ua_point2)^2+(va_point22-va_point2)^2
if(uvgradient2.ne.0.0) then
Ri2=9.8/vt_point22*(thv_point22-thv_point2)/(interheight22-interheight2)/uvgradient2
end if
      end do

      do while (Ri3.lt.Ricrit)
        interheight3 =interheight3+10
       th_plane3 = wrf_user_intrp3d(th3,height3, "h", interheight3, 0., False)
       th_point3 = th_plane3(locY,locX)
ua_plane3=wrf_user_intrp3d(ua3, height3, "h", interheight3, 0., False)
      va_plane3=wrf_user_intrp3d(va3, height3, "h", interheight3, 0., False)
         ua_point3=ua_plane3(locY,locX)
    va_point3=va_plane3(locY,locX)
       ws_plane3= wrf_user_intrp3d(ws3, height3, "h", interheight3, 0., False)
     vt_plane3=wrf_user_intrp3d(vt3, height3, "h", interheight3, 0., False)
    ws_point3=ws_plane3(locY,locX)
    vt_point3=vt_plane3(locY,locX)


thv_plane3=wrf_user_intrp3d(thv3, height3, "h", interheight3, 0., False)
    thv_point3=thv_plane3(locY,locX)


    interheight33 =interheight3+10
       th_plane33 = wrf_user_intrp3d(th3,height3, "h", interheight33, 0., False)
       th_point33 = th_plane33(locY,locX)
ua_plane33=wrf_user_intrp3d(ua3, height3, "h", interheight33, 0., False)
      va_plane33=wrf_user_intrp3d(va3, height3, "h", interheight33, 0., False)
         ua_point33=ua_plane33(locY,locX)
    va_point33=va_plane33(locY,locX)
       ws_plane33= wrf_user_intrp3d(ws3, height3, "h", interheight33, 0., False)
     vt_plane33=wrf_user_intrp3d(vt3, height3, "h", interheight33, 0., False)
    ws_point33=ws_plane33(locY,locX)
    vt_point33=vt_plane33(locY,locX)


thv_plane33=wrf_user_intrp3d(thv3, height3, "h", interheight33, 0., False)
    thv_point33=thv_plane33(locY,locX)
copy_VarAtts(interheight3, interheight33)
copy_VarAtts(th_point3, th_point33)
copy_VarAtts(ua_point3, ua_point33)
copy_VarAtts(va_point3, va_point33)
copy_VarAtts(vt_point3, vt_point33)
copy_VarAtts(ws_point3, ws_point33)
uvgradient3=(ua_point33-ua_point3)^3+(va_point33-va_point3)^3
if(uvgradient3.ne.0.0) then
Ri3=9.8/vt_point33*(thv_point33-thv_point3)/(interheight33-interheight3)/uvgradient3
end if
      end do

     

      do while (Ri4.lt.Ricrit)
        interheight4 =interheight4+10
       th_plane4 = wrf_user_intrp3d(th4,height4, "h", interheight4, 0., False)
       th_point4 = th_plane4(locY,locX)
ua_plane4=wrf_user_intrp3d(ua4, height4, "h", interheight4, 0., False)
      va_plane4=wrf_user_intrp3d(va4, height4, "h", interheight4, 0., False)
         ua_point4=ua_plane4(locY,locX)
    va_point4=va_plane4(locY,locX)
       ws_plane4= wrf_user_intrp3d(ws4, height4, "h", interheight4, 0., False)
     vt_plane4=wrf_user_intrp3d(vt4, height4, "h", interheight4, 0., False)
    ws_point4=ws_plane4(locY,locX)
    vt_point4=vt_plane4(locY,locX)


thv_plane4=wrf_user_intrp3d(thv4, height4, "h", interheight4, 0., False)
    thv_point4=thv_plane4(locY,locX)



    interheight44 =interheight4+10
       th_plane44 = wrf_user_intrp3d(th4,height4, "h", interheight44, 0., False)
       th_point44 = th_plane44(locY,locX)
ua_plane44=wrf_user_intrp3d(ua4, height4, "h", interheight44, 0., False)
      va_plane44=wrf_user_intrp3d(va4, height4, "h", interheight44, 0., False)
         ua_point44=ua_plane44(locY,locX)
    va_point44=va_plane44(locY,locX)
       ws_plane44= wrf_user_intrp3d(ws4, height4, "h", interheight44, 0., False)
     vt_plane44=wrf_user_intrp3d(vt4, height4, "h", interheight44, 0., False)
    ws_point44=ws_plane44(locY,locX)
    vt_point44=vt_plane44(locY,locX)


thv_plane44=wrf_user_intrp3d(thv4, height4, "h", interheight44, 0., False)
    thv_point44=thv_plane44(locY,locX)
copy_VarAtts(interheight4, interheight44)
copy_VarAtts(th_point4, th_point44)
copy_VarAtts(ua_point4, ua_point44)
copy_VarAtts(va_point4, va_point44)
copy_VarAtts(vt_point4, vt_point44)
copy_VarAtts(ws_point4, ws_point44)
uvgradient4=(ua_point44-ua_point4)^4+(va_point44-va_point4)^4
if(uvgradient4.ne.0.0) then
Ri4=9.8/vt_point44*(thv_point44-thv_point4)/(interheight44-interheight4)/uvgradient4
end if
      end do

      

;alist=[/time,baseheight,interheight,th_point/]
;format = "%s,%g,%g,%g"
alist=[/times,interheight11,interheight22,interheight33,interheight44/]
format = "%s,%g,%g,%g,%g"
write_table(csv_filename, "a", alist, format)
  ; end do
 ; delete(time)
   
    
    
 end do
;plot = gsn_csm_contour(wks,th_point(heightt(0:192,0:43),times(0:192)),res)
end















