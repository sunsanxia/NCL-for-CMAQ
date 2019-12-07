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

  H4=f7[:]->HFX
  H41=H4(:,locY1,locX1)
  H42=H4(:,locY2,locX2)
  H43=H4(:,locY3,locX3)
  H44=H4(:,locY4,locX4)
  H45=H4(:,locY5,locX5)
  H46=H4(:,locY6,locX6)
  H47=H4(:,locY7,locX7)

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

   LH4=f7[:]->LH
  LH41=LH4(:,locY1,locX1)
  LH42=LH4(:,locY2,locX2)
  LH43=LH4(:,locY3,locX3)
  LH44=LH4(:,locY4,locX4)
  LH45=LH4(:,locY5,locX5)
  LH46=LH4(:,locY6,locX6)
  LH47=LH4(:,locY7,locX7)
  
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

     ust4=f7[:]->UST
  ust41=ust4(:,locY1,locX1)
  ust42=ust4(:,locY2,locX2)
  ust43=ust4(:,locY3,locX3)
  ust44=ust4(:,locY4,locX4)
  ust45=ust4(:,locY5,locX5)
  ust46=ust4(:,locY6,locX6)
  ust47=ust4(:,locY7,locX7)


bolt=5.670373*1E-8
   DSR1=f1[:]->SWDOWN
  DSR11=DSR1(:,locY1,locX1)
  DSR12=DSR1(:,locY2,locX2)
  DSR13=DSR1(:,locY3,locX3)
  DSR14=DSR1(:,locY4,locX4)
  DSR15=DSR1(:,locY5,locX5)
  DSR16=DSR1(:,locY6,locX6)
  DSR17=DSR1(:,locY7,locX7)

  DSR2=f2[:]->SWDOWN
  DSR21=DSR2(:,locY1,locX1)
  DSR22=DSR2(:,locY2,locX2)
  DSR23=DSR2(:,locY3,locX3)
  DSR24=DSR2(:,locY4,locX4)
  DSR25=DSR2(:,locY5,locX5)
  DSR26=DSR2(:,locY6,locX6)
  DSR27=DSR2(:,locY7,locX7)

  DSR3=f3[:]->SWDOWN
  DSR31=DSR3(:,locY1,locX1)
  DSR32=DSR3(:,locY2,locX2)
  DSR33=DSR3(:,locY3,locX3)
  DSR34=DSR3(:,locY4,locX4)
  DSR35=DSR3(:,locY5,locX5)
  DSR36=DSR3(:,locY6,locX6)
  DSR37=DSR3(:,locY7,locX7)

  DSR4=f7[:]->SWDOWN
  DSR41=DSR4(:,locY1,locX1)
  DSR42=DSR4(:,locY2,locX2)
  DSR43=DSR4(:,locY3,locX3)
  DSR44=DSR4(:,locY4,locX4)
  DSR45=DSR4(:,locY5,locX5)
  DSR46=DSR4(:,locY6,locX6)
  DSR47=DSR4(:,locY7,locX7)

 

 

  DLR1=f1[:]->GLW
  DLR11=DLR1(:,locY1,locX1)
  DLR12=DLR1(:,locY2,locX2)
  DLR13=DLR1(:,locY3,locX3)
  DLR14=DLR1(:,locY4,locX4)
  DLR15=DLR1(:,locY5,locX5)
  DLR16=DLR1(:,locY6,locX6)
  DLR17=DLR1(:,locY7,locX7)

  DLR2=f2[:]->GLW
  DLR21=DLR2(:,locY1,locX1)
  DLR22=DLR2(:,locY2,locX2)
  DLR23=DLR2(:,locY3,locX3)
  DLR24=DLR2(:,locY4,locX4)
  DLR25=DLR2(:,locY5,locX5)
  DLR26=DLR2(:,locY6,locX6)
  DLR27=DLR2(:,locY7,locX7)

  DLR3=f3[:]->GLW
  DLR31=DLR3(:,locY1,locX1)
  DLR32=DLR3(:,locY2,locX2)
  DLR33=DLR3(:,locY3,locX3)
  DLR34=DLR3(:,locY4,locX4)
  DLR35=DLR3(:,locY5,locX5)
  DLR36=DLR3(:,locY6,locX6)
  DLR37=DLR3(:,locY7,locX7)

  DLR4=f7[:]->GLW
  DLR41=DLR4(:,locY1,locX1)
  DLR42=DLR4(:,locY2,locX2)
  DLR43=DLR4(:,locY3,locX3)
  DLR44=DLR4(:,locY4,locX4)
  DLR45=DLR4(:,locY5,locX5)
  DLR46=DLR4(:,locY6,locX6)
  DLR47=DLR4(:,locY7,locX7)



  albedo1=f1[:]->ALBEDO
  albedo11=albedo1(:,locY1,locX1)
  albedo12=albedo1(:,locY2,locX2)
  albedo13=albedo1(:,locY3,locX3)
  albedo14=albedo1(:,locY4,locX4)
  albedo15=albedo1(:,locY5,locX5)
  albedo16=albedo1(:,locY6,locX6)
  albedo17=albedo1(:,locY7,locX7)

  albedo2=f2[:]->ALBEDO
  albedo21=albedo2(:,locY1,locX1)
  albedo22=albedo2(:,locY2,locX2)
  albedo23=albedo2(:,locY3,locX3)
  albedo24=albedo2(:,locY4,locX4)
  albedo25=albedo2(:,locY5,locX5)
  albedo26=albedo2(:,locY6,locX6)
  albedo27=albedo2(:,locY7,locX7)

  albedo3=f3[:]->ALBEDO
  albedo31=albedo3(:,locY1,locX1)
  albedo32=albedo3(:,locY2,locX2)
  albedo33=albedo3(:,locY3,locX3)
  albedo34=albedo3(:,locY4,locX4)
  albedo35=albedo3(:,locY5,locX5)
  albedo36=albedo3(:,locY6,locX6)
  albedo37=albedo3(:,locY7,locX7)

  albedo4=f7[:]->ALBEDO
  albedo41=albedo4(:,locY1,locX1)
  albedo42=albedo4(:,locY2,locX2)
  albedo43=albedo4(:,locY3,locX3)
  albedo44=albedo4(:,locY4,locX4)
  albedo45=albedo4(:,locY5,locX5)
  albedo46=albedo4(:,locY6,locX6)
  albedo47=albedo4(:,locY7,locX7)

  
  emis1=f1[:]->EMISS
  emis11=emis1(:,locY1,locX1)
  emis12=emis1(:,locY2,locX2)
  emis13=emis1(:,locY3,locX3)
  emis14=emis1(:,locY4,locX4)
  emis15=emis1(:,locY5,locX5)
  emis16=emis1(:,locY6,locX6)
  emis17=emis1(:,locY7,locX7)

  emis2=f2[:]->EMISS
  emis21=emis2(:,locY1,locX1)
  emis22=emis2(:,locY2,locX2)
  emis23=emis2(:,locY3,locX3)
  emis24=emis2(:,locY4,locX4)
  emis25=emis2(:,locY5,locX5)
  emis26=emis2(:,locY6,locX6)
  emis27=emis2(:,locY7,locX7)

  emis3=f3[:]->EMISS
  emis31=emis3(:,locY1,locX1)
  emis32=emis3(:,locY2,locX2)
  emis33=emis3(:,locY3,locX3)
  emis34=emis3(:,locY4,locX4)
  emis35=emis3(:,locY5,locX5)
  emis36=emis3(:,locY6,locX6)
  emis37=emis3(:,locY7,locX7)

  emis4=f7[:]->EMISS
  emis41=emis4(:,locY1,locX1)
  emis42=emis4(:,locY2,locX2)
  emis43=emis4(:,locY3,locX3)
  emis44=emis4(:,locY4,locX4)
  emis45=emis4(:,locY5,locX5)
  emis46=emis4(:,locY6,locX6)
  emis47=emis4(:,locY7,locX7)



  tsk1=f1[:]->TSK
  tsk11=tsk1(:,locY1,locX1)
  tsk12=tsk1(:,locY2,locX2)
  tsk13=tsk1(:,locY3,locX3)
  tsk14=tsk1(:,locY4,locX4)
  tsk15=tsk1(:,locY5,locX5)
  tsk16=tsk1(:,locY6,locX6)
  tsk17=tsk1(:,locY7,locX7)

  tsk2=f2[:]->TSK
  tsk21=tsk2(:,locY1,locX1)
  tsk22=tsk2(:,locY2,locX2)
  tsk23=tsk2(:,locY3,locX3)
  tsk24=tsk2(:,locY4,locX4)
  tsk25=tsk2(:,locY5,locX5)
  tsk26=tsk2(:,locY6,locX6)
  tsk27=tsk2(:,locY7,locX7)

  tsk3=f3[:]->TSK
  tsk31=tsk3(:,locY1,locX1)
  tsk32=tsk3(:,locY2,locX2)
  tsk33=tsk3(:,locY3,locX3)
  tsk34=tsk3(:,locY4,locX4)
  tsk35=tsk3(:,locY5,locX5)
  tsk36=tsk3(:,locY6,locX6)
  tsk37=tsk3(:,locY7,locX7)

  tsk4=f7[:]->TSK
  tsk41=tsk4(:,locY1,locX1)
  tsk42=tsk4(:,locY2,locX2)
  tsk43=tsk4(:,locY3,locX3)
  tsk44=tsk4(:,locY4,locX4)
  tsk45=tsk4(:,locY5,locX5)
  tsk46=tsk4(:,locY6,locX6)
  tsk47=tsk4(:,locY7,locX7)

  ULR11=bolt*emis11*(tsk11^4.0)
  ULR12=bolt*emis12*(tsk12^4.0)
  ULR13=bolt*emis13*(tsk13^4.0)
  ULR14=bolt*emis14*(tsk14^4.0)
  ULR15=bolt*emis15*(tsk15^4.0)
  ULR16=bolt*emis16*(tsk16^4.0)
  ULR17=bolt*emis17*(tsk17^4.0)

  USR11=DSR11*albedo11
  USR12=DSR12*albedo12
  USR13=DSR13*albedo13
  USR14=DSR14*albedo14
  USR15=DSR15*albedo15
  USR16=DSR16*albedo16
  USR17=DSR17*albedo17


  ULR21=bolt*emis21*(tsk21^4.0)
  ULR22=bolt*emis22*(tsk22^4.0)
  ULR23=bolt*emis23*(tsk23^4.0)
  ULR24=bolt*emis24*(tsk24^4.0)
  ULR25=bolt*emis25*(tsk25^4.0)
  ULR26=bolt*emis26*(tsk26^4.0)
  ULR27=bolt*emis27*(tsk27^4.0)

  USR21=DSR21*albedo21
  USR22=DSR22*albedo22
  USR23=DSR23*albedo23
  USR24=DSR24*albedo24
  USR25=DSR25*albedo25
  USR26=DSR26*albedo26
  USR27=DSR27*albedo27

  ULR31=bolt*emis31*(tsk31^4.0)
  ULR32=bolt*emis32*(tsk32^4.0)
  ULR33=bolt*emis33*(tsk33^4.0)
  ULR34=bolt*emis34*(tsk34^4.0)
  ULR35=bolt*emis35*(tsk35^4.0)
  ULR36=bolt*emis36*(tsk36^4.0)
  ULR37=bolt*emis37*(tsk37^4.0)

  USR31=DSR31*albedo31
  USR32=DSR32*albedo32
  USR33=DSR33*albedo33
  USR34=DSR34*albedo34
  USR35=DSR35*albedo35
  USR36=DSR36*albedo36
  USR37=DSR37*albedo37

  ULR41=bolt*emis41*(tsk41^4.0)
  ULR42=bolt*emis42*(tsk42^4.0)
  ULR43=bolt*emis43*(tsk43^4.0)
  ULR44=bolt*emis44*(tsk44^4.0)
  ULR45=bolt*emis45*(tsk45^4.0)
  ULR46=bolt*emis46*(tsk46^4.0)
  ULR47=bolt*emis47*(tsk47^4.0)

  USR41=DSR41*albedo41
  USR42=DSR42*albedo42
  USR43=DSR43*albedo43
  USR44=DSR44*albedo44
  USR45=DSR45*albedo45
  USR46=DSR46*albedo46
  USR47=DSR47*albedo47


  Rn11=DSR11+DLR11-USR11-ULR11
  Rn12=DSR12+DLR12-USR12-ULR12
  Rn13=DSR13+DLR13-USR13-ULR13
  Rn14=DSR14+DLR14-USR14-ULR14
  Rn15=DSR15+DLR15-USR15-ULR15
  Rn16=DSR16+DLR16-USR16-ULR16
  Rn17=DSR17+DLR17-USR17-ULR17

  Rn21=DSR21+DLR21-USR21-ULR21
  Rn22=DSR22+DLR22-USR22-ULR22
  Rn23=DSR23+DLR23-USR23-ULR23
  Rn24=DSR24+DLR24-USR24-ULR24
  Rn25=DSR25+DLR25-USR25-ULR25
  Rn26=DSR26+DLR26-USR26-ULR26
  Rn27=DSR27+DLR27-USR27-ULR27


  Rn31=DSR31+DLR31-USR31-ULR31
  Rn32=DSR32+DLR32-USR32-ULR32
  Rn33=DSR33+DLR33-USR33-ULR33
  Rn34=DSR34+DLR34-USR34-ULR34
  Rn35=DSR35+DLR35-USR35-ULR35
  Rn36=DSR36+DLR36-USR36-ULR36
  Rn37=DSR37+DLR37-USR37-ULR37

  
  Rn41=DSR41+DLR41-USR41-ULR41
  Rn42=DSR42+DLR42-USR42-ULR42
  Rn43=DSR43+DLR43-USR43-ULR43
  Rn44=DSR44+DLR44-USR44-ULR44
  Rn45=DSR45+DLR45-USR45-ULR45
  Rn46=DSR46+DLR46-USR46-ULR46
  Rn47=DSR47+DLR47-USR47-ULR47
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
  

 ;alist=[/time,H11,H41,LH11,LH41,ust11,ust41,H21,H51,LH21,LH51,ust21,ust51,H31,H61,LH31,LH61,ust31,ust61/]
;format="%s,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g"
;write_table(csv_filename, "a", alist, format)


;*********READ OBS FILES**************************
obsname =  "turbulence_pcaps_hourly_FillValue.csv"
obsvars=asciiread(obsname, -1, "string")
delim=","
timemst=str_get_field(obsvars(1::), 2, delim)
print(timemst(744))
obsH1=tofloat(str_get_field(obsvars(1::), 3, delim))
print(obsH1(0))
obsLH1=tofloat(str_get_field(obsvars(1::), 4, delim))
obsRn1=tofloat(str_get_field(obsvars(1::), 6, delim))
obsust1=tofloat(str_get_field(obsvars(1::), 7, delim))
print(obsLH1(0))
print(obsust1(0))

obsH2=tofloat(str_get_field(obsvars(1::), 8, delim))
print(obsH2(0))
obsLH2=tofloat(str_get_field(obsvars(1::), 9, delim))
obsRn2=tofloat(str_get_field(obsvars(1::), 11, delim))
obsust2=tofloat(str_get_field(obsvars(1::), 12, delim))

obsH3=tofloat(str_get_field(obsvars(1::), 13, delim))
print(obsH3(0))
obsLH3=tofloat(str_get_field(obsvars(1::), 14, delim))
obsRn3=tofloat(str_get_field(obsvars(1::), 16, delim))
obsust3=tofloat(str_get_field(obsvars(1::), 17, delim))

obsH4=tofloat(str_get_field(obsvars(1::), 18, delim))
print(obsH4(0))
obsLH4=tofloat(str_get_field(obsvars(1::), 19, delim))
obsRn4=tofloat(str_get_field(obsvars(1::), 21, delim))
obsust4=tofloat(str_get_field(obsvars(1::), 22, delim))

obsH5=tofloat(str_get_field(obsvars(1::), 23, delim))
print(obsH5(0))
obsLH5=tofloat(str_get_field(obsvars(1::), 24, delim))
obsRn5=tofloat(str_get_field(obsvars(1::), 26, delim))
obsust5=tofloat(str_get_field(obsvars(1::), 27, delim))

obsH6=tofloat(str_get_field(obsvars(1::), 28, delim))
print(obsH6(0))
obsLH6=tofloat(str_get_field(obsvars(1::), 29, delim))
obsRn6=tofloat(str_get_field(obsvars(1::), 31, delim))
obsust6=tofloat(str_get_field(obsvars(1::), 32, delim))

obsH7=tofloat(str_get_field(obsvars(1::), 33, delim))
print(obsH7(0))
obsLH7=tofloat(str_get_field(obsvars(1::), 34, delim))
obsRn7=tofloat(str_get_field(obsvars(1::), 36, delim))
obsust7=tofloat(str_get_field(obsvars(1::), 37, delim))

obsH1@_FillValue = 999
obsLH1@_FillValue = 999
obsRn1@_FillValue = 999
obsust1@_FillValue = 999

obsH2@_FillValue = 999
obsLH2@_FillValue = 999
obsust2@_FillValue = 999
obsRn2@_FillValue = 999
obsH3@_FillValue = 999
obsLH3@_FillValue = 999
obsust3@_FillValue = 999
obsRn3@_FillValue = 999
obsH4@_FillValue = 999
obsLH4@_FillValue = 999
obsust4@_FillValue = 999
obsRn4@_FillValue = 999
obsH5@_FillValue = 999
obsLH5@_FillValue = 999
obsust5@_FillValue = 999
obsRn5@_FillValue = 999
obsH6@_FillValue = 999
obsLH6@_FillValue = 999
obsust6@_FillValue = 999
obsRn6@_FillValue = 999
obsH7@_FillValue = 999
obsLH7@_FillValue = 999
obsust7@_FillValue = 999
obsRn7@_FillValue = 999
;*********READ OBS FILES**************************
;***********BEGIN DOING STATISTICS for H*****************
nH11=0.0
sumdiff_H11=0.0
sumabsdiff_H11=0.0
nH12=0.0
sumdiff_H12=0.0
sumabsdiff_H12=0.0
nH13=0.0
sumdiff_H13=0.0
sumabsdiff_H13=0.0
nH14=0.0
sumdiff_H14=0.0
sumabsdiff_H14=0.0
nH15=0.0
sumdiff_H15=0.0
sumabsdiff_H15=0.0
nH16=0.0
sumdiff_H16=0.0
sumabsdiff_H16=0.0
nH17=0.0
sumdiff_H17=0.0
sumabsdiff_H17=0.0

nH21=0.0
sumdiff_H21=0.0
sumabsdiff_H21=0.0
nH22=0.0
sumdiff_H22=0.0
sumabsdiff_H22=0.0
nH23=0.0
sumdiff_H23=0.0
sumabsdiff_H23=0.0
nH24=0.0
sumdiff_H24=0.0
sumabsdiff_H24=0.0
nH25=0.0
sumdiff_H25=0.0
sumabsdiff_H25=0.0
nH26=0.0
sumdiff_H26=0.0
sumabsdiff_H26=0.0
nH27=0.0
sumdiff_H27=0.0
sumabsdiff_H27=0.0

nH31=0.0
sumdiff_H31=0.0
sumabsdiff_H31=0.0
nH32=0.0
sumdiff_H32=0.0
sumabsdiff_H32=0.0
nH33=0.0
sumdiff_H33=0.0
sumabsdiff_H33=0.0
nH34=0.0
sumdiff_H34=0.0
sumabsdiff_H34=0.0
nH35=0.0
sumdiff_H35=0.0
sumabsdiff_H35=0.0
nH36=0.0
sumdiff_H36=0.0
sumabsdiff_H36=0.0
nH37=0.0
sumdiff_H37=0.0
sumabsdiff_H37=0.0

nH41=0.0
sumdiff_H41=0.0
sumabsdiff_H41=0.0
nH42=0.0
sumdiff_H42=0.0
sumabsdiff_H42=0.0
nH43=0.0
sumdiff_H43=0.0
sumabsdiff_H43=0.0
nH44=0.0
sumdiff_H44=0.0
sumabsdiff_H44=0.0
nH45=0.0
sumdiff_H45=0.0
sumabsdiff_H45=0.0
nH46=0.0
sumdiff_H46=0.0
sumabsdiff_H46=0.0
nH47=0.0
sumdiff_H47=0.0
sumabsdiff_H47=0.0


nLH11=0.0
sumdiff_LH11=0.0
sumabsdiff_LH11=0.0
nLH12=0.0
sumdiff_LH12=0.0
sumabsdiff_LH12=0.0
nLH13=0.0
sumdiff_LH13=0.0
sumabsdiff_LH13=0.0
nLH14=0.0
sumdiff_LH14=0.0
sumabsdiff_LH14=0.0
nLH15=0.0
sumdiff_LH15=0.0
sumabsdiff_LH15=0.0
nLH16=0.0
sumdiff_LH16=0.0
sumabsdiff_LH16=0.0
nLH17=0.0
sumdiff_LH17=0.0
sumabsdiff_LH17=0.0

nLH21=0.0
sumdiff_LH21=0.0
sumabsdiff_LH21=0.0
nLH22=0.0
sumdiff_LH22=0.0
sumabsdiff_LH22=0.0
nLH23=0.0
sumdiff_LH23=0.0
sumabsdiff_LH23=0.0
nLH24=0.0
sumdiff_LH24=0.0
sumabsdiff_LH24=0.0
nLH25=0.0
sumdiff_LH25=0.0
sumabsdiff_LH25=0.0
nLH26=0.0
sumdiff_LH26=0.0
sumabsdiff_LH26=0.0
nLH27=0.0
sumdiff_LH27=0.0
sumabsdiff_LH27=0.0

nLH31=0.0
sumdiff_LH31=0.0
sumabsdiff_LH31=0.0
nLH32=0.0
sumdiff_LH32=0.0
sumabsdiff_LH32=0.0
nLH33=0.0
sumdiff_LH33=0.0
sumabsdiff_LH33=0.0
nLH34=0.0
sumdiff_LH34=0.0
sumabsdiff_LH34=0.0
nLH35=0.0
sumdiff_LH35=0.0
sumabsdiff_LH35=0.0
nLH36=0.0
sumdiff_LH36=0.0
sumabsdiff_LH36=0.0
nLH37=0.0
sumdiff_LH37=0.0
sumabsdiff_LH37=0.0

nLH41=0.0
sumdiff_LH41=0.0
sumabsdiff_LH41=0.0
nLH42=0.0
sumdiff_LH42=0.0
sumabsdiff_LH42=0.0
nLH43=0.0
sumdiff_LH43=0.0
sumabsdiff_LH43=0.0
nLH44=0.0
sumdiff_LH44=0.0
sumabsdiff_LH44=0.0
nLH45=0.0
sumdiff_LH45=0.0
sumabsdiff_LH45=0.0
nLH46=0.0
sumdiff_LH46=0.0
sumabsdiff_LH46=0.0
nLH47=0.0
sumdiff_LH47=0.0
sumabsdiff_LH47=0.0

nRn11=0.0
sumdiff_Rn11=0.0
sumabsdiff_Rn11=0.0
nRn12=0.0
sumdiff_Rn12=0.0
sumabsdiff_Rn12=0.0
nRn13=0.0
sumdiff_Rn13=0.0
sumabsdiff_Rn13=0.0
nRn14=0.0
sumdiff_Rn14=0.0
sumabsdiff_Rn14=0.0
nRn15=0.0
sumdiff_Rn15=0.0
sumabsdiff_Rn15=0.0
nRn16=0.0
sumdiff_Rn16=0.0
sumabsdiff_Rn16=0.0
nRn17=0.0
sumdiff_Rn17=0.0
sumabsdiff_Rn17=0.0

nRn21=0.0
sumdiff_Rn21=0.0
sumabsdiff_Rn21=0.0
nRn22=0.0
sumdiff_Rn22=0.0
sumabsdiff_Rn22=0.0
nRn23=0.0
sumdiff_Rn23=0.0
sumabsdiff_Rn23=0.0
nRn24=0.0
sumdiff_Rn24=0.0
sumabsdiff_Rn24=0.0
nRn25=0.0
sumdiff_Rn25=0.0
sumabsdiff_Rn25=0.0
nRn26=0.0
sumdiff_Rn26=0.0
sumabsdiff_Rn26=0.0
nRn27=0.0
sumdiff_Rn27=0.0
sumabsdiff_Rn27=0.0

nRn31=0.0
sumdiff_Rn31=0.0
sumabsdiff_Rn31=0.0
nRn32=0.0
sumdiff_Rn32=0.0
sumabsdiff_Rn32=0.0
nRn33=0.0
sumdiff_Rn33=0.0
sumabsdiff_Rn33=0.0
nRn34=0.0
sumdiff_Rn34=0.0
sumabsdiff_Rn34=0.0
nRn35=0.0
sumdiff_Rn35=0.0
sumabsdiff_Rn35=0.0
nRn36=0.0
sumdiff_Rn36=0.0
sumabsdiff_Rn36=0.0
nRn37=0.0
sumdiff_Rn37=0.0
sumabsdiff_Rn37=0.0

nRn41=0.0
sumdiff_Rn41=0.0
sumabsdiff_Rn41=0.0
nRn42=0.0
sumdiff_Rn42=0.0
sumabsdiff_Rn42=0.0
nRn43=0.0
sumdiff_Rn43=0.0
sumabsdiff_Rn43=0.0
nRn44=0.0
sumdiff_Rn44=0.0
sumabsdiff_Rn44=0.0
nRn45=0.0
sumdiff_Rn45=0.0
sumabsdiff_Rn45=0.0
nRn46=0.0
sumdiff_Rn46=0.0
sumabsdiff_Rn46=0.0
nRn47=0.0
sumdiff_Rn47=0.0
sumabsdiff_Rn47=0.0

nust11=0.0
sumdiff_ust11=0.0
sumabsdiff_ust11=0.0
nust12=0.0
sumdiff_ust12=0.0
sumabsdiff_ust12=0.0
nust13=0.0
sumdiff_ust13=0.0
sumabsdiff_ust13=0.0
nust14=0.0
sumdiff_ust14=0.0
sumabsdiff_ust14=0.0
nust15=0.0
sumdiff_ust15=0.0
sumabsdiff_ust15=0.0
nust16=0.0
sumdiff_ust16=0.0
sumabsdiff_ust16=0.0
nust17=0.0
sumdiff_ust17=0.0
sumabsdiff_ust17=0.0

nust21=0.0
sumdiff_ust21=0.0
sumabsdiff_ust21=0.0
nust22=0.0
sumdiff_ust22=0.0
sumabsdiff_ust22=0.0
nust23=0.0
sumdiff_ust23=0.0
sumabsdiff_ust23=0.0
nust24=0.0
sumdiff_ust24=0.0
sumabsdiff_ust24=0.0
nust25=0.0
sumdiff_ust25=0.0
sumabsdiff_ust25=0.0
nust26=0.0
sumdiff_ust26=0.0
sumabsdiff_ust26=0.0
nust27=0.0
sumdiff_ust27=0.0
sumabsdiff_ust27=0.0

nust31=0.0
sumdiff_ust31=0.0
sumabsdiff_ust31=0.0
nust32=0.0
sumdiff_ust32=0.0
sumabsdiff_ust32=0.0
nust33=0.0
sumdiff_ust33=0.0
sumabsdiff_ust33=0.0
nust34=0.0
sumdiff_ust34=0.0
sumabsdiff_ust34=0.0
nust35=0.0
sumdiff_ust35=0.0
sumabsdiff_ust35=0.0
nust36=0.0
sumdiff_ust36=0.0
sumabsdiff_ust36=0.0
nust37=0.0
sumdiff_ust37=0.0
sumabsdiff_ust37=0.0

nust41=0.0
sumdiff_ust41=0.0
sumabsdiff_ust41=0.0
nust42=0.0
sumdiff_ust42=0.0
sumabsdiff_ust42=0.0
nust43=0.0
sumdiff_ust43=0.0
sumabsdiff_ust43=0.0
nust44=0.0
sumdiff_ust44=0.0
sumabsdiff_ust44=0.0
nust45=0.0
sumdiff_ust45=0.0
sumabsdiff_ust45=0.0
nust46=0.0
sumdiff_ust46=0.0
sumabsdiff_ust46=0.0
nust47=0.0
sumdiff_ust47=0.0
sumabsdiff_ust47=0.0
;READ PCAPS DATES
PCAPname =  "Numbers_N_Daytime.csv"
countvar=asciiread(PCAPname, -1, "string")
delim=","
countt=str_get_field(countvar(0::), 1, delim)
count=tointeger(countt)
print(count(0))
print(count(127))

;DO AVERAGE OF PCAP OBS
newobsH1=new(128,float)
newobsH2=new(128,float)
newobsH3=new(128,float)
newobsH4=new(128,float)
newobsH5=new(128,float)
newobsH6=new(128,float)
newobsH7=new(128,float)

newobsLH1=new(128,float)
newobsLH2=new(128,float)
newobsLH3=new(128,float)
newobsLH4=new(128,float)
newobsLH5=new(128,float)
newobsLH6=new(128,float)
newobsLH7=new(128,float)

newobsust1=new(128,float)
newobsust2=new(128,float)
newobsust3=new(128,float)
newobsust4=new(128,float)
newobsust5=new(128,float)
newobsust6=new(128,float)
newobsust7=new(128,float)

newobsRn1=new(128,float)
newobsRn2=new(128,float)
newobsRn3=new(128,float)
newobsRn4=new(128,float)
newobsRn5=new(128,float)
newobsRn6=new(128,float)
newobsRn7=new(128,float)

newH11=new(128,float)
newH12=new(128,float)
newH13=new(128,float)
newH14=new(128,float)
newH15=new(128,float)
newH16=new(128,float)
newH17=new(128,float)
newH21=new(128,float)
newH22=new(128,float)
newH23=new(128,float)
newH24=new(128,float)
newH25=new(128,float)
newH26=new(128,float)
newH27=new(128,float)
newH31=new(128,float)
newH32=new(128,float)
newH33=new(128,float)
newH34=new(128,float)
newH35=new(128,float)
newH36=new(128,float)
newH37=new(128,float)
newH41=new(128,float)
newH42=new(128,float)
newH43=new(128,float)
newH44=new(128,float)
newH45=new(128,float)
newH46=new(128,float)
newH47=new(128,float)

newLH11=new(128,float)
newLH12=new(128,float)
newLH13=new(128,float)
newLH14=new(128,float)
newLH15=new(128,float)
newLH16=new(128,float)
newLH17=new(128,float)
newLH21=new(128,float)
newLH22=new(128,float)
newLH23=new(128,float)
newLH24=new(128,float)
newLH25=new(128,float)
newLH26=new(128,float)
newLH27=new(128,float)
newLH31=new(128,float)
newLH32=new(128,float)
newLH33=new(128,float)
newLH34=new(128,float)
newLH35=new(128,float)
newLH36=new(128,float)
newLH37=new(128,float)
newLH41=new(128,float)
newLH42=new(128,float)
newLH43=new(128,float)
newLH44=new(128,float)
newLH45=new(128,float)
newLH46=new(128,float)
newLH47=new(128,float)

newust11=new(128,float)
newust12=new(128,float)
newust13=new(128,float)
newust14=new(128,float)
newust15=new(128,float)
newust16=new(128,float)
newust17=new(128,float)
newust21=new(128,float)
newust22=new(128,float)
newust23=new(128,float)
newust24=new(128,float)
newust25=new(128,float)
newust26=new(128,float)
newust27=new(128,float)
newust31=new(128,float)
newust32=new(128,float)
newust33=new(128,float)
newust34=new(128,float)
newust35=new(128,float)
newust36=new(128,float)
newust37=new(128,float)
newust41=new(128,float)
newust42=new(128,float)
newust43=new(128,float)
newust44=new(128,float)
newust45=new(128,float)
newust46=new(128,float)
newust47=new(128,float)


newRn11=new(128,float)
newRn12=new(128,float)
newRn13=new(128,float)
newRn14=new(128,float)
newRn15=new(128,float)
newRn16=new(128,float)
newRn17=new(128,float)
newRn21=new(128,float)
newRn22=new(128,float)
newRn23=new(128,float)
newRn24=new(128,float)
newRn25=new(128,float)
newRn26=new(128,float)
newRn27=new(128,float)
newRn31=new(128,float)
newRn32=new(128,float)
newRn33=new(128,float)
newRn34=new(128,float)
newRn35=new(128,float)
newRn36=new(128,float)
newRn37=new(128,float)
newRn41=new(128,float)
newRn42=new(128,float)
newRn43=new(128,float)
newRn44=new(128,float)
newRn45=new(128,float)
newRn46=new(128,float)
newRn47=new(128,float)

do j=0,127,1
    i=count(j)
    newobsH1(j)=obsH1(i+744)
    newobsH2(j)=obsH2(i+744)
    newobsH3(j)=obsH3(i+744)
    newobsH4(j)=obsH4(i+744)
    newobsH5(j)=obsH5(i+744)
    newobsH6(j)=obsH6(i+744)
    newobsH7(j)=obsH7(i+744)

    newobsLH1(j)=obsLH1(i+744)
    newobsLH2(j)=obsLH2(i+744)
    newobsLH3(j)=obsLH3(i+744)
    newobsLH4(j)=obsLH4(i+744)
    newobsLH5(j)=obsLH5(i+744)
    newobsLH6(j)=obsLH6(i+744)
    newobsLH7(j)=obsLH7(i+744)

    newobsust1(j)=obsust1(i+744)
    newobsust2(j)=obsust2(i+744)
    newobsust3(j)=obsust3(i+744)
    newobsust4(j)=obsust4(i+744)
    newobsust5(j)=obsust5(i+744)
    newobsust6(j)=obsust6(i+744)
    newobsust7(j)=obsust7(i+744)

    newobsRn1(j)=obsRn1(i+744)
    newobsRn2(j)=obsRn2(i+744)
    newobsRn3(j)=obsRn3(i+744)
    newobsRn4(j)=obsRn4(i+744)
    newobsRn5(j)=obsRn5(i+744)
    newobsRn6(j)=obsRn6(i+744)
    newobsRn7(j)=obsRn7(i+744)
     
     newH11(j)=H11(i)
    newH12(j)=H12(i)
    newH13(j)=H13(i)
    newH14(j)=H14(i)
    newH15(j)=H15(i)
    newH16(j)=H16(i)
    newH17(j)=H17(i)

    newH21(j)=H21(i)
    newH22(j)=H22(i)
    newH23(j)=H23(i)
    newH24(j)=H24(i)
    newH25(j)=H25(i)
    newH26(j)=H26(i)
    newH27(j)=H27(i)

    newH31(j)=H31(i)
    newH32(j)=H32(i)
    newH33(j)=H33(i)
    newH34(j)=H34(i)
    newH35(j)=H35(i)
    newH36(j)=H36(i)
    newH37(j)=H37(i)

    newH41(j)=H41(i)
    newH42(j)=H42(i)
    newH43(j)=H43(i)
    newH44(j)=H44(i)
    newH45(j)=H45(i)
    newH46(j)=H46(i)
    newH47(j)=H47(i)

     newLH11(j)=LH11(i)
    newLH12(j)=LH12(i)
    newLH13(j)=LH13(i)
    newLH14(j)=LH14(i)
    newLH15(j)=LH15(i)
    newLH16(j)=LH16(i)
    newLH17(j)=LH17(i)
    
    newLH21(j)=LH21(i)
    newLH22(j)=LH22(i)
    newLH23(j)=LH23(i)
    newLH24(j)=LH24(i)
    newLH25(j)=LH25(i)
    newLH26(j)=LH26(i)
    newLH27(j)=LH27(i)

    newLH31(j)=LH31(i)
    newLH32(j)=LH32(i)
    newLH33(j)=LH33(i)
    newLH34(j)=LH34(i)
    newLH35(j)=LH35(i)
    newLH36(j)=LH36(i)
    newLH37(j)=LH37(i)

    newLH41(j)=LH41(i)
    newLH42(j)=LH42(i)
    newLH43(j)=LH43(i)
    newLH44(j)=LH44(i)
    newLH45(j)=LH45(i)
    newLH46(j)=LH46(i)
    newLH47(j)=LH47(i)

     newust11(j)=ust11(i)
    newust12(j)=ust12(i)
    newust13(j)=ust13(i)
    newust14(j)=ust14(i)
    newust15(j)=ust15(i)
    newust16(j)=ust16(i)
    newust17(j)=ust17(i)
    
    newust21(j)=ust21(i)
    newust22(j)=ust22(i)
    newust23(j)=ust23(i)
    newust24(j)=ust24(i)
    newust25(j)=ust25(i)
    newust26(j)=ust26(i)
    newust27(j)=ust27(i)

    newust31(j)=ust31(i)
    newust32(j)=ust32(i)
    newust33(j)=ust33(i)
    newust34(j)=ust34(i)
    newust35(j)=ust35(i)
    newust36(j)=ust36(i)
    newust37(j)=ust37(i)

    newust41(j)=ust41(i)
    newust42(j)=ust42(i)
    newust43(j)=ust43(i)
    newust44(j)=ust44(i)
    newust45(j)=ust45(i)
    newust46(j)=ust46(i)
    newust47(j)=ust47(i)



     newRn11(j)=Rn11(i)
    newRn12(j)=Rn12(i)
    newRn13(j)=Rn13(i)
    newRn14(j)=Rn14(i)
    newRn15(j)=Rn15(i)
    newRn16(j)=Rn16(i)
    newRn17(j)=Rn17(i)
    
    newRn21(j)=Rn21(i)
    newRn22(j)=Rn22(i)
    newRn23(j)=Rn23(i)
    newRn24(j)=Rn24(i)
    newRn25(j)=Rn25(i)
    newRn26(j)=Rn26(i)
    newRn27(j)=Rn27(i)

    newRn31(j)=Rn31(i)
    newRn32(j)=Rn32(i)
    newRn33(j)=Rn33(i)
    newRn34(j)=Rn34(i)
    newRn35(j)=Rn35(i)
    newRn36(j)=Rn36(i)
    newRn37(j)=Rn37(i)

    newRn41(j)=Rn41(i)
    newRn42(j)=Rn42(i)
    newRn43(j)=Rn43(i)
    newRn44(j)=Rn44(i)
    newRn45(j)=Rn45(i)
    newRn46(j)=Rn46(i)
    newRn47(j)=Rn47(i)

end do
avgnewobsH1=avg(newobsH1)
avgnewobsH2=avg(newobsH2)
avgnewobsH3=avg(newobsH3)
avgnewobsH4=avg(newobsH4)
avgnewobsH5=avg(newobsH5)
avgnewobsH6=avg(newobsH6)
avgnewobsH7=avg(newobsH7)

stddevnewobsH1=stddev(newobsH1)
stddevnewobsH2=stddev(newobsH2)
stddevnewobsH3=stddev(newobsH3)
stddevnewobsH4=stddev(newobsH4)
stddevnewobsH5=stddev(newobsH5)
stddevnewobsH6=stddev(newobsH6)
stddevnewobsH7=stddev(newobsH7)


avgnewobsLH1=avg(newobsLH1)
avgnewobsLH2=avg(newobsLH2)
avgnewobsLH3=avg(newobsLH3)
avgnewobsLH4=avg(newobsLH4)
avgnewobsLH5=avg(newobsLH5)
avgnewobsLH6=avg(newobsLH6)
avgnewobsLH7=avg(newobsLH7)

stddevnewobsLH1=stddev(newobsLH1)
stddevnewobsLH2=stddev(newobsLH2)
stddevnewobsLH3=stddev(newobsLH3)
stddevnewobsLH4=stddev(newobsLH4)
stddevnewobsLH5=stddev(newobsLH5)
stddevnewobsLH6=stddev(newobsLH6)
stddevnewobsLH7=stddev(newobsLH7)

avgnewobsust1=avg(newobsust1)
avgnewobsust2=avg(newobsust2)
avgnewobsust3=avg(newobsust3)
avgnewobsust4=avg(newobsust4)
avgnewobsust5=avg(newobsust5)
avgnewobsust6=avg(newobsust6)
avgnewobsust7=avg(newobsust7)

stddevnewobsust1=stddev(newobsust1)
stddevnewobsust2=stddev(newobsust2)
stddevnewobsust3=stddev(newobsust3)
stddevnewobsust4=stddev(newobsust4)
stddevnewobsust5=stddev(newobsust5)
stddevnewobsust6=stddev(newobsust6)
stddevnewobsust7=stddev(newobsust7)

avgnewobsRn1=avg(newobsRn1)
avgnewobsRn2=avg(newobsRn2)
avgnewobsRn3=avg(newobsRn3)
avgnewobsRn4=avg(newobsRn4)
avgnewobsRn5=avg(newobsRn5)
avgnewobsRn6=avg(newobsRn6)
avgnewobsRn7=avg(newobsRn7)

stddevnewobsRn1=stddev(newobsRn1)
stddevnewobsRn2=stddev(newobsRn2)
stddevnewobsRn3=stddev(newobsRn3)
stddevnewobsRn4=stddev(newobsRn4)
stddevnewobsRn5=stddev(newobsRn5)
stddevnewobsRn6=stddev(newobsRn6)
stddevnewobsRn7=stddev(newobsRn7)


;START STATS FOR H
do j=0,127,1
 i =count(j)
    print(i)
    if(.not.ismissing(obsH1(i+744)))
     diff_H11=H11(i)-obsH1(i+744)
          absdiff_H11=abs(H11(i)-obsH1(i+744))
         nH11=nH11+1
        sumdiff_H11=sumdiff_H11+diff_H11
        sumabsdiff_H11=sumabsdiff_H11+absdiff_H11

        diff_H21=H21(i)-obsH1(i+744)
        absdiff_H21=abs(H21(i)-obsH1(i+744))
        sumdiff_H21=sumdiff_H21+diff_H21
        sumabsdiff_H21=sumabsdiff_H21+absdiff_H21

        diff_H31=H31(i)-obsH1(i+744)
        absdiff_H31=abs(H31(i)-obsH1(i+744))
        sumdiff_H31=sumdiff_H31+diff_H31
        sumabsdiff_H31=sumabsdiff_H31+absdiff_H31


        diff_H41=H41(i)-obsH1(i+744)
        absdiff_H41=abs(H41(i)-obsH1(i+744))
        sumdiff_H41=sumdiff_H41+diff_H41
        sumabsdiff_H41=sumabsdiff_H41+absdiff_H41

       end if

        if(.not.ismissing(obsH2(i+744)))
     diff_H12=H12(i)-obsH2(i+744)
          absdiff_H12=abs(H12(i)-obsH2(i+744))
         nH12=nH12+1
        sumdiff_H12=sumdiff_H12+diff_H12
        sumabsdiff_H12=sumabsdiff_H12+absdiff_H12

        diff_H22=H21(i)-obsH2(i+744)
        absdiff_H22=abs(H22(i)-obsH2(i+744))
        sumdiff_H22=sumdiff_H22+diff_H22
        sumabsdiff_H22=sumabsdiff_H22+absdiff_H22

        diff_H32=H32(i)-obsH2(i+744)
        absdiff_H32=abs(H32(i)-obsH2(i+744))
        sumdiff_H32=sumdiff_H32+diff_H32
        sumabsdiff_H32=sumabsdiff_H32+absdiff_H32


        diff_H42=H42(i)-obsH2(i+744)
        absdiff_H42=abs(H42(i)-obsH2(i+744))
        sumdiff_H42=sumdiff_H42+diff_H42
        sumabsdiff_H42=sumabsdiff_H42+absdiff_H42

       end if

        if(.not.ismissing(obsH3(i+744)))
     diff_H13=H13(i)-obsH3(i+744)
          absdiff_H13=abs(H13(i)-obsH3(i+744))
         nH13=nH13+1
        sumdiff_H13=sumdiff_H13+diff_H13
        sumabsdiff_H13=sumabsdiff_H13+absdiff_H13

        diff_H23=H23(i)-obsH3(i+744)
        absdiff_H23=abs(H23(i)-obsH3(i+744))
        sumdiff_H23=sumdiff_H23+diff_H23
        sumabsdiff_H23=sumabsdiff_H23+absdiff_H23

        diff_H33=H33(i)-obsH3(i+744)
        absdiff_H33=abs(H33(i)-obsH3(i+744))
        sumdiff_H33=sumdiff_H33+diff_H33
        sumabsdiff_H33=sumabsdiff_H33+absdiff_H33


        diff_H43=H43(i)-obsH3(i+744)
        absdiff_H43=abs(H43(i)-obsH3(i+744))
        sumdiff_H43=sumdiff_H43+diff_H43
        sumabsdiff_H43=sumabsdiff_H43+absdiff_H43

       end if
      if(.not.ismissing(obsH4(i+744)))
     diff_H14=H14(i)-obsH4(i+744)
          absdiff_H14=abs(H14(i)-obsH4(i+744))
         nH14=nH14+1
        sumdiff_H14=sumdiff_H14+diff_H14
        sumabsdiff_H14=sumabsdiff_H14+absdiff_H14

        diff_H24=H24(i)-obsH4(i+744)
        absdiff_H24=abs(H24(i)-obsH4(i+744))
        sumdiff_H24=sumdiff_H24+diff_H24
        sumabsdiff_H24=sumabsdiff_H24+absdiff_H24

        diff_H34=H34(i)-obsH4(i+744)
        absdiff_H34=abs(H34(i)-obsH4(i+744))
        sumdiff_H34=sumdiff_H34+diff_H34
        sumabsdiff_H34=sumabsdiff_H34+absdiff_H34


        diff_H44=H44(i)-obsH4(i+744)
        absdiff_H44=abs(H44(i)-obsH4(i+744))
        sumdiff_H44=sumdiff_H44+diff_H44
        sumabsdiff_H44=sumabsdiff_H44+absdiff_H44

       end if

         if(.not.ismissing(obsH5(i+744)))
     diff_H15=H15(i)-obsH5(i+744)
          absdiff_H15=abs(H15(i)-obsH5(i+744))
         nH15=nH15+1
        sumdiff_H15=sumdiff_H15+diff_H15
        sumabsdiff_H15=sumabsdiff_H15+absdiff_H15

        diff_H25=H25(i)-obsH5(i+744)
        absdiff_H25=abs(H25(i)-obsH5(i+744))
        sumdiff_H25=sumdiff_H25+diff_H25
        sumabsdiff_H25=sumabsdiff_H25+absdiff_H25

        diff_H35=H35(i)-obsH5(i+744)
        absdiff_H35=abs(H35(i)-obsH5(i+744))
        sumdiff_H35=sumdiff_H35+diff_H35
        sumabsdiff_H35=sumabsdiff_H35+absdiff_H35


        diff_H45=H45(i)-obsH5(i+744)
        absdiff_H45=abs(H45(i)-obsH5(i+744))
        sumdiff_H45=sumdiff_H45+diff_H45
        sumabsdiff_H45=sumabsdiff_H45+absdiff_H45

       end if

       if(.not.ismissing(obsH6(i+744)))
     diff_H16=H16(i)-obsH6(i+744)
          absdiff_H16=abs(H16(i)-obsH6(i+744))
         nH16=nH16+1
        sumdiff_H16=sumdiff_H16+diff_H16
        sumabsdiff_H16=sumabsdiff_H16+absdiff_H16

        diff_H26=H26(i)-obsH6(i+744)
        absdiff_H26=abs(H26(i)-obsH6(i+744))
        sumdiff_H26=sumdiff_H26+diff_H26
        sumabsdiff_H26=sumabsdiff_H26+absdiff_H26

        diff_H36=H36(i)-obsH6(i+744)
        absdiff_H36=abs(H36(i)-obsH6(i+744))
        sumdiff_H36=sumdiff_H36+diff_H36
        sumabsdiff_H36=sumabsdiff_H36+absdiff_H36


        diff_H46=H46(i)-obsH6(i+744)
        absdiff_H46=abs(H46(i)-obsH6(i+744))
        sumdiff_H46=sumdiff_H46+diff_H46
        sumabsdiff_H46=sumabsdiff_H46+absdiff_H46

       end if

       if(.not.ismissing(obsH7(i+744)))
     diff_H17=H17(i)-obsH7(i+744)
          absdiff_H17=abs(H17(i)-obsH7(i+744))
         nH17=nH17+1
        sumdiff_H17=sumdiff_H17+diff_H17
        sumabsdiff_H17=sumabsdiff_H17+absdiff_H17

        diff_H27=H27(i)-obsH7(i+744)
        absdiff_H27=abs(H27(i)-obsH7(i+744))
        sumdiff_H27=sumdiff_H27+diff_H27
        sumabsdiff_H27=sumabsdiff_H27+absdiff_H27

        diff_H37=H37(i)-obsH7(i+744)
        absdiff_H37=abs(H37(i)-obsH7(i+744))
        sumdiff_H37=sumdiff_H37+diff_H37
        sumabsdiff_H37=sumabsdiff_H37+absdiff_H37


        diff_H47=H47(i)-obsH7(i+744)
        absdiff_H47=abs(H47(i)-obsH7(i+744))
        sumdiff_H47=sumdiff_H47+diff_H47
        sumabsdiff_H47=sumabsdiff_H47+absdiff_H47

       end if

end do
;print(nH11)
mbH11=sumdiff_H11/nH11
meH11=sumabsdiff_H11/nH11
nmbH11=100*sumdiff_H11/sum(newobsH1(0:127))
nmeH11=100*sumabsdiff_H11/sum(newobsH1(0:127))

rH11=escorc(newH11(0:127),newobsH1(0:127))
tH11=rH11*sqrt((nH11-2)/(1-rH11^2))
dfH11=nH11-2
pH11=student_t(tH11,dfH11) ;test significance level at the 95% level
if (pH11.le.0.05) then
    psig_H11="yes"
 else
   psig_H11="no"
end if
;print(mbH11)
;print(met2m11)
;print(nmbt2m11)
;print(nmet2m11)
;print(rt2m11)
;print(pt2m11)
;print(psig_t2m11)

mbH21=sumdiff_H21/nH11
meH21=sumabsdiff_H21/nH11
nmbH21=100*sumdiff_H21/sum(newobsH1(0:127))
nmeH21=100*sumabsdiff_H21/sum(newobsH1(0:127))
rH21=escorc(newH21(0:127),newobsH1(0:127))
tH21=rH21*sqrt((nH11-2)/(1-rH21^2))
dfH21=nH11-2
pH21=student_t(tH21,dfH21) ;test significance level at the 95% level
if (pH21.le.0.05) then
    psig_H21="yes"
 else
   psig_H21="no"
end if



mbH31=sumdiff_H31/nH11
meH31=sumabsdiff_H31/nH11
nmbH31=100*sumdiff_H31/sum(newobsH1(0:127))
nmeH31=100*sumabsdiff_H31/sum(newobsH1(0:127))
rH31=escorc(newH31(0:127),newobsH1(0:127))
tH31=rH31*sqrt((nH11-2)/(1-rH31^2))
dfH31=nH11-2
pH31=student_t(tH31,dfH31) ;test significance level at the 95% level
if (pH31.le.0.05) then
    psig_H31="yes"
 else
   psig_H31="no"
end if

mbH41=sumdiff_H41/nH11
meH41=sumabsdiff_H41/nH11
nmbH41=100*sumdiff_H41/sum(newobsH1(0:127))
nmeH41=100*sumabsdiff_H41/sum(newobsH1(0:127))
rH41=escorc(newH41(0:127),newobsH1(0:127))
tH41=rH41*sqrt((nH11-2)/(1-rH41^2))
dfH41=nH11-2
pH41=student_t(tH41,dfH41) ;test significance level at the 95% level
if (pH41.le.0.05) then
    psig_H41="yes"
 else
   psig_H41="no"
end if


mbH12=sumdiff_H12/nH12
meH12=sumabsdiff_H12/nH12
nmbH12=100*sumdiff_H12/sum(newobsH2(0:127))
nmeH12=100*sumabsdiff_H12/sum(newobsH2(0:127))
rH12=escorc(newH12(0:127),newobsH2(0:127))
tH12=rH12*sqrt((nH12-2)/(1-rH12^2))
dfH12=nH12-2
pH12=student_t(tH12,dfH12) ;test significance level at the 95% level
if (pH12.le.0.05) then
    psig_H12="yes"
 else
   psig_H12="no"
end if
;print(mbH12)
;print(meH12)
;print(nmbH12)
;print(nmeH12)
;print(rH12)
;print(pH12)
;print(psig_H12)

mbH22=sumdiff_H22/nH12
meH22=sumabsdiff_H22/nH12
nmbH22=100*sumdiff_H22/sum(newobsH2(0:127))
nmeH22=100*sumabsdiff_H22/sum(newobsH2(0:127))
rH22=escorc(newH22(0:127),newobsH2(0:127))
tH22=rH22*sqrt((nH12-2)/(1-rH22^2))
dfH22=nH12-2
pH22=student_t(tH22,dfH22) ;test significance level at the 95% level
if (pH22.le.0.05) then
    psig_H22="yes"
 else
   psig_H22="no"
end if



mbH32=sumdiff_H32/nH12
meH32=sumabsdiff_H32/nH12
nmbH32=100*sumdiff_H32/sum(newobsH2(0:127))
nmeH32=100*sumabsdiff_H32/sum(newobsH2(0:127))
rH32=escorc(newH32(0:127),newobsH2(0:127))
tH32=rH32*sqrt((nH12-2)/(1-rH32^2))
dfH32=nH12-2
pH32=student_t(tH32,dfH32) ;test significance level at the 95% level
if (pH32.le.0.05) then
    psig_H32="yes"
 else
   psig_H32="no"
end if

mbH42=sumdiff_H42/nH12
meH42=sumabsdiff_H42/nH12
nmbH42=100*sumdiff_H42/sum(newobsH2(0:127))
nmeH42=100*sumabsdiff_H42/sum(newobsH2(0:127))
rH42=escorc(newH42(0:127),newobsH2(0:127))
tH42=rH42*sqrt((nH12-2)/(1-rH42^2))
dfH42=nH12-2
pH42=student_t(tH42,dfH42) ;test significance level at the 95% level
if (pH42.le.0.05) then
    psig_H42="yes"
 else
   psig_H42="no"
end if

mbH13=sumdiff_H13/nH13
meH13=sumabsdiff_H13/nH13
nmbH13=100*sumdiff_H13/sum(newobsH3(0:127))
nmeH13=100*sumabsdiff_H13/sum(newobsH3(0:127))
rH13=escorc(newH13(0:127),newobsH3(0:127))
tH13=rH13*sqrt((nH13-2)/(1-rH13^2))
dfH13=nH13-2
pH13=student_t(tH13,dfH13) ;test significance level at the 95% level
if (pH13.le.0.05) then
    psig_H13="yes"
 else
   psig_H13="no"
end if
;print(mbH13)
;print(meH13)
;print(nmbH13)
;print(nmeH13)
;print(rH13)
;print(pH13)
;print(psig_H13)

mbH23=sumdiff_H23/nH13
meH23=sumabsdiff_H23/nH13
nmbH23=100*sumdiff_H23/sum(newobsH3(0:127))
nmeH23=100*sumabsdiff_H23/sum(newobsH3(0:127))
rH23=escorc(newH23(0:127),newobsH3(0:127))
tH23=rH23*sqrt((nH13-2)/(1-rH23^2))
dfH23=nH13-2
pH23=student_t(tH23,dfH23) ;test significance level at the 95% level
if (pH23.le.0.05) then
    psig_H23="yes"
 else
   psig_H23="no"
end if



mbH33=sumdiff_H33/nH13
meH33=sumabsdiff_H33/nH13
nmbH33=100*sumdiff_H33/sum(newobsH3(0:127))
nmeH33=100*sumabsdiff_H33/sum(newobsH3(0:127))
rH33=escorc(newH33(0:127),newobsH3(0:127))
tH33=rH33*sqrt((nH13-2)/(1-rH33^2))
dfH33=nH13-2
pH33=student_t(tH33,dfH33) ;test significance level at the 95% level
if (pH33.le.0.05) then
    psig_H33="yes"
 else
   psig_H33="no"
end if

mbH43=sumdiff_H43/nH13
meH43=sumabsdiff_H43/nH13
nmbH43=100*sumdiff_H43/sum(newobsH3(0:127))
nmeH43=100*sumabsdiff_H43/sum(newobsH3(0:127))
rH43=escorc(newH43(0:127),newobsH3(0:127))
tH43=rH43*sqrt((nH13-2)/(1-rH43^2))
dfH43=nH13-2
pH43=student_t(tH43,dfH43) ;test significance level at the 95% level
if (pH43.le.0.05) then
    psig_H43="yes"
 else
   psig_H43="no"
end if

mbH14=sumdiff_H14/nH14
meH14=sumabsdiff_H14/nH14
nmbH14=100*sumdiff_H14/sum(newobsH4(0:127))
nmeH14=100*sumabsdiff_H14/sum(newobsH4(0:127))
rH14=escorc(newH14(0:127),newobsH4(0:127))
tH14=rH14*sqrt((nH14-2)/(1-rH14^2))
dfH14=nH14-2
pH14=student_t(tH14,dfH14) ;test significance level at the 95% level
if (pH14.le.0.05) then
    psig_H14="yes"
 else
   psig_H14="no"
end if
;print(mbH14)
;print(meH14)
;print(nmbH14)
;print(nmeH14)
;print(rH14)
;print(pH14)
;print(psig_H14)

mbH24=sumdiff_H24/nH14
meH24=sumabsdiff_H24/nH14
nmbH24=100*sumdiff_H24/sum(newobsH4(0:127))
nmeH24=100*sumabsdiff_H24/sum(newobsH4(0:127))
rH24=escorc(newH24(0:127),newobsH4(0:127))
tH24=rH24*sqrt((nH14-2)/(1-rH24^2))
dfH24=nH14-2
pH24=student_t(tH24,dfH24) ;test significance level at the 95% level
if (pH24.le.0.05) then
    psig_H24="yes"
 else
   psig_H24="no"
end if



mbH34=sumdiff_H34/nH14
meH34=sumabsdiff_H34/nH14
nmbH34=100*sumdiff_H34/sum(newobsH4(0:127))
nmeH34=100*sumabsdiff_H34/sum(newobsH4(0:127))
rH34=escorc(newH34(0:127),newobsH4(0:127))
tH34=rH34*sqrt((nH14-2)/(1-rH34^2))
dfH34=nH14-2
pH34=student_t(tH34,dfH34) ;test significance level at the 95% level
if (pH34.le.0.05) then
    psig_H34="yes"
 else
   psig_H34="no"
end if

mbH44=sumdiff_H44/nH14
meH44=sumabsdiff_H44/nH14
nmbH44=100*sumdiff_H44/sum(newobsH4(0:127))
nmeH44=100*sumabsdiff_H44/sum(newobsH4(0:127))
rH44=escorc(newH44(0:127),newobsH4(0:127))
tH44=rH44*sqrt((nH14-2)/(1-rH44^2))
dfH44=nH14-2
pH44=student_t(tH44,dfH44) ;test significance level at the 95% level
if (pH44.le.0.05) then
    psig_H44="yes"
 else
   psig_H44="no"
end if

mbH15=sumdiff_H15/nH15
meH15=sumabsdiff_H15/nH15
nmbH15=100*sumdiff_H15/sum(newobsH5(0:127))
nmeH15=100*sumabsdiff_H15/sum(newobsH5(0:127))
rH15=escorc(newH15(0:127),newobsH5(0:127))
tH15=rH15*sqrt((nH15-2)/(1-rH15^2))
dfH15=nH15-2
pH15=student_t(tH15,dfH15) ;test significance level at the 95% level
if (pH15.le.0.05) then
    psig_H15="yes"
 else
   psig_H15="no"
end if
;print(mbH15)
;print(meH15)
;print(nmbH15)
;print(nmeH15)
;print(rH15)
;print(pH15)
;print(psig_H15)

mbH25=sumdiff_H25/nH15
meH25=sumabsdiff_H25/nH15
nmbH25=100*sumdiff_H25/sum(newobsH5(0:127))
nmeH25=100*sumabsdiff_H25/sum(newobsH5(0:127))
rH25=escorc(newH25(0:127),newobsH5(0:127))
tH25=rH25*sqrt((nH15-2)/(1-rH25^2))
dfH25=nH15-2
pH25=student_t(tH25,dfH25) ;test significance level at the 95% level
if (pH25.le.0.05) then
    psig_H25="yes"
 else
   psig_H25="no"
end if



mbH35=sumdiff_H35/nH15
meH35=sumabsdiff_H35/nH15
nmbH35=100*sumdiff_H35/sum(newobsH5(0:127))
nmeH35=100*sumabsdiff_H35/sum(newobsH5(0:127))
rH35=escorc(newH35(0:127),newobsH5(0:127))
tH35=rH35*sqrt((nH15-2)/(1-rH35^2))
dfH35=nH15-2
pH35=student_t(tH35,dfH35) ;test significance level at the 95% level
if (pH35.le.0.05) then
    psig_H35="yes"
 else
   psig_H35="no"
end if

mbH45=sumdiff_H45/nH15
meH45=sumabsdiff_H45/nH15
nmbH45=100*sumdiff_H45/sum(newobsH5(0:127))
nmeH45=100*sumabsdiff_H45/sum(newobsH5(0:127))
rH45=escorc(newH45(0:127),newobsH5(0:127))
tH45=rH45*sqrt((nH15-2)/(1-rH45^2))
dfH45=nH15-2
pH45=student_t(tH45,dfH45) ;test significance level at the 95% level
if (pH45.le.0.05) then
    psig_H45="yes"
 else
   psig_H45="no"
end if

mbH16=sumdiff_H16/nH16
meH16=sumabsdiff_H16/nH16
nmbH16=100*sumdiff_H16/sum(newobsH6(0:127))
nmeH16=100*sumabsdiff_H16/sum(newobsH6(0:127))
rH16=escorc(newH16(0:127),newobsH6(0:127))
tH16=rH16*sqrt((nH16-2)/(1-rH16^2))
dfH16=nH16-2
pH16=student_t(tH16,dfH16) ;test significance level at the 95% level
if (pH16.le.0.05) then
    psig_H16="yes"
 else
   psig_H16="no"
end if
;print(mbH16)
;print(meH16)
;print(nmbH16)
;print(nmeH16)
;print(rH16)
;print(pH16)
;print(psig_H16)

mbH26=sumdiff_H26/nH16
meH26=sumabsdiff_H26/nH16
nmbH26=100*sumdiff_H26/sum(newobsH6(0:127))
nmeH26=100*sumabsdiff_H26/sum(newobsH6(0:127))
rH26=escorc(newH26(0:127),newobsH6(0:127))
tH26=rH26*sqrt((nH16-2)/(1-rH26^2))
dfH26=nH16-2
pH26=student_t(tH26,dfH26) ;test significance level at the 95% level
if (pH26.le.0.05) then
    psig_H26="yes"
 else
   psig_H26="no"
end if



mbH36=sumdiff_H36/nH16
meH36=sumabsdiff_H36/nH16
nmbH36=100*sumdiff_H36/sum(newobsH6(0:127))
nmeH36=100*sumabsdiff_H36/sum(newobsH6(0:127))
rH36=escorc(newH36(0:127),newobsH6(0:127))
tH36=rH36*sqrt((nH16-2)/(1-rH36^2))
dfH36=nH16-2
pH36=student_t(tH36,dfH36) ;test significance level at the 95% level
if (pH36.le.0.05) then
    psig_H36="yes"
 else
   psig_H36="no"
end if

mbH46=sumdiff_H46/nH16
meH46=sumabsdiff_H46/nH16
nmbH46=100*sumdiff_H46/sum(newobsH6(0:127))
nmeH46=100*sumabsdiff_H46/sum(newobsH6(0:127))
rH46=escorc(newH46(0:127),newobsH6(0:127))
tH46=rH46*sqrt((nH16-2)/(1-rH46^2))
dfH46=nH16-2
pH46=student_t(tH46,dfH46) ;test significance level at the 95% level
if (pH46.le.0.05) then
    psig_H46="yes"
 else
   psig_H46="no"
end if

mbH17=sumdiff_H17/nH17
meH17=sumabsdiff_H17/nH17
nmbH17=100*sumdiff_H17/sum(newobsH7(0:127))
nmeH17=100*sumabsdiff_H17/sum(newobsH7(0:127))
rH17=escorc(newH17(0:127),newobsH7(0:127))
tH17=rH17*sqrt((nH17-2)/(1-rH17^2))
dfH17=nH17-2
pH17=student_t(tH17,dfH17) ;test significance level at the 95% level
if (pH17.le.0.05) then
    psig_H17="yes"
 else
   psig_H17="no"
end if
;print(mbH17)
;print(meH17)
;print(nmbH17)
;print(nmeH17)
;print(rH17)
;print(pH17)
;print(psig_H17)

mbH27=sumdiff_H27/nH17
meH27=sumabsdiff_H27/nH17
nmbH27=100*sumdiff_H27/sum(newobsH7(0:127))
nmeH27=100*sumabsdiff_H27/sum(newobsH7(0:127))
rH27=escorc(newH27(0:127),newobsH7(0:127))
tH27=rH27*sqrt((nH17-2)/(1-rH27^2))
dfH27=nH17-2
pH27=student_t(tH27,dfH27) ;test significance level at the 95% level
if (pH27.le.0.05) then
    psig_H27="yes"
 else
   psig_H27="no"
end if



mbH37=sumdiff_H37/nH17
meH37=sumabsdiff_H37/nH17
nmbH37=100*sumdiff_H37/sum(newobsH7(0:127))
nmeH37=100*sumabsdiff_H37/sum(newobsH7(0:127))
rH37=escorc(newH37(0:127),newobsH7(0:127))
tH37=rH37*sqrt((nH17-2)/(1-rH37^2))
dfH37=nH17-2
pH37=student_t(tH37,dfH37) ;test significance level at the 95% level
if (pH37.le.0.05) then
    psig_H37="yes"
 else
   psig_H37="no"
end if

mbH47=sumdiff_H47/nH17
meH47=sumabsdiff_H47/nH17
nmbH47=100*sumdiff_H47/sum(newobsH7(0:127))
nmeH47=100*sumabsdiff_H47/sum(newobsH7(0:127))
rH47=escorc(newH47(0:127),newobsH7(0:127))
tH47=rH47*sqrt((nH17-2)/(1-rH47^2))
dfH47=nH17-2
pH47=student_t(tH47,dfH47) ;test significance level at the 95% level
if (pH47.le.0.05) then
    psig_H47="yes"
 else
   psig_H47="no"
end if




;START DOING STATS FOR LH
do j=0,127,1
 i =count(j)
    print(i)
    if(.not.ismissing(obsLH1(i+744)))
     diff_LH11=LH11(i)-obsLH1(i+744)
          absdiff_LH11=abs(LH11(i)-obsLH1(i+744))
         nLH11=nLH11+1
        sumdiff_LH11=sumdiff_LH11+diff_LH11
        sumabsdiff_LH11=sumabsdiff_LH11+absdiff_LH11

        diff_LH21=LH21(i)-obsLH1(i+744)
        absdiff_LH21=abs(LH21(i)-obsLH1(i+744))
        sumdiff_LH21=sumdiff_LH21+diff_LH21
        sumabsdiff_LH21=sumabsdiff_LH21+absdiff_LH21

        diff_LH31=LH31(i)-obsLH1(i+744)
        absdiff_LH31=abs(LH31(i)-obsLH1(i+744))
        sumdiff_LH31=sumdiff_LH31+diff_LH31
        sumabsdiff_LH31=sumabsdiff_LH31+absdiff_LH31


        diff_LH41=LH41(i)-obsLH1(i+744)
        absdiff_LH41=abs(LH41(i)-obsLH1(i+744))
        sumdiff_LH41=sumdiff_LH41+diff_LH41
        sumabsdiff_LH41=sumabsdiff_LH41+absdiff_LH41

       end if

        if(.not.ismissing(obsLH2(i+744)))
     diff_LH12=LH12(i)-obsLH2(i+744)
          absdiff_LH12=abs(LH12(i)-obsLH2(i+744))
         nLH12=nLH12+1
        sumdiff_LH12=sumdiff_LH12+diff_LH12
        sumabsdiff_LH12=sumabsdiff_LH12+absdiff_LH12

        diff_LH22=LH21(i)-obsLH2(i+744)
        absdiff_LH22=abs(LH22(i)-obsLH2(i+744))
        sumdiff_LH22=sumdiff_LH22+diff_LH22
        sumabsdiff_LH22=sumabsdiff_LH22+absdiff_LH22

        diff_LH32=LH32(i)-obsLH2(i+744)
        absdiff_LH32=abs(LH32(i)-obsLH2(i+744))
        sumdiff_LH32=sumdiff_LH32+diff_LH32
        sumabsdiff_LH32=sumabsdiff_LH32+absdiff_LH32


        diff_LH42=LH42(i)-obsLH2(i+744)
        absdiff_LH42=abs(LH42(i)-obsLH2(i+744))
        sumdiff_LH42=sumdiff_LH42+diff_LH42
        sumabsdiff_LH42=sumabsdiff_LH42+absdiff_LH42

       end if

        if(.not.ismissing(obsLH3(i+744)))
     diff_LH13=LH13(i)-obsLH3(i+744)
          absdiff_LH13=abs(LH13(i)-obsLH3(i+744))
         nLH13=nLH13+1
        sumdiff_LH13=sumdiff_LH13+diff_LH13
        sumabsdiff_LH13=sumabsdiff_LH13+absdiff_LH13

        diff_LH23=LH23(i)-obsLH3(i+744)
        absdiff_LH23=abs(LH23(i)-obsLH3(i+744))
        sumdiff_LH23=sumdiff_LH23+diff_LH23
        sumabsdiff_LH23=sumabsdiff_LH23+absdiff_LH23

        diff_LH33=LH33(i)-obsLH3(i+744)
        absdiff_LH33=abs(LH33(i)-obsLH3(i+744))
        sumdiff_LH33=sumdiff_LH33+diff_LH33
        sumabsdiff_LH33=sumabsdiff_LH33+absdiff_LH33


        diff_LH43=LH43(i)-obsLH3(i+744)
        absdiff_LH43=abs(LH43(i)-obsLH3(i+744))
        sumdiff_LH43=sumdiff_LH43+diff_LH43
        sumabsdiff_LH43=sumabsdiff_LH43+absdiff_LH43

       end if
      if(.not.ismissing(obsLH4(i+744)))
     diff_LH14=LH14(i)-obsLH4(i+744)
          absdiff_LH14=abs(LH14(i)-obsLH4(i+744))
         nLH14=nLH14+1
        sumdiff_LH14=sumdiff_LH14+diff_LH14
        sumabsdiff_LH14=sumabsdiff_LH14+absdiff_LH14

        diff_LH24=LH24(i)-obsLH4(i+744)
        absdiff_LH24=abs(LH24(i)-obsLH4(i+744))
        sumdiff_LH24=sumdiff_LH24+diff_LH24
        sumabsdiff_LH24=sumabsdiff_LH24+absdiff_LH24

        diff_LH34=LH34(i)-obsLH4(i+744)
        absdiff_LH34=abs(LH34(i)-obsLH4(i+744))
        sumdiff_LH34=sumdiff_LH34+diff_LH34
        sumabsdiff_LH34=sumabsdiff_LH34+absdiff_LH34


        diff_LH44=LH44(i)-obsLH4(i+744)
        absdiff_LH44=abs(LH44(i)-obsLH4(i+744))
        sumdiff_LH44=sumdiff_LH44+diff_LH44
        sumabsdiff_LH44=sumabsdiff_LH44+absdiff_LH44

       end if

         if(.not.ismissing(obsLH5(i+744)))
     diff_LH15=LH15(i)-obsLH5(i+744)
          absdiff_LH15=abs(LH15(i)-obsLH5(i+744))
         nLH15=nLH15+1
        sumdiff_LH15=sumdiff_LH15+diff_LH15
        sumabsdiff_LH15=sumabsdiff_LH15+absdiff_LH15

        diff_LH25=LH25(i)-obsLH5(i+744)
        absdiff_LH25=abs(LH25(i)-obsLH5(i+744))
        sumdiff_LH25=sumdiff_LH25+diff_LH25
        sumabsdiff_LH25=sumabsdiff_LH25+absdiff_LH25

        diff_LH35=LH35(i)-obsLH5(i+744)
        absdiff_LH35=abs(LH35(i)-obsLH5(i+744))
        sumdiff_LH35=sumdiff_LH35+diff_LH35
        sumabsdiff_LH35=sumabsdiff_LH35+absdiff_LH35


        diff_LH45=LH45(i)-obsLH5(i+744)
        absdiff_LH45=abs(LH45(i)-obsLH5(i+744))
        sumdiff_LH45=sumdiff_LH45+diff_LH45
        sumabsdiff_LH45=sumabsdiff_LH45+absdiff_LH45

       end if

       if(.not.ismissing(obsLH6(i+744)))
     diff_LH16=LH16(i)-obsLH6(i+744)
          absdiff_LH16=abs(LH16(i)-obsLH6(i+744))
         nLH16=nLH16+1
        sumdiff_LH16=sumdiff_LH16+diff_LH16
        sumabsdiff_LH16=sumabsdiff_LH16+absdiff_LH16

        diff_LH26=LH26(i)-obsLH6(i+744)
        absdiff_LH26=abs(LH26(i)-obsLH6(i+744))
        sumdiff_LH26=sumdiff_LH26+diff_LH26
        sumabsdiff_LH26=sumabsdiff_LH26+absdiff_LH26

        diff_LH36=LH36(i)-obsLH6(i+744)
        absdiff_LH36=abs(LH36(i)-obsLH6(i+744))
        sumdiff_LH36=sumdiff_LH36+diff_LH36
        sumabsdiff_LH36=sumabsdiff_LH36+absdiff_LH36


        diff_LH46=LH46(i)-obsLH6(i+744)
        absdiff_LH46=abs(LH46(i)-obsLH6(i+744))
        sumdiff_LH46=sumdiff_LH46+diff_LH46
        sumabsdiff_LH46=sumabsdiff_LH46+absdiff_LH46

       end if

       if(.not.ismissing(obsLH7(i+744)))
     diff_LH17=LH17(i)-obsLH7(i+744)
          absdiff_LH17=abs(LH17(i)-obsLH7(i+744))
         nLH17=nLH17+1
        sumdiff_LH17=sumdiff_LH17+diff_LH17
        sumabsdiff_LH17=sumabsdiff_LH17+absdiff_LH17

        diff_LH27=LH27(i)-obsLH7(i+744)
        absdiff_LH27=abs(LH27(i)-obsLH7(i+744))
        sumdiff_LH27=sumdiff_LH27+diff_LH27
        sumabsdiff_LH27=sumabsdiff_LH27+absdiff_LH27

        diff_LH37=LH37(i)-obsLH7(i+744)
        absdiff_LH37=abs(LH37(i)-obsLH7(i+744))
        sumdiff_LH37=sumdiff_LH37+diff_LH37
        sumabsdiff_LH37=sumabsdiff_LH37+absdiff_LH37


        diff_LH47=LH47(i)-obsLH7(i+744)
        absdiff_LH47=abs(LH47(i)-obsLH7(i+744))
        sumdiff_LH47=sumdiff_LH47+diff_LH47
        sumabsdiff_LH47=sumabsdiff_LH47+absdiff_LH47

       end if

end do
;print(nLH11)
mbLH11=sumdiff_LH11/nLH11
meLH11=sumabsdiff_LH11/nLH11
nmbLH11=100*sumdiff_LH11/sum(newobsLH1(0:127))
nmeLH11=100*sumabsdiff_LH11/sum(newobsLH1(0:127))

rLH11=escorc(newLH11(0:127),newobsLH1(0:127))
tLH11=rLH11*sqrt((nLH11-2)/(1-rLH11^2))
dfLH11=nLH11-2
pLH11=student_t(tLH11,dfLH11) ;test significance level at tLHe 95% level
if (pLH11.le.0.05) then
    psig_LH11="yes"
 else
   psig_LH11="no"
end if
;print(mbLH11)
;print(meLH11)
;print(nmbLH11)
;print(nmeLH11)
;print(rLH11)
;print(pLH11)
;print(psig_LH11)

mbLH21=sumdiff_LH21/nLH11
meLH21=sumabsdiff_LH21/nLH11
nmbLH21=100*sumdiff_LH21/sum(newobsLH1(0:127))
nmeLH21=100*sumabsdiff_LH21/sum(newobsLH1(0:127))
rLH21=escorc(newLH21(0:127),newobsLH1(0:127))
tLH21=rLH21*sqrt((nLH11-2)/(1-rLH21^2))
dfLH21=nLH11-2
pLH21=student_t(tLH21,dfLH21) ;test significance level at tLHe 95% level
if (pLH21.le.0.05) then
    psig_LH21="yes"
 else
   psig_LH21="no"
end if



mbLH31=sumdiff_LH31/nLH11
meLH31=sumabsdiff_LH31/nLH11
nmbLH31=100*sumdiff_LH31/sum(newobsLH1(0:127))
nmeLH31=100*sumabsdiff_LH31/sum(newobsLH1(0:127))
rLH31=escorc(newLH31(0:127),newobsLH1(0:127))
tLH31=rLH31*sqrt((nLH11-2)/(1-rLH31^2))
dfLH31=nLH11-2
pLH31=student_t(tLH31,dfLH31) ;test significance level at tLHe 95% level
if (pLH31.le.0.05) then
    psig_LH31="yes"
 else
   psig_LH31="no"
end if

mbLH41=sumdiff_LH41/nLH11
meLH41=sumabsdiff_LH41/nLH11
nmbLH41=100*sumdiff_LH41/sum(newobsLH1(0:127))
nmeLH41=100*sumabsdiff_LH41/sum(newobsLH1(0:127))
rLH41=escorc(newLH41(0:127),newobsLH1(0:127))
tLH41=rLH41*sqrt((nLH11-2)/(1-rLH41^2))
dfLH41=nLH11-2
pLH41=student_t(tLH41,dfLH41) ;test significance level at tLHe 95% level
if (pLH41.le.0.05) then
    psig_LH41="yes"
 else
   psig_LH41="no"
end if


mbLH12=sumdiff_LH12/nLH12
meLH12=sumabsdiff_LH12/nLH12
nmbLH12=100*sumdiff_LH12/sum(newobsLH2(0:127))
nmeLH12=100*sumabsdiff_LH12/sum(newobsLH2(0:127))
rLH12=escorc(newLH12(0:127),newobsLH2(0:127))
tLH12=rLH12*sqrt((nLH12-2)/(1-rLH12^2))
dfLH12=nLH12-2
pLH12=student_t(tLH12,dfLH12) ;test significance level at tLHe 95% level
if (pLH12.le.0.05) then
    psig_LH12="yes"
 else
   psig_LH12="no"
end if
;print(mbLH12)
;print(meLH12)
;print(nmbLH12)
;print(nmeLH12)
;print(rLH12)
;print(pLH12)
;print(psig_LH12)

mbLH22=sumdiff_LH22/nLH12
meLH22=sumabsdiff_LH22/nLH12
nmbLH22=100*sumdiff_LH22/sum(newobsLH2(0:127))
nmeLH22=100*sumabsdiff_LH22/sum(newobsLH2(0:127))
rLH22=escorc(newLH22(0:127),newobsLH2(0:127))
tLH22=rLH22*sqrt((nLH12-2)/(1-rLH22^2))
dfLH22=nLH12-2
pLH22=student_t(tLH22,dfLH22) ;test significance level at tLHe 95% level
if (pLH22.le.0.05) then
    psig_LH22="yes"
 else
   psig_LH22="no"
end if



mbLH32=sumdiff_LH32/nLH12
meLH32=sumabsdiff_LH32/nLH12
nmbLH32=100*sumdiff_LH32/sum(newobsLH2(0:127))
nmeLH32=100*sumabsdiff_LH32/sum(newobsLH2(0:127))
rLH32=escorc(newLH32(0:127),newobsLH2(0:127))
tLH32=rLH32*sqrt((nLH12-2)/(1-rLH32^2))
dfLH32=nLH12-2
pLH32=student_t(tLH32,dfLH32) ;test significance level at tLHe 95% level
if (pLH32.le.0.05) then
    psig_LH32="yes"
 else
   psig_LH32="no"
end if

mbLH42=sumdiff_LH42/nLH12
meLH42=sumabsdiff_LH42/nLH12
nmbLH42=100*sumdiff_LH42/sum(newobsLH2(0:127))
nmeLH42=100*sumabsdiff_LH42/sum(newobsLH2(0:127))
rLH42=escorc(newLH42(0:127),newobsLH2(0:127))
tLH42=rLH42*sqrt((nLH12-2)/(1-rLH42^2))
dfLH42=nLH12-2
pLH42=student_t(tLH42,dfLH42) ;test significance level at tLHe 95% level
if (pLH42.le.0.05) then
    psig_LH42="yes"
 else
   psig_LH42="no"
end if

mbLH13=sumdiff_LH13/nLH13
meLH13=sumabsdiff_LH13/nLH13
nmbLH13=100*sumdiff_LH13/sum(newobsLH3(0:127))
nmeLH13=100*sumabsdiff_LH13/sum(newobsLH3(0:127))
rLH13=escorc(newLH13(0:127),newobsLH3(0:127))
tLH13=rLH13*sqrt((nLH13-2)/(1-rLH13^2))
dfLH13=nLH13-2
pLH13=student_t(tLH13,dfLH13) ;test significance level at tLHe 95% level
if (pLH13.le.0.05) then
    psig_LH13="yes"
 else
   psig_LH13="no"
end if
;print(mbLH13)
;print(meLH13)
;print(nmbLH13)
;print(nmeLH13)
;print(rLH13)
;print(pLH13)
;print(psig_LH13)

mbLH23=sumdiff_LH23/nLH13
meLH23=sumabsdiff_LH23/nLH13
nmbLH23=100*sumdiff_LH23/sum(newobsLH3(0:127))
nmeLH23=100*sumabsdiff_LH23/sum(newobsLH3(0:127))
rLH23=escorc(newLH23(0:127),newobsLH3(0:127))
tLH23=rLH23*sqrt((nLH13-2)/(1-rLH23^2))
dfLH23=nLH13-2
pLH23=student_t(tLH23,dfLH23) ;test significance level at tLHe 95% level
if (pLH23.le.0.05) then
    psig_LH23="yes"
 else
   psig_LH23="no"
end if



mbLH33=sumdiff_LH33/nLH13
meLH33=sumabsdiff_LH33/nLH13
nmbLH33=100*sumdiff_LH33/sum(newobsLH3(0:127))
nmeLH33=100*sumabsdiff_LH33/sum(newobsLH3(0:127))
rLH33=escorc(newLH33(0:127),newobsLH3(0:127))
tLH33=rLH33*sqrt((nLH13-2)/(1-rLH33^2))
dfLH33=nLH13-2
pLH33=student_t(tLH33,dfLH33) ;test significance level at tLHe 95% level
if (pLH33.le.0.05) then
    psig_LH33="yes"
 else
   psig_LH33="no"
end if

mbLH43=sumdiff_LH43/nLH13
meLH43=sumabsdiff_LH43/nLH13
nmbLH43=100*sumdiff_LH43/sum(newobsLH3(0:127))
nmeLH43=100*sumabsdiff_LH43/sum(newobsLH3(0:127))
rLH43=escorc(newLH43(0:127),newobsLH3(0:127))
tLH43=rLH43*sqrt((nLH13-2)/(1-rLH43^2))
dfLH43=nLH13-2
pLH43=student_t(tLH43,dfLH43) ;test significance level at tLHe 95% level
if (pLH43.le.0.05) then
    psig_LH43="yes"
 else
   psig_LH43="no"
end if

mbLH14=sumdiff_LH14/nLH14
meLH14=sumabsdiff_LH14/nLH14
nmbLH14=100*sumdiff_LH14/sum(newobsLH4(0:127))
nmeLH14=100*sumabsdiff_LH14/sum(newobsLH4(0:127))
rLH14=escorc(newLH14(0:127),newobsLH4(0:127))
tLH14=rLH14*sqrt((nLH14-2)/(1-rLH14^2))
dfLH14=nLH14-2
pLH14=student_t(tLH14,dfLH14) ;test significance level at tLHe 95% level
if (pLH14.le.0.05) then
    psig_LH14="yes"
 else
   psig_LH14="no"
end if
;print(mbLH14)
;print(meLH14)
;print(nmbLH14)
;print(nmeLH14)
;print(rLH14)
;print(pLH14)
;print(psig_LH14)

mbLH24=sumdiff_LH24/nLH14
meLH24=sumabsdiff_LH24/nLH14
nmbLH24=100*sumdiff_LH24/sum(newobsLH4(0:127))
nmeLH24=100*sumabsdiff_LH24/sum(newobsLH4(0:127))
rLH24=escorc(newLH24(0:127),newobsLH4(0:127))
tLH24=rLH24*sqrt((nLH14-2)/(1-rLH24^2))
dfLH24=nLH14-2
pLH24=student_t(tLH24,dfLH24) ;test significance level at tLHe 95% level
if (pLH24.le.0.05) then
    psig_LH24="yes"
 else
   psig_LH24="no"
end if



mbLH34=sumdiff_LH34/nLH14
meLH34=sumabsdiff_LH34/nLH14
nmbLH34=100*sumdiff_LH34/sum(newobsLH4(0:127))
nmeLH34=100*sumabsdiff_LH34/sum(newobsLH4(0:127))
rLH34=escorc(newLH34(0:127),newobsLH4(0:127))
tLH34=rLH34*sqrt((nLH14-2)/(1-rLH34^2))
dfLH34=nLH14-2
pLH34=student_t(tLH34,dfLH34) ;test significance level at tLHe 95% level
if (pLH34.le.0.05) then
    psig_LH34="yes"
 else
   psig_LH34="no"
end if

mbLH44=sumdiff_LH44/nLH14
meLH44=sumabsdiff_LH44/nLH14
nmbLH44=100*sumdiff_LH44/sum(newobsLH4(0:127))
nmeLH44=100*sumabsdiff_LH44/sum(newobsLH4(0:127))
rLH44=escorc(newLH44(0:127),newobsLH4(0:127))
tLH44=rLH44*sqrt((nLH14-2)/(1-rLH44^2))
dfLH44=nLH14-2
pLH44=student_t(tLH44,dfLH44) ;test significance level at tLHe 95% level
if (pLH44.le.0.05) then
    psig_LH44="yes"
 else
   psig_LH44="no"
end if

mbLH15=sumdiff_LH15/nLH15
meLH15=sumabsdiff_LH15/nLH15
nmbLH15=100*sumdiff_LH15/sum(newobsLH5(0:127))
nmeLH15=100*sumabsdiff_LH15/sum(newobsLH5(0:127))
rLH15=escorc(newLH15(0:127),newobsLH5(0:127))
tLH15=rLH15*sqrt((nLH15-2)/(1-rLH15^2))
dfLH15=nLH15-2
pLH15=student_t(tLH15,dfLH15) ;test significance level at tLHe 95% level
if (pLH15.le.0.05) then
    psig_LH15="yes"
 else
   psig_LH15="no"
end if
;print(mbLH15)
;print(meLH15)
;print(nmbLH15)
;print(nmeLH15)
;print(rLH15)
;print(pLH15)
;print(psig_LH15)

mbLH25=sumdiff_LH25/nLH15
meLH25=sumabsdiff_LH25/nLH15
nmbLH25=100*sumdiff_LH25/sum(newobsLH5(0:127))
nmeLH25=100*sumabsdiff_LH25/sum(newobsLH5(0:127))
rLH25=escorc(newLH25(0:127),newobsLH5(0:127))
tLH25=rLH25*sqrt((nLH15-2)/(1-rLH25^2))
dfLH25=nLH15-2
pLH25=student_t(tLH25,dfLH25) ;test significance level at tLHe 95% level
if (pLH25.le.0.05) then
    psig_LH25="yes"
 else
   psig_LH25="no"
end if



mbLH35=sumdiff_LH35/nLH15
meLH35=sumabsdiff_LH35/nLH15
nmbLH35=100*sumdiff_LH35/sum(newobsLH5(0:127))
nmeLH35=100*sumabsdiff_LH35/sum(newobsLH5(0:127))
rLH35=escorc(newLH35(0:127),newobsLH5(0:127))
tLH35=rLH35*sqrt((nLH15-2)/(1-rLH35^2))
dfLH35=nLH15-2
pLH35=student_t(tLH35,dfLH35) ;test significance level at tLHe 95% level
if (pLH35.le.0.05) then
    psig_LH35="yes"
 else
   psig_LH35="no"
end if

mbLH45=sumdiff_LH45/nLH15
meLH45=sumabsdiff_LH45/nLH15
nmbLH45=100*sumdiff_LH45/sum(newobsLH5(0:127))
nmeLH45=100*sumabsdiff_LH45/sum(newobsLH5(0:127))
rLH45=escorc(newLH45(0:127),newobsLH5(0:127))
tLH45=rLH45*sqrt((nLH15-2)/(1-rLH45^2))
dfLH45=nLH15-2
pLH45=student_t(tLH45,dfLH45) ;test significance level at tLHe 95% level
if (pLH45.le.0.05) then
    psig_LH45="yes"
 else
   psig_LH45="no"
end if

mbLH16=sumdiff_LH16/nLH16
meLH16=sumabsdiff_LH16/nLH16
nmbLH16=100*sumdiff_LH16/sum(newobsLH6(0:127))
nmeLH16=100*sumabsdiff_LH16/sum(newobsLH6(0:127))
rLH16=escorc(newLH16(0:127),newobsLH6(0:127))
tLH16=rLH16*sqrt((nLH16-2)/(1-rLH16^2))
dfLH16=nLH16-2
pLH16=student_t(tLH16,dfLH16) ;test significance level at tLHe 95% level
if (pLH16.le.0.05) then
    psig_LH16="yes"
 else
   psig_LH16="no"
end if
;print(mbLH16)
;print(meLH16)
;print(nmbLH16)
;print(nmeLH16)
;print(rLH16)
;print(pLH16)
;print(psig_LH16)

mbLH26=sumdiff_LH26/nLH16
meLH26=sumabsdiff_LH26/nLH16
nmbLH26=100*sumdiff_LH26/sum(newobsLH6(0:127))
nmeLH26=100*sumabsdiff_LH26/sum(newobsLH6(0:127))
rLH26=escorc(newLH26(0:127),newobsLH6(0:127))
tLH26=rLH26*sqrt((nLH16-2)/(1-rLH26^2))
dfLH26=nLH16-2
pLH26=student_t(tLH26,dfLH26) ;test significance level at tLHe 95% level
if (pLH26.le.0.05) then
    psig_LH26="yes"
 else
   psig_LH26="no"
end if



mbLH36=sumdiff_LH36/nLH16
meLH36=sumabsdiff_LH36/nLH16
nmbLH36=100*sumdiff_LH36/sum(newobsLH6(0:127))
nmeLH36=100*sumabsdiff_LH36/sum(newobsLH6(0:127))
rLH36=escorc(newLH36(0:127),newobsLH6(0:127))
tLH36=rLH36*sqrt((nLH16-2)/(1-rLH36^2))
dfLH36=nLH16-2
pLH36=student_t(tLH36,dfLH36) ;test significance level at tLHe 95% level
if (pLH36.le.0.05) then
    psig_LH36="yes"
 else
   psig_LH36="no"
end if

mbLH46=sumdiff_LH46/nLH16
meLH46=sumabsdiff_LH46/nLH16
nmbLH46=100*sumdiff_LH46/sum(newobsLH6(0:127))
nmeLH46=100*sumabsdiff_LH46/sum(newobsLH6(0:127))
rLH46=escorc(newLH46(0:127),newobsLH6(0:127))
tLH46=rLH46*sqrt((nLH16-2)/(1-rLH46^2))
dfLH46=nLH16-2
pLH46=student_t(tLH46,dfLH46) ;test significance level at tLHe 95% level
if (pLH46.le.0.05) then
    psig_LH46="yes"
 else
   psig_LH46="no"
end if

mbLH17=sumdiff_LH17/nLH17
meLH17=sumabsdiff_LH17/nLH17
nmbLH17=100*sumdiff_LH17/sum(newobsLH7(0:127))
nmeLH17=100*sumabsdiff_LH17/sum(newobsLH7(0:127))
rLH17=escorc(newLH17(0:127),newobsLH7(0:127))
tLH17=rLH17*sqrt((nLH17-2)/(1-rLH17^2))
dfLH17=nLH17-2
pLH17=student_t(tLH17,dfLH17) ;test significance level at tLHe 95% level
if (pLH17.le.0.05) then
    psig_LH17="yes"
 else
   psig_LH17="no"
end if
;print(mbLH17)
;print(meLH17)
;print(nmbLH17)
;print(nmeLH17)
;print(rLH17)
;print(pLH17)
;print(psig_LH17)

mbLH27=sumdiff_LH27/nLH17
meLH27=sumabsdiff_LH27/nLH17
nmbLH27=100*sumdiff_LH27/sum(newobsLH7(0:127))
nmeLH27=100*sumabsdiff_LH27/sum(newobsLH7(0:127))
rLH27=escorc(newLH27(0:127),newobsLH7(0:127))
tLH27=rLH27*sqrt((nLH17-2)/(1-rLH27^2))
dfLH27=nLH17-2
pLH27=student_t(tLH27,dfLH27) ;test significance level at tLHe 95% level
if (pLH27.le.0.05) then
    psig_LH27="yes"
 else
   psig_LH27="no"
end if



mbLH37=sumdiff_LH37/nLH17
meLH37=sumabsdiff_LH37/nLH17
nmbLH37=100*sumdiff_LH37/sum(newobsLH7(0:127))
nmeLH37=100*sumabsdiff_LH37/sum(newobsLH7(0:127))
rLH37=escorc(newLH37(0:127),newobsLH7(0:127))
tLH37=rLH37*sqrt((nLH17-2)/(1-rLH37^2))
dfLH37=nLH17-2
pLH37=student_t(tLH37,dfLH37) ;test significance level at tLHe 95% level
if (pLH37.le.0.05) then
    psig_LH37="yes"
 else
   psig_LH37="no"
end if

mbLH47=sumdiff_LH47/nLH17
meLH47=sumabsdiff_LH47/nLH17
nmbLH47=100*sumdiff_LH47/sum(newobsLH7(0:127))
nmeLH47=100*sumabsdiff_LH47/sum(newobsLH7(0:127))
rLH47=escorc(newLH47(0:127),newobsLH7(0:127))
tLH47=rLH47*sqrt((nLH17-2)/(1-rLH47^2))
dfLH47=nLH17-2
pLH47=student_t(tLH47,dfLH47) ;test significance level at tLHe 95% level
if (pLH47.le.0.05) then
    psig_LH47="yes"
 else
   psig_LH47="no"
end if

;START DOING STATS FOR UST
do j=0,127,1
 i =count(j)
    print(i)
    if(.not.ismissing(obsust1(i+744)))
     diff_ust11=ust11(i)-obsust1(i+744)
          absdiff_ust11=abs(ust11(i)-obsust1(i+744))
         nust11=nust11+1
        sumdiff_ust11=sumdiff_ust11+diff_ust11
        sumabsdiff_ust11=sumabsdiff_ust11+absdiff_ust11

        diff_ust21=ust21(i)-obsust1(i+744)
        absdiff_ust21=abs(ust21(i)-obsust1(i+744))
        sumdiff_ust21=sumdiff_ust21+diff_ust21
        sumabsdiff_ust21=sumabsdiff_ust21+absdiff_ust21

        diff_ust31=ust31(i)-obsust1(i+744)
        absdiff_ust31=abs(ust31(i)-obsust1(i+744))
        sumdiff_ust31=sumdiff_ust31+diff_ust31
        sumabsdiff_ust31=sumabsdiff_ust31+absdiff_ust31


        diff_ust41=ust41(i)-obsust1(i+744)
        absdiff_ust41=abs(ust41(i)-obsust1(i+744))
        sumdiff_ust41=sumdiff_ust41+diff_ust41
        sumabsdiff_ust41=sumabsdiff_ust41+absdiff_ust41

       end if

        if(.not.ismissing(obsust2(i+744)))
     diff_ust12=ust12(i)-obsust2(i+744)
          absdiff_ust12=abs(ust12(i)-obsust2(i+744))
         nust12=nust12+1
        sumdiff_ust12=sumdiff_ust12+diff_ust12
        sumabsdiff_ust12=sumabsdiff_ust12+absdiff_ust12

        diff_ust22=ust21(i)-obsust2(i+744)
        absdiff_ust22=abs(ust22(i)-obsust2(i+744))
        sumdiff_ust22=sumdiff_ust22+diff_ust22
        sumabsdiff_ust22=sumabsdiff_ust22+absdiff_ust22

        diff_ust32=ust32(i)-obsust2(i+744)
        absdiff_ust32=abs(ust32(i)-obsust2(i+744))
        sumdiff_ust32=sumdiff_ust32+diff_ust32
        sumabsdiff_ust32=sumabsdiff_ust32+absdiff_ust32


        diff_ust42=ust42(i)-obsust2(i+744)
        absdiff_ust42=abs(ust42(i)-obsust2(i+744))
        sumdiff_ust42=sumdiff_ust42+diff_ust42
        sumabsdiff_ust42=sumabsdiff_ust42+absdiff_ust42

       end if

        if(.not.ismissing(obsust3(i+744)))
     diff_ust13=ust13(i)-obsust3(i+744)
          absdiff_ust13=abs(ust13(i)-obsust3(i+744))
         nust13=nust13+1
        sumdiff_ust13=sumdiff_ust13+diff_ust13
        sumabsdiff_ust13=sumabsdiff_ust13+absdiff_ust13

        diff_ust23=ust23(i)-obsust3(i+744)
        absdiff_ust23=abs(ust23(i)-obsust3(i+744))
        sumdiff_ust23=sumdiff_ust23+diff_ust23
        sumabsdiff_ust23=sumabsdiff_ust23+absdiff_ust23

        diff_ust33=ust33(i)-obsust3(i+744)
        absdiff_ust33=abs(ust33(i)-obsust3(i+744))
        sumdiff_ust33=sumdiff_ust33+diff_ust33
        sumabsdiff_ust33=sumabsdiff_ust33+absdiff_ust33


        diff_ust43=ust43(i)-obsust3(i+744)
        absdiff_ust43=abs(ust43(i)-obsust3(i+744))
        sumdiff_ust43=sumdiff_ust43+diff_ust43
        sumabsdiff_ust43=sumabsdiff_ust43+absdiff_ust43

       end if
      if(.not.ismissing(obsust4(i+744)))
     diff_ust14=ust14(i)-obsust4(i+744)
          absdiff_ust14=abs(ust14(i)-obsust4(i+744))
         nust14=nust14+1
        sumdiff_ust14=sumdiff_ust14+diff_ust14
        sumabsdiff_ust14=sumabsdiff_ust14+absdiff_ust14

        diff_ust24=ust24(i)-obsust4(i+744)
        absdiff_ust24=abs(ust24(i)-obsust4(i+744))
        sumdiff_ust24=sumdiff_ust24+diff_ust24
        sumabsdiff_ust24=sumabsdiff_ust24+absdiff_ust24

        diff_ust34=ust34(i)-obsust4(i+744)
        absdiff_ust34=abs(ust34(i)-obsust4(i+744))
        sumdiff_ust34=sumdiff_ust34+diff_ust34
        sumabsdiff_ust34=sumabsdiff_ust34+absdiff_ust34


        diff_ust44=ust44(i)-obsust4(i+744)
        absdiff_ust44=abs(ust44(i)-obsust4(i+744))
        sumdiff_ust44=sumdiff_ust44+diff_ust44
        sumabsdiff_ust44=sumabsdiff_ust44+absdiff_ust44

       end if

         if(.not.ismissing(obsust5(i+744)))
     diff_ust15=ust15(i)-obsust5(i+744)
          absdiff_ust15=abs(ust15(i)-obsust5(i+744))
         nust15=nust15+1
        sumdiff_ust15=sumdiff_ust15+diff_ust15
        sumabsdiff_ust15=sumabsdiff_ust15+absdiff_ust15

        diff_ust25=ust25(i)-obsust5(i+744)
        absdiff_ust25=abs(ust25(i)-obsust5(i+744))
        sumdiff_ust25=sumdiff_ust25+diff_ust25
        sumabsdiff_ust25=sumabsdiff_ust25+absdiff_ust25

        diff_ust35=ust35(i)-obsust5(i+744)
        absdiff_ust35=abs(ust35(i)-obsust5(i+744))
        sumdiff_ust35=sumdiff_ust35+diff_ust35
        sumabsdiff_ust35=sumabsdiff_ust35+absdiff_ust35


        diff_ust45=ust45(i)-obsust5(i+744)
        absdiff_ust45=abs(ust45(i)-obsust5(i+744))
        sumdiff_ust45=sumdiff_ust45+diff_ust45
        sumabsdiff_ust45=sumabsdiff_ust45+absdiff_ust45

       end if

       if(.not.ismissing(obsust6(i+744)))
     diff_ust16=ust16(i)-obsust6(i+744)
          absdiff_ust16=abs(ust16(i)-obsust6(i+744))
         nust16=nust16+1
        sumdiff_ust16=sumdiff_ust16+diff_ust16
        sumabsdiff_ust16=sumabsdiff_ust16+absdiff_ust16

        diff_ust26=ust26(i)-obsust6(i+744)
        absdiff_ust26=abs(ust26(i)-obsust6(i+744))
        sumdiff_ust26=sumdiff_ust26+diff_ust26
        sumabsdiff_ust26=sumabsdiff_ust26+absdiff_ust26

        diff_ust36=ust36(i)-obsust6(i+744)
        absdiff_ust36=abs(ust36(i)-obsust6(i+744))
        sumdiff_ust36=sumdiff_ust36+diff_ust36
        sumabsdiff_ust36=sumabsdiff_ust36+absdiff_ust36


        diff_ust46=ust46(i)-obsust6(i+744)
        absdiff_ust46=abs(ust46(i)-obsust6(i+744))
        sumdiff_ust46=sumdiff_ust46+diff_ust46
        sumabsdiff_ust46=sumabsdiff_ust46+absdiff_ust46

       end if

       if(.not.ismissing(obsust7(i+744)))
     diff_ust17=ust17(i)-obsust7(i+744)
          absdiff_ust17=abs(ust17(i)-obsust7(i+744))
         nust17=nust17+1
        sumdiff_ust17=sumdiff_ust17+diff_ust17
        sumabsdiff_ust17=sumabsdiff_ust17+absdiff_ust17

        diff_ust27=ust27(i)-obsust7(i+744)
        absdiff_ust27=abs(ust27(i)-obsust7(i+744))
        sumdiff_ust27=sumdiff_ust27+diff_ust27
        sumabsdiff_ust27=sumabsdiff_ust27+absdiff_ust27

        diff_ust37=ust37(i)-obsust7(i+744)
        absdiff_ust37=abs(ust37(i)-obsust7(i+744))
        sumdiff_ust37=sumdiff_ust37+diff_ust37
        sumabsdiff_ust37=sumabsdiff_ust37+absdiff_ust37


        diff_ust47=ust47(i)-obsust7(i+744)
        absdiff_ust47=abs(ust47(i)-obsust7(i+744))
        sumdiff_ust47=sumdiff_ust47+diff_ust47
        sumabsdiff_ust47=sumabsdiff_ust47+absdiff_ust47

       end if

end do
;print(nust11)
mbust11=sumdiff_ust11/nust11
meust11=sumabsdiff_ust11/nust11
nmbust11=100*sumdiff_ust11/sum(newobsust1(0:127))
nmeust11=100*sumabsdiff_ust11/sum(newobsust1(0:127))

rust11=escorc(newust11(0:127),newobsust1(0:127))
tust11=rust11*sqrt((nust11-2)/(1-rust11^2))
dfust11=nust11-2
pust11=student_t(tust11,dfust11) ;test significance level at tuste 95% level
if (pust11.le.0.05) then
    psig_ust11="yes"
 else
   psig_ust11="no"
end if
;print(mbust11)
;print(meust11)
;print(nmbust11)
;print(nmeust11)
;print(rust11)
;print(pust11)
;print(psig_ust11)

mbust21=sumdiff_ust21/nust11
meust21=sumabsdiff_ust21/nust11
nmbust21=100*sumdiff_ust21/sum(newobsust1(0:127))
nmeust21=100*sumabsdiff_ust21/sum(newobsust1(0:127))
rust21=escorc(newust21(0:127),newobsust1(0:127))
tust21=rust21*sqrt((nust11-2)/(1-rust21^2))
dfust21=nust11-2
pust21=student_t(tust21,dfust21) ;test significance level at tuste 95% level
if (pust21.le.0.05) then
    psig_ust21="yes"
 else
   psig_ust21="no"
end if



mbust31=sumdiff_ust31/nust11
meust31=sumabsdiff_ust31/nust11
nmbust31=100*sumdiff_ust31/sum(newobsust1(0:127))
nmeust31=100*sumabsdiff_ust31/sum(newobsust1(0:127))
rust31=escorc(newust31(0:127),newobsust1(0:127))
tust31=rust31*sqrt((nust11-2)/(1-rust31^2))
dfust31=nust11-2
pust31=student_t(tust31,dfust31) ;test significance level at tuste 95% level
if (pust31.le.0.05) then
    psig_ust31="yes"
 else
   psig_ust31="no"
end if

mbust41=sumdiff_ust41/nust11
meust41=sumabsdiff_ust41/nust11
nmbust41=100*sumdiff_ust41/sum(newobsust1(0:127))
nmeust41=100*sumabsdiff_ust41/sum(newobsust1(0:127))
rust41=escorc(newust41(0:127),newobsust1(0:127))
tust41=rust41*sqrt((nust11-2)/(1-rust41^2))
dfust41=nust11-2
pust41=student_t(tust41,dfust41) ;test significance level at tuste 95% level
if (pust41.le.0.05) then
    psig_ust41="yes"
 else
   psig_ust41="no"
end if


mbust12=sumdiff_ust12/nust12
meust12=sumabsdiff_ust12/nust12
nmbust12=100*sumdiff_ust12/sum(newobsust2(0:127))
nmeust12=100*sumabsdiff_ust12/sum(newobsust2(0:127))
rust12=escorc(newust12(0:127),newobsust2(0:127))
tust12=rust12*sqrt((nust12-2)/(1-rust12^2))
dfust12=nust12-2
pust12=student_t(tust12,dfust12) ;test significance level at tuste 95% level
if (pust12.le.0.05) then
    psig_ust12="yes"
 else
   psig_ust12="no"
end if
;print(mbust12)
;print(meust12)
;print(nmbust12)
;print(nmeust12)
;print(rust12)
;print(pust12)
;print(psig_ust12)

mbust22=sumdiff_ust22/nust12
meust22=sumabsdiff_ust22/nust12
nmbust22=100*sumdiff_ust22/sum(newobsust2(0:127))
nmeust22=100*sumabsdiff_ust22/sum(newobsust2(0:127))
rust22=escorc(newust22(0:127),newobsust2(0:127))
tust22=rust22*sqrt((nust12-2)/(1-rust22^2))
dfust22=nust12-2
pust22=student_t(tust22,dfust22) ;test significance level at tuste 95% level
if (pust22.le.0.05) then
    psig_ust22="yes"
 else
   psig_ust22="no"
end if



mbust32=sumdiff_ust32/nust12
meust32=sumabsdiff_ust32/nust12
nmbust32=100*sumdiff_ust32/sum(newobsust2(0:127))
nmeust32=100*sumabsdiff_ust32/sum(newobsust2(0:127))
rust32=escorc(newust32(0:127),newobsust2(0:127))
tust32=rust32*sqrt((nust12-2)/(1-rust32^2))
dfust32=nust12-2
pust32=student_t(tust32,dfust32) ;test significance level at tuste 95% level
if (pust32.le.0.05) then
    psig_ust32="yes"
 else
   psig_ust32="no"
end if

mbust42=sumdiff_ust42/nust12
meust42=sumabsdiff_ust42/nust12
nmbust42=100*sumdiff_ust42/sum(newobsust2(0:127))
nmeust42=100*sumabsdiff_ust42/sum(newobsust2(0:127))
rust42=escorc(newust42(0:127),newobsust2(0:127))
tust42=rust42*sqrt((nust12-2)/(1-rust42^2))
dfust42=nust12-2
pust42=student_t(tust42,dfust42) ;test significance level at tuste 95% level
if (pust42.le.0.05) then
    psig_ust42="yes"
 else
   psig_ust42="no"
end if

mbust13=sumdiff_ust13/nust13
meust13=sumabsdiff_ust13/nust13
nmbust13=100*sumdiff_ust13/sum(newobsust3(0:127))
nmeust13=100*sumabsdiff_ust13/sum(newobsust3(0:127))
rust13=escorc(newust13(0:127),newobsust3(0:127))
tust13=rust13*sqrt((nust13-2)/(1-rust13^2))
dfust13=nust13-2
pust13=student_t(tust13,dfust13) ;test significance level at tuste 95% level
if (pust13.le.0.05) then
    psig_ust13="yes"
 else
   psig_ust13="no"
end if
;print(mbust13)
;print(meust13)
;print(nmbust13)
;print(nmeust13)
;print(rust13)
;print(pust13)
;print(psig_ust13)

mbust23=sumdiff_ust23/nust13
meust23=sumabsdiff_ust23/nust13
nmbust23=100*sumdiff_ust23/sum(newobsust3(0:127))
nmeust23=100*sumabsdiff_ust23/sum(newobsust3(0:127))
rust23=escorc(newust23(0:127),newobsust3(0:127))
tust23=rust23*sqrt((nust13-2)/(1-rust23^2))
dfust23=nust13-2
pust23=student_t(tust23,dfust23) ;test significance level at tuste 95% level
if (pust23.le.0.05) then
    psig_ust23="yes"
 else
   psig_ust23="no"
end if



mbust33=sumdiff_ust33/nust13
meust33=sumabsdiff_ust33/nust13
nmbust33=100*sumdiff_ust33/sum(newobsust3(0:127))
nmeust33=100*sumabsdiff_ust33/sum(newobsust3(0:127))
rust33=escorc(newust33(0:127),newobsust3(0:127))
tust33=rust33*sqrt((nust13-2)/(1-rust33^2))
dfust33=nust13-2
pust33=student_t(tust33,dfust33) ;test significance level at tuste 95% level
if (pust33.le.0.05) then
    psig_ust33="yes"
 else
   psig_ust33="no"
end if

mbust43=sumdiff_ust43/nust13
meust43=sumabsdiff_ust43/nust13
nmbust43=100*sumdiff_ust43/sum(newobsust3(0:127))
nmeust43=100*sumabsdiff_ust43/sum(newobsust3(0:127))
rust43=escorc(newust43(0:127),newobsust3(0:127))
tust43=rust43*sqrt((nust13-2)/(1-rust43^2))
dfust43=nust13-2
pust43=student_t(tust43,dfust43) ;test significance level at tuste 95% level
if (pust43.le.0.05) then
    psig_ust43="yes"
 else
   psig_ust43="no"
end if

mbust14=sumdiff_ust14/nust14
meust14=sumabsdiff_ust14/nust14
nmbust14=100*sumdiff_ust14/sum(newobsust4(0:127))
nmeust14=100*sumabsdiff_ust14/sum(newobsust4(0:127))
rust14=escorc(newust14(0:127),newobsust4(0:127))
tust14=rust14*sqrt((nust14-2)/(1-rust14^2))
dfust14=nust14-2
pust14=student_t(tust14,dfust14) ;test significance level at tuste 95% level
if (pust14.le.0.05) then
    psig_ust14="yes"
 else
   psig_ust14="no"
end if
;print(mbust14)
;print(meust14)
;print(nmbust14)
;print(nmeust14)
;print(rust14)
;print(pust14)
;print(psig_ust14)

mbust24=sumdiff_ust24/nust14
meust24=sumabsdiff_ust24/nust14
nmbust24=100*sumdiff_ust24/sum(newobsust4(0:127))
nmeust24=100*sumabsdiff_ust24/sum(newobsust4(0:127))
rust24=escorc(newust24(0:127),newobsust4(0:127))
tust24=rust24*sqrt((nust14-2)/(1-rust24^2))
dfust24=nust14-2
pust24=student_t(tust24,dfust24) ;test significance level at tuste 95% level
if (pust24.le.0.05) then
    psig_ust24="yes"
 else
   psig_ust24="no"
end if



mbust34=sumdiff_ust34/nust14
meust34=sumabsdiff_ust34/nust14
nmbust34=100*sumdiff_ust34/sum(newobsust4(0:127))
nmeust34=100*sumabsdiff_ust34/sum(newobsust4(0:127))
rust34=escorc(newust34(0:127),newobsust4(0:127))
tust34=rust34*sqrt((nust14-2)/(1-rust34^2))
dfust34=nust14-2
pust34=student_t(tust34,dfust34) ;test significance level at tuste 95% level
if (pust34.le.0.05) then
    psig_ust34="yes"
 else
   psig_ust34="no"
end if

mbust44=sumdiff_ust44/nust14
meust44=sumabsdiff_ust44/nust14
nmbust44=100*sumdiff_ust44/sum(newobsust4(0:127))
nmeust44=100*sumabsdiff_ust44/sum(newobsust4(0:127))
rust44=escorc(newust44(0:127),newobsust4(0:127))
tust44=rust44*sqrt((nust14-2)/(1-rust44^2))
dfust44=nust14-2
pust44=student_t(tust44,dfust44) ;test significance level at tuste 95% level
if (pust44.le.0.05) then
    psig_ust44="yes"
 else
   psig_ust44="no"
end if

mbust15=sumdiff_ust15/nust15
meust15=sumabsdiff_ust15/nust15
nmbust15=100*sumdiff_ust15/sum(newobsust5(0:127))
nmeust15=100*sumabsdiff_ust15/sum(newobsust5(0:127))
rust15=escorc(newust15(0:127),newobsust5(0:127))
tust15=rust15*sqrt((nust15-2)/(1-rust15^2))
dfust15=nust15-2
pust15=student_t(tust15,dfust15) ;test significance level at tuste 95% level
if (pust15.le.0.05) then
    psig_ust15="yes"
 else
   psig_ust15="no"
end if
;print(mbust15)
;print(meust15)
;print(nmbust15)
;print(nmeust15)
;print(rust15)
;print(pust15)
;print(psig_ust15)

mbust25=sumdiff_ust25/nust15
meust25=sumabsdiff_ust25/nust15
nmbust25=100*sumdiff_ust25/sum(newobsust5(0:127))
nmeust25=100*sumabsdiff_ust25/sum(newobsust5(0:127))
rust25=escorc(newust25(0:127),newobsust5(0:127))
tust25=rust25*sqrt((nust15-2)/(1-rust25^2))
dfust25=nust15-2
pust25=student_t(tust25,dfust25) ;test significance level at tuste 95% level
if (pust25.le.0.05) then
    psig_ust25="yes"
 else
   psig_ust25="no"
end if



mbust35=sumdiff_ust35/nust15
meust35=sumabsdiff_ust35/nust15
nmbust35=100*sumdiff_ust35/sum(newobsust5(0:127))
nmeust35=100*sumabsdiff_ust35/sum(newobsust5(0:127))
rust35=escorc(newust35(0:127),newobsust5(0:127))
tust35=rust35*sqrt((nust15-2)/(1-rust35^2))
dfust35=nust15-2
pust35=student_t(tust35,dfust35) ;test significance level at tuste 95% level
if (pust35.le.0.05) then
    psig_ust35="yes"
 else
   psig_ust35="no"
end if

mbust45=sumdiff_ust45/nust15
meust45=sumabsdiff_ust45/nust15
nmbust45=100*sumdiff_ust45/sum(newobsust5(0:127))
nmeust45=100*sumabsdiff_ust45/sum(newobsust5(0:127))
rust45=escorc(newust45(0:127),newobsust5(0:127))
tust45=rust45*sqrt((nust15-2)/(1-rust45^2))
dfust45=nust15-2
pust45=student_t(tust45,dfust45) ;test significance level at tuste 95% level
if (pust45.le.0.05) then
    psig_ust45="yes"
 else
   psig_ust45="no"
end if

mbust16=sumdiff_ust16/nust16
meust16=sumabsdiff_ust16/nust16
nmbust16=100*sumdiff_ust16/sum(newobsust6(0:127))
nmeust16=100*sumabsdiff_ust16/sum(newobsust6(0:127))
rust16=escorc(newust16(0:127),newobsust6(0:127))
tust16=rust16*sqrt((nust16-2)/(1-rust16^2))
dfust16=nust16-2
pust16=student_t(tust16,dfust16) ;test significance level at tuste 95% level
if (pust16.le.0.05) then
    psig_ust16="yes"
 else
   psig_ust16="no"
end if
;print(mbust16)
;print(meust16)
;print(nmbust16)
;print(nmeust16)
;print(rust16)
;print(pust16)
;print(psig_ust16)

mbust26=sumdiff_ust26/nust16
meust26=sumabsdiff_ust26/nust16
nmbust26=100*sumdiff_ust26/sum(newobsust6(0:127))
nmeust26=100*sumabsdiff_ust26/sum(newobsust6(0:127))
rust26=escorc(newust26(0:127),newobsust6(0:127))
tust26=rust26*sqrt((nust16-2)/(1-rust26^2))
dfust26=nust16-2
pust26=student_t(tust26,dfust26) ;test significance level at tuste 95% level
if (pust26.le.0.05) then
    psig_ust26="yes"
 else
   psig_ust26="no"
end if



mbust36=sumdiff_ust36/nust16
meust36=sumabsdiff_ust36/nust16
nmbust36=100*sumdiff_ust36/sum(newobsust6(0:127))
nmeust36=100*sumabsdiff_ust36/sum(newobsust6(0:127))
rust36=escorc(newust36(0:127),newobsust6(0:127))
tust36=rust36*sqrt((nust16-2)/(1-rust36^2))
dfust36=nust16-2
pust36=student_t(tust36,dfust36) ;test significance level at tuste 95% level
if (pust36.le.0.05) then
    psig_ust36="yes"
 else
   psig_ust36="no"
end if

mbust46=sumdiff_ust46/nust16
meust46=sumabsdiff_ust46/nust16
nmbust46=100*sumdiff_ust46/sum(newobsust6(0:127))
nmeust46=100*sumabsdiff_ust46/sum(newobsust6(0:127))
rust46=escorc(newust46(0:127),newobsust6(0:127))
tust46=rust46*sqrt((nust16-2)/(1-rust46^2))
dfust46=nust16-2
pust46=student_t(tust46,dfust46) ;test significance level at tuste 95% level
if (pust46.le.0.05) then
    psig_ust46="yes"
 else
   psig_ust46="no"
end if

mbust17=sumdiff_ust17/nust17
meust17=sumabsdiff_ust17/nust17
nmbust17=100*sumdiff_ust17/sum(newobsust7(0:127))
nmeust17=100*sumabsdiff_ust17/sum(newobsust7(0:127))
rust17=escorc(newust17(0:127),newobsust7(0:127))
tust17=rust17*sqrt((nust17-2)/(1-rust17^2))
dfust17=nust17-2
pust17=student_t(tust17,dfust17) ;test significance level at tuste 95% level
if (pust17.le.0.05) then
    psig_ust17="yes"
 else
   psig_ust17="no"
end if
;print(mbust17)
;print(meust17)
;print(nmbust17)
;print(nmeust17)
;print(rust17)
;print(pust17)
;print(psig_ust17)

mbust27=sumdiff_ust27/nust17
meust27=sumabsdiff_ust27/nust17
nmbust27=100*sumdiff_ust27/sum(newobsust7(0:127))
nmeust27=100*sumabsdiff_ust27/sum(newobsust7(0:127))
rust27=escorc(newust27(0:127),newobsust7(0:127))
tust27=rust27*sqrt((nust17-2)/(1-rust27^2))
dfust27=nust17-2
pust27=student_t(tust27,dfust27) ;test significance level at tuste 95% level
if (pust27.le.0.05) then
    psig_ust27="yes"
 else
   psig_ust27="no"
end if



mbust37=sumdiff_ust37/nust17
meust37=sumabsdiff_ust37/nust17
nmbust37=100*sumdiff_ust37/sum(newobsust7(0:127))
nmeust37=100*sumabsdiff_ust37/sum(newobsust7(0:127))
rust37=escorc(newust37(0:127),newobsust7(0:127))
tust37=rust37*sqrt((nust17-2)/(1-rust37^2))
dfust37=nust17-2
pust37=student_t(tust37,dfust37) ;test significance level at tuste 95% level
if (pust37.le.0.05) then
    psig_ust37="yes"
 else
   psig_ust37="no"
end if

mbust47=sumdiff_ust47/nust17
meust47=sumabsdiff_ust47/nust17
nmbust47=100*sumdiff_ust47/sum(newobsust7(0:127))
nmeust47=100*sumabsdiff_ust47/sum(newobsust7(0:127))
rust47=escorc(newust47(0:127),newobsust7(0:127))
tust47=rust47*sqrt((nust17-2)/(1-rust47^2))
dfust47=nust17-2
pust47=student_t(tust47,dfust47) ;test significance level at tuste 95% level
if (pust47.le.0.05) then
    psig_ust47="yes"
 else
   psig_ust47="no"
end if


;START DOING STATS FOR RN
do j=0,127,1
 i =count(j)
    print(i)
    if(.not.ismissing(obsRn1(i+744)))
     diff_Rn11=Rn11(i)-obsRn1(i+744)
          absdiff_Rn11=abs(Rn11(i)-obsRn1(i+744))
         nRn11=nRn11+1
        sumdiff_Rn11=sumdiff_Rn11+diff_Rn11
        sumabsdiff_Rn11=sumabsdiff_Rn11+absdiff_Rn11

        diff_Rn21=Rn21(i)-obsRn1(i+744)
        absdiff_Rn21=abs(Rn21(i)-obsRn1(i+744))
        sumdiff_Rn21=sumdiff_Rn21+diff_Rn21
        sumabsdiff_Rn21=sumabsdiff_Rn21+absdiff_Rn21

        diff_Rn31=Rn31(i)-obsRn1(i+744)
        absdiff_Rn31=abs(Rn31(i)-obsRn1(i+744))
        sumdiff_Rn31=sumdiff_Rn31+diff_Rn31
        sumabsdiff_Rn31=sumabsdiff_Rn31+absdiff_Rn31


        diff_Rn41=Rn41(i)-obsRn1(i+744)
        absdiff_Rn41=abs(Rn41(i)-obsRn1(i+744))
        sumdiff_Rn41=sumdiff_Rn41+diff_Rn41
        sumabsdiff_Rn41=sumabsdiff_Rn41+absdiff_Rn41

       end if

        if(.not.ismissing(obsRn2(i+744)))
     diff_Rn12=Rn12(i)-obsRn2(i+744)
          absdiff_Rn12=abs(Rn12(i)-obsRn2(i+744))
         nRn12=nRn12+1
        sumdiff_Rn12=sumdiff_Rn12+diff_Rn12
        sumabsdiff_Rn12=sumabsdiff_Rn12+absdiff_Rn12

        diff_Rn22=Rn21(i)-obsRn2(i+744)
        absdiff_Rn22=abs(Rn22(i)-obsRn2(i+744))
        sumdiff_Rn22=sumdiff_Rn22+diff_Rn22
        sumabsdiff_Rn22=sumabsdiff_Rn22+absdiff_Rn22

        diff_Rn32=Rn32(i)-obsRn2(i+744)
        absdiff_Rn32=abs(Rn32(i)-obsRn2(i+744))
        sumdiff_Rn32=sumdiff_Rn32+diff_Rn32
        sumabsdiff_Rn32=sumabsdiff_Rn32+absdiff_Rn32


        diff_Rn42=Rn42(i)-obsRn2(i+744)
        absdiff_Rn42=abs(Rn42(i)-obsRn2(i+744))
        sumdiff_Rn42=sumdiff_Rn42+diff_Rn42
        sumabsdiff_Rn42=sumabsdiff_Rn42+absdiff_Rn42

       end if

        if(.not.ismissing(obsRn3(i+744)))
     diff_Rn13=Rn13(i)-obsRn3(i+744)
          absdiff_Rn13=abs(Rn13(i)-obsRn3(i+744))
         nRn13=nRn13+1
        sumdiff_Rn13=sumdiff_Rn13+diff_Rn13
        sumabsdiff_Rn13=sumabsdiff_Rn13+absdiff_Rn13

        diff_Rn23=Rn23(i)-obsRn3(i+744)
        absdiff_Rn23=abs(Rn23(i)-obsRn3(i+744))
        sumdiff_Rn23=sumdiff_Rn23+diff_Rn23
        sumabsdiff_Rn23=sumabsdiff_Rn23+absdiff_Rn23

        diff_Rn33=Rn33(i)-obsRn3(i+744)
        absdiff_Rn33=abs(Rn33(i)-obsRn3(i+744))
        sumdiff_Rn33=sumdiff_Rn33+diff_Rn33
        sumabsdiff_Rn33=sumabsdiff_Rn33+absdiff_Rn33


        diff_Rn43=Rn43(i)-obsRn3(i+744)
        absdiff_Rn43=abs(Rn43(i)-obsRn3(i+744))
        sumdiff_Rn43=sumdiff_Rn43+diff_Rn43
        sumabsdiff_Rn43=sumabsdiff_Rn43+absdiff_Rn43

       end if
      if(.not.ismissing(obsRn4(i+744)))
     diff_Rn14=Rn14(i)-obsRn4(i+744)
          absdiff_Rn14=abs(Rn14(i)-obsRn4(i+744))
         nRn14=nRn14+1
        sumdiff_Rn14=sumdiff_Rn14+diff_Rn14
        sumabsdiff_Rn14=sumabsdiff_Rn14+absdiff_Rn14

        diff_Rn24=Rn24(i)-obsRn4(i+744)
        absdiff_Rn24=abs(Rn24(i)-obsRn4(i+744))
        sumdiff_Rn24=sumdiff_Rn24+diff_Rn24
        sumabsdiff_Rn24=sumabsdiff_Rn24+absdiff_Rn24

        diff_Rn34=Rn34(i)-obsRn4(i+744)
        absdiff_Rn34=abs(Rn34(i)-obsRn4(i+744))
        sumdiff_Rn34=sumdiff_Rn34+diff_Rn34
        sumabsdiff_Rn34=sumabsdiff_Rn34+absdiff_Rn34


        diff_Rn44=Rn44(i)-obsRn4(i+744)
        absdiff_Rn44=abs(Rn44(i)-obsRn4(i+744))
        sumdiff_Rn44=sumdiff_Rn44+diff_Rn44
        sumabsdiff_Rn44=sumabsdiff_Rn44+absdiff_Rn44

       end if

         if(.not.ismissing(obsRn5(i+744)))
     diff_Rn15=Rn15(i)-obsRn5(i+744)
          absdiff_Rn15=abs(Rn15(i)-obsRn5(i+744))
         nRn15=nRn15+1
        sumdiff_Rn15=sumdiff_Rn15+diff_Rn15
        sumabsdiff_Rn15=sumabsdiff_Rn15+absdiff_Rn15

        diff_Rn25=Rn25(i)-obsRn5(i+744)
        absdiff_Rn25=abs(Rn25(i)-obsRn5(i+744))
        sumdiff_Rn25=sumdiff_Rn25+diff_Rn25
        sumabsdiff_Rn25=sumabsdiff_Rn25+absdiff_Rn25

        diff_Rn35=Rn35(i)-obsRn5(i+744)
        absdiff_Rn35=abs(Rn35(i)-obsRn5(i+744))
        sumdiff_Rn35=sumdiff_Rn35+diff_Rn35
        sumabsdiff_Rn35=sumabsdiff_Rn35+absdiff_Rn35


        diff_Rn45=Rn45(i)-obsRn5(i+744)
        absdiff_Rn45=abs(Rn45(i)-obsRn5(i+744))
        sumdiff_Rn45=sumdiff_Rn45+diff_Rn45
        sumabsdiff_Rn45=sumabsdiff_Rn45+absdiff_Rn45

       end if

       if(.not.ismissing(obsRn6(i+744)))
     diff_Rn16=Rn16(i)-obsRn6(i+744)
          absdiff_Rn16=abs(Rn16(i)-obsRn6(i+744))
         nRn16=nRn16+1
        sumdiff_Rn16=sumdiff_Rn16+diff_Rn16
        sumabsdiff_Rn16=sumabsdiff_Rn16+absdiff_Rn16

        diff_Rn26=Rn26(i)-obsRn6(i+744)
        absdiff_Rn26=abs(Rn26(i)-obsRn6(i+744))
        sumdiff_Rn26=sumdiff_Rn26+diff_Rn26
        sumabsdiff_Rn26=sumabsdiff_Rn26+absdiff_Rn26

        diff_Rn36=Rn36(i)-obsRn6(i+744)
        absdiff_Rn36=abs(Rn36(i)-obsRn6(i+744))
        sumdiff_Rn36=sumdiff_Rn36+diff_Rn36
        sumabsdiff_Rn36=sumabsdiff_Rn36+absdiff_Rn36


        diff_Rn46=Rn46(i)-obsRn6(i+744)
        absdiff_Rn46=abs(Rn46(i)-obsRn6(i+744))
        sumdiff_Rn46=sumdiff_Rn46+diff_Rn46
        sumabsdiff_Rn46=sumabsdiff_Rn46+absdiff_Rn46

       end if

       if(.not.ismissing(obsRn7(i+744)))
     diff_Rn17=Rn17(i)-obsRn7(i+744)
          absdiff_Rn17=abs(Rn17(i)-obsRn7(i+744))
         nRn17=nRn17+1
        sumdiff_Rn17=sumdiff_Rn17+diff_Rn17
        sumabsdiff_Rn17=sumabsdiff_Rn17+absdiff_Rn17

        diff_Rn27=Rn27(i)-obsRn7(i+744)
        absdiff_Rn27=abs(Rn27(i)-obsRn7(i+744))
        sumdiff_Rn27=sumdiff_Rn27+diff_Rn27
        sumabsdiff_Rn27=sumabsdiff_Rn27+absdiff_Rn27

        diff_Rn37=Rn37(i)-obsRn7(i+744)
        absdiff_Rn37=abs(Rn37(i)-obsRn7(i+744))
        sumdiff_Rn37=sumdiff_Rn37+diff_Rn37
        sumabsdiff_Rn37=sumabsdiff_Rn37+absdiff_Rn37


        diff_Rn47=Rn47(i)-obsRn7(i+744)
        absdiff_Rn47=abs(Rn47(i)-obsRn7(i+744))
        sumdiff_Rn47=sumdiff_Rn47+diff_Rn47
        sumabsdiff_Rn47=sumabsdiff_Rn47+absdiff_Rn47

       end if

end do
;print(nRn11)
mbRn11=sumdiff_Rn11/nRn11
meRn11=sumabsdiff_Rn11/nRn11
nmbRn11=100*sumdiff_Rn11/sum(newobsRn1(0:127))
nmeRn11=100*sumabsdiff_Rn11/sum(newobsRn1(0:127))

rRn11=escorc(newRn11(0:127),newobsRn1(0:127))
tRn11=rRn11*sqrt((nRn11-2)/(1-rRn11^2))
dfRn11=nRn11-2
pRn11=student_t(tRn11,dfRn11) ;test significance level at tRne 95% level
if (pRn11.le.0.05) then
    psig_Rn11="yes"
 else
   psig_Rn11="no"
end if
;print(mbRn11)
;print(meRn11)
;print(nmbRn11)
;print(nmeRn11)
;print(rRn11)
;print(pRn11)
;print(psig_Rn11)

mbRn21=sumdiff_Rn21/nRn11
meRn21=sumabsdiff_Rn21/nRn11
nmbRn21=100*sumdiff_Rn21/sum(newobsRn1(0:127))
nmeRn21=100*sumabsdiff_Rn21/sum(newobsRn1(0:127))
rRn21=escorc(newRn21(0:127),newobsRn1(0:127))
tRn21=rRn21*sqrt((nRn11-2)/(1-rRn21^2))
dfRn21=nRn11-2
pRn21=student_t(tRn21,dfRn21) ;test significance level at tRne 95% level
if (pRn21.le.0.05) then
    psig_Rn21="yes"
 else
   psig_Rn21="no"
end if



mbRn31=sumdiff_Rn31/nRn11
meRn31=sumabsdiff_Rn31/nRn11
nmbRn31=100*sumdiff_Rn31/sum(newobsRn1(0:127))
nmeRn31=100*sumabsdiff_Rn31/sum(newobsRn1(0:127))
rRn31=escorc(newRn31(0:127),newobsRn1(0:127))
tRn31=rRn31*sqrt((nRn11-2)/(1-rRn31^2))
dfRn31=nRn11-2
pRn31=student_t(tRn31,dfRn31) ;test significance level at tRne 95% level
if (pRn31.le.0.05) then
    psig_Rn31="yes"
 else
   psig_Rn31="no"
end if

mbRn41=sumdiff_Rn41/nRn11
meRn41=sumabsdiff_Rn41/nRn11
nmbRn41=100*sumdiff_Rn41/sum(newobsRn1(0:127))
nmeRn41=100*sumabsdiff_Rn41/sum(newobsRn1(0:127))
rRn41=escorc(newRn41(0:127),newobsRn1(0:127))
tRn41=rRn41*sqrt((nRn11-2)/(1-rRn41^2))
dfRn41=nRn11-2
pRn41=student_t(tRn41,dfRn41) ;test significance level at tRne 95% level
if (pRn41.le.0.05) then
    psig_Rn41="yes"
 else
   psig_Rn41="no"
end if


mbRn12=sumdiff_Rn12/nRn12
meRn12=sumabsdiff_Rn12/nRn12
nmbRn12=100*sumdiff_Rn12/sum(newobsRn2(0:127))
nmeRn12=100*sumabsdiff_Rn12/sum(newobsRn2(0:127))
rRn12=escorc(newRn12(0:127),newobsRn2(0:127))
tRn12=rRn12*sqrt((nRn12-2)/(1-rRn12^2))
dfRn12=nRn12-2
pRn12=student_t(tRn12,dfRn12) ;test significance level at tRne 95% level
if (pRn12.le.0.05) then
    psig_Rn12="yes"
 else
   psig_Rn12="no"
end if
;print(mbRn12)
;print(meRn12)
;print(nmbRn12)
;print(nmeRn12)
;print(rRn12)
;print(pRn12)
;print(psig_Rn12)

mbRn22=sumdiff_Rn22/nRn12
meRn22=sumabsdiff_Rn22/nRn12
nmbRn22=100*sumdiff_Rn22/sum(newobsRn2(0:127))
nmeRn22=100*sumabsdiff_Rn22/sum(newobsRn2(0:127))
rRn22=escorc(newRn22(0:127),newobsRn2(0:127))
tRn22=rRn22*sqrt((nRn12-2)/(1-rRn22^2))
dfRn22=nRn12-2
pRn22=student_t(tRn22,dfRn22) ;test significance level at tRne 95% level
if (pRn22.le.0.05) then
    psig_Rn22="yes"
 else
   psig_Rn22="no"
end if



mbRn32=sumdiff_Rn32/nRn12
meRn32=sumabsdiff_Rn32/nRn12
nmbRn32=100*sumdiff_Rn32/sum(newobsRn2(0:127))
nmeRn32=100*sumabsdiff_Rn32/sum(newobsRn2(0:127))
rRn32=escorc(newRn32(0:127),newobsRn2(0:127))
tRn32=rRn32*sqrt((nRn12-2)/(1-rRn32^2))
dfRn32=nRn12-2
pRn32=student_t(tRn32,dfRn32) ;test significance level at tRne 95% level
if (pRn32.le.0.05) then
    psig_Rn32="yes"
 else
   psig_Rn32="no"
end if

mbRn42=sumdiff_Rn42/nRn12
meRn42=sumabsdiff_Rn42/nRn12
nmbRn42=100*sumdiff_Rn42/sum(newobsRn2(0:127))
nmeRn42=100*sumabsdiff_Rn42/sum(newobsRn2(0:127))
rRn42=escorc(newRn42(0:127),newobsRn2(0:127))
tRn42=rRn42*sqrt((nRn12-2)/(1-rRn42^2))
dfRn42=nRn12-2
pRn42=student_t(tRn42,dfRn42) ;test significance level at tRne 95% level
if (pRn42.le.0.05) then
    psig_Rn42="yes"
 else
   psig_Rn42="no"
end if

mbRn13=sumdiff_Rn13/nRn13
meRn13=sumabsdiff_Rn13/nRn13
nmbRn13=100*sumdiff_Rn13/sum(newobsRn3(0:127))
nmeRn13=100*sumabsdiff_Rn13/sum(newobsRn3(0:127))
rRn13=escorc(newRn13(0:127),newobsRn3(0:127))
tRn13=rRn13*sqrt((nRn13-2)/(1-rRn13^2))
dfRn13=nRn13-2
pRn13=student_t(tRn13,dfRn13) ;test significance level at tRne 95% level
if (pRn13.le.0.05) then
    psig_Rn13="yes"
 else
   psig_Rn13="no"
end if
;print(mbRn13)
;print(meRn13)
;print(nmbRn13)
;print(nmeRn13)
;print(rRn13)
;print(pRn13)
;print(psig_Rn13)

mbRn23=sumdiff_Rn23/nRn13
meRn23=sumabsdiff_Rn23/nRn13
nmbRn23=100*sumdiff_Rn23/sum(newobsRn3(0:127))
nmeRn23=100*sumabsdiff_Rn23/sum(newobsRn3(0:127))
rRn23=escorc(newRn23(0:127),newobsRn3(0:127))
tRn23=rRn23*sqrt((nRn13-2)/(1-rRn23^2))
dfRn23=nRn13-2
pRn23=student_t(tRn23,dfRn23) ;test significance level at tRne 95% level
if (pRn23.le.0.05) then
    psig_Rn23="yes"
 else
   psig_Rn23="no"
end if



mbRn33=sumdiff_Rn33/nRn13
meRn33=sumabsdiff_Rn33/nRn13
nmbRn33=100*sumdiff_Rn33/sum(newobsRn3(0:127))
nmeRn33=100*sumabsdiff_Rn33/sum(newobsRn3(0:127))
rRn33=escorc(newRn33(0:127),newobsRn3(0:127))
tRn33=rRn33*sqrt((nRn13-2)/(1-rRn33^2))
dfRn33=nRn13-2
pRn33=student_t(tRn33,dfRn33) ;test significance level at tRne 95% level
if (pRn33.le.0.05) then
    psig_Rn33="yes"
 else
   psig_Rn33="no"
end if

mbRn43=sumdiff_Rn43/nRn13
meRn43=sumabsdiff_Rn43/nRn13
nmbRn43=100*sumdiff_Rn43/sum(newobsRn3(0:127))
nmeRn43=100*sumabsdiff_Rn43/sum(newobsRn3(0:127))
rRn43=escorc(newRn43(0:127),newobsRn3(0:127))
tRn43=rRn43*sqrt((nRn13-2)/(1-rRn43^2))
dfRn43=nRn13-2
pRn43=student_t(tRn43,dfRn43) ;test significance level at tRne 95% level
if (pRn43.le.0.05) then
    psig_Rn43="yes"
 else
   psig_Rn43="no"
end if

mbRn14=sumdiff_Rn14/nRn14
meRn14=sumabsdiff_Rn14/nRn14
nmbRn14=100*sumdiff_Rn14/sum(newobsRn4(0:127))
nmeRn14=100*sumabsdiff_Rn14/sum(newobsRn4(0:127))
rRn14=escorc(newRn14(0:127),newobsRn4(0:127))
tRn14=rRn14*sqrt((nRn14-2)/(1-rRn14^2))
dfRn14=nRn14-2
pRn14=student_t(tRn14,dfRn14) ;test significance level at tRne 95% level
if (pRn14.le.0.05) then
    psig_Rn14="yes"
 else
   psig_Rn14="no"
end if
;print(mbRn14)
;print(meRn14)
;print(nmbRn14)
;print(nmeRn14)
;print(rRn14)
;print(pRn14)
;print(psig_Rn14)

mbRn24=sumdiff_Rn24/nRn14
meRn24=sumabsdiff_Rn24/nRn14
nmbRn24=100*sumdiff_Rn24/sum(newobsRn4(0:127))
nmeRn24=100*sumabsdiff_Rn24/sum(newobsRn4(0:127))
rRn24=escorc(newRn24(0:127),newobsRn4(0:127))
tRn24=rRn24*sqrt((nRn14-2)/(1-rRn24^2))
dfRn24=nRn14-2
pRn24=student_t(tRn24,dfRn24) ;test significance level at tRne 95% level
if (pRn24.le.0.05) then
    psig_Rn24="yes"
 else
   psig_Rn24="no"
end if



mbRn34=sumdiff_Rn34/nRn14
meRn34=sumabsdiff_Rn34/nRn14
nmbRn34=100*sumdiff_Rn34/sum(newobsRn4(0:127))
nmeRn34=100*sumabsdiff_Rn34/sum(newobsRn4(0:127))
rRn34=escorc(newRn34(0:127),newobsRn4(0:127))
tRn34=rRn34*sqrt((nRn14-2)/(1-rRn34^2))
dfRn34=nRn14-2
pRn34=student_t(tRn34,dfRn34) ;test significance level at tRne 95% level
if (pRn34.le.0.05) then
    psig_Rn34="yes"
 else
   psig_Rn34="no"
end if

mbRn44=sumdiff_Rn44/nRn14
meRn44=sumabsdiff_Rn44/nRn14
nmbRn44=100*sumdiff_Rn44/sum(newobsRn4(0:127))
nmeRn44=100*sumabsdiff_Rn44/sum(newobsRn4(0:127))
rRn44=escorc(newRn44(0:127),newobsRn4(0:127))
tRn44=rRn44*sqrt((nRn14-2)/(1-rRn44^2))
dfRn44=nRn14-2
pRn44=student_t(tRn44,dfRn44) ;test significance level at tRne 95% level
if (pRn44.le.0.05) then
    psig_Rn44="yes"
 else
   psig_Rn44="no"
end if

mbRn15=sumdiff_Rn15/nRn15
meRn15=sumabsdiff_Rn15/nRn15
nmbRn15=100*sumdiff_Rn15/sum(newobsRn5(0:127))
nmeRn15=100*sumabsdiff_Rn15/sum(newobsRn5(0:127))
rRn15=escorc(newRn15(0:127),newobsRn5(0:127))
tRn15=rRn15*sqrt((nRn15-2)/(1-rRn15^2))
dfRn15=nRn15-2
pRn15=student_t(tRn15,dfRn15) ;test significance level at tRne 95% level
if (pRn15.le.0.05) then
    psig_Rn15="yes"
 else
   psig_Rn15="no"
end if
;print(mbRn15)
;print(meRn15)
;print(nmbRn15)
;print(nmeRn15)
;print(rRn15)
;print(pRn15)
;print(psig_Rn15)

mbRn25=sumdiff_Rn25/nRn15
meRn25=sumabsdiff_Rn25/nRn15
nmbRn25=100*sumdiff_Rn25/sum(newobsRn5(0:127))
nmeRn25=100*sumabsdiff_Rn25/sum(newobsRn5(0:127))
rRn25=escorc(newRn25(0:127),newobsRn5(0:127))
tRn25=rRn25*sqrt((nRn15-2)/(1-rRn25^2))
dfRn25=nRn15-2
pRn25=student_t(tRn25,dfRn25) ;test significance level at tRne 95% level
if (pRn25.le.0.05) then
    psig_Rn25="yes"
 else
   psig_Rn25="no"
end if



mbRn35=sumdiff_Rn35/nRn15
meRn35=sumabsdiff_Rn35/nRn15
nmbRn35=100*sumdiff_Rn35/sum(newobsRn5(0:127))
nmeRn35=100*sumabsdiff_Rn35/sum(newobsRn5(0:127))
rRn35=escorc(newRn35(0:127),newobsRn5(0:127))
tRn35=rRn35*sqrt((nRn15-2)/(1-rRn35^2))
dfRn35=nRn15-2
pRn35=student_t(tRn35,dfRn35) ;test significance level at tRne 95% level
if (pRn35.le.0.05) then
    psig_Rn35="yes"
 else
   psig_Rn35="no"
end if

mbRn45=sumdiff_Rn45/nRn15
meRn45=sumabsdiff_Rn45/nRn15
nmbRn45=100*sumdiff_Rn45/sum(newobsRn5(0:127))
nmeRn45=100*sumabsdiff_Rn45/sum(newobsRn5(0:127))
rRn45=escorc(newRn45(0:127),newobsRn5(0:127))
tRn45=rRn45*sqrt((nRn15-2)/(1-rRn45^2))
dfRn45=nRn15-2
pRn45=student_t(tRn45,dfRn45) ;test significance level at tRne 95% level
if (pRn45.le.0.05) then
    psig_Rn45="yes"
 else
   psig_Rn45="no"
end if

mbRn16=sumdiff_Rn16/nRn16
meRn16=sumabsdiff_Rn16/nRn16
nmbRn16=100*sumdiff_Rn16/sum(newobsRn6(0:127))
nmeRn16=100*sumabsdiff_Rn16/sum(newobsRn6(0:127))
rRn16=escorc(newRn16(0:127),newobsRn6(0:127))
tRn16=rRn16*sqrt((nRn16-2)/(1-rRn16^2))
dfRn16=nRn16-2
pRn16=student_t(tRn16,dfRn16) ;test significance level at tRne 95% level
if (pRn16.le.0.05) then
    psig_Rn16="yes"
 else
   psig_Rn16="no"
end if
;print(mbRn16)
;print(meRn16)
;print(nmbRn16)
;print(nmeRn16)
;print(rRn16)
;print(pRn16)
;print(psig_Rn16)

mbRn26=sumdiff_Rn26/nRn16
meRn26=sumabsdiff_Rn26/nRn16
nmbRn26=100*sumdiff_Rn26/sum(newobsRn6(0:127))
nmeRn26=100*sumabsdiff_Rn26/sum(newobsRn6(0:127))
rRn26=escorc(newRn26(0:127),newobsRn6(0:127))
tRn26=rRn26*sqrt((nRn16-2)/(1-rRn26^2))
dfRn26=nRn16-2
pRn26=student_t(tRn26,dfRn26) ;test significance level at tRne 95% level
if (pRn26.le.0.05) then
    psig_Rn26="yes"
 else
   psig_Rn26="no"
end if



mbRn36=sumdiff_Rn36/nRn16
meRn36=sumabsdiff_Rn36/nRn16
nmbRn36=100*sumdiff_Rn36/sum(newobsRn6(0:127))
nmeRn36=100*sumabsdiff_Rn36/sum(newobsRn6(0:127))
rRn36=escorc(newRn36(0:127),newobsRn6(0:127))
tRn36=rRn36*sqrt((nRn16-2)/(1-rRn36^2))
dfRn36=nRn16-2
pRn36=student_t(tRn36,dfRn36) ;test significance level at tRne 95% level
if (pRn36.le.0.05) then
    psig_Rn36="yes"
 else
   psig_Rn36="no"
end if

mbRn46=sumdiff_Rn46/nRn16
meRn46=sumabsdiff_Rn46/nRn16
nmbRn46=100*sumdiff_Rn46/sum(newobsRn6(0:127))
nmeRn46=100*sumabsdiff_Rn46/sum(newobsRn6(0:127))
rRn46=escorc(newRn46(0:127),newobsRn6(0:127))
tRn46=rRn46*sqrt((nRn16-2)/(1-rRn46^2))
dfRn46=nRn16-2
pRn46=student_t(tRn46,dfRn46) ;test significance level at tRne 95% level
if (pRn46.le.0.05) then
    psig_Rn46="yes"
 else
   psig_Rn46="no"
end if

mbRn17=sumdiff_Rn17/nRn17
meRn17=sumabsdiff_Rn17/nRn17
nmbRn17=100*sumdiff_Rn17/sum(newobsRn7(0:127))
nmeRn17=100*sumabsdiff_Rn17/sum(newobsRn7(0:127))
rRn17=escorc(newRn17(0:127),newobsRn7(0:127))
tRn17=rRn17*sqrt((nRn17-2)/(1-rRn17^2))
dfRn17=nRn17-2
pRn17=student_t(tRn17,dfRn17) ;test significance level at tRne 95% level
if (pRn17.le.0.05) then
    psig_Rn17="yes"
 else
   psig_Rn17="no"
end if
;print(mbRn17)
;print(meRn17)
;print(nmbRn17)
;print(nmeRn17)
;print(rRn17)
;print(pRn17)
;print(psig_Rn17)

mbRn27=sumdiff_Rn27/nRn17
meRn27=sumabsdiff_Rn27/nRn17
nmbRn27=100*sumdiff_Rn27/sum(newobsRn7(0:127))
nmeRn27=100*sumabsdiff_Rn27/sum(newobsRn7(0:127))
rRn27=escorc(newRn27(0:127),newobsRn7(0:127))
tRn27=rRn27*sqrt((nRn17-2)/(1-rRn27^2))
dfRn27=nRn17-2
pRn27=student_t(tRn27,dfRn27) ;test significance level at tRne 95% level
if (pRn27.le.0.05) then
    psig_Rn27="yes"
 else
   psig_Rn27="no"
end if



mbRn37=sumdiff_Rn37/nRn17
meRn37=sumabsdiff_Rn37/nRn17
nmbRn37=100*sumdiff_Rn37/sum(newobsRn7(0:127))
nmeRn37=100*sumabsdiff_Rn37/sum(newobsRn7(0:127))
rRn37=escorc(newRn37(0:127),newobsRn7(0:127))
tRn37=rRn37*sqrt((nRn17-2)/(1-rRn37^2))
dfRn37=nRn17-2
pRn37=student_t(tRn37,dfRn37) ;test significance level at tRne 95% level
if (pRn37.le.0.05) then
    psig_Rn37="yes"
 else
   psig_Rn37="no"
end if

mbRn47=sumdiff_Rn47/nRn17
meRn47=sumabsdiff_Rn47/nRn17
nmbRn47=100*sumdiff_Rn47/sum(newobsRn7(0:127))
nmeRn47=100*sumabsdiff_Rn47/sum(newobsRn7(0:127))
rRn47=escorc(newRn47(0:127),newobsRn7(0:127))
tRn47=rRn47*sqrt((nRn17-2)/(1-rRn47^2))
dfRn47=nRn17-2
pRn47=student_t(tRn47,dfRn47) ;test significance level at tRne 95% level
if (pRn47.le.0.05) then
    psig_Rn47="yes"
 else
   psig_Rn47="no"
end if

avgnewobsH=(/avgnewobsH1,avgnewobsH2,avgnewobsH3,avgnewobsH4,avgnewobsH5,avgnewobsH6,avgnewobsH7/)
stddevnewobsH=(/stddevnewobsH1,stddevnewobsH2,stddevnewobsH3,stddevnewobsH4,stddevnewobsH5,stddevnewobsH6,stddevnewobsH7/)
avgnewobsLH=(/avgnewobsLH1,avgnewobsLH2,avgnewobsLH3,avgnewobsLH4,avgnewobsLH5,avgnewobsLH6,avgnewobsLH7/)
stddevnewobsLH=(/stddevnewobsLH1,stddevnewobsLH2,stddevnewobsLH3,stddevnewobsLH4,stddevnewobsLH5,stddevnewobsLH6,stddevnewobsLH7/)
avgnewobsust=(/avgnewobsust1,avgnewobsust2,avgnewobsust3,avgnewobsust4,avgnewobsust5,avgnewobsust6,avgnewobsust7/)
stddevnewobsust=(/stddevnewobsust1,stddevnewobsust2,stddevnewobsust3,stddevnewobsust4,stddevnewobsust5,stddevnewobsust6,stddevnewobsust7/)
avgnewobsRn=(/avgnewobsRn1,avgnewobsRn2,avgnewobsRn3,avgnewobsRn4,avgnewobsRn5,avgnewobsRn6,avgnewobsRn7/)
stddevnewobsRn=(/stddevnewobsRn1,stddevnewobsRn2,stddevnewobsRn3,stddevnewobsRn4,stddevnewobsRn5,stddevnewobsRn6,stddevnewobsRn7/)

mbH1=(/mbH11,mbH12,mbH13,mbH14,mbH15,mbH16,mbH17/)
;print(mbH1)
mbH2=(/mbH21,mbH22,mbH23,mbH24,mbH25,mbH26,mbH27/)
mbH3=(/mbH31,mbH32,mbH33,mbH34,mbH35,mbH36,mbH37/)
mbH4=(/mbH41,mbH42,mbH43,mbH44,mbH45,mbH46,mbH47/)

meH1=(/meH11,meH12,meH13,meH14,meH15,meH16,meH17/)
;print(meH1)
meH2=(/meH21,meH22,meH23,meH24,meH25,meH26,meH27/)
meH3=(/meH31,meH32,meH33,meH34,meH35,meH36,meH37/)
meH4=(/meH41,meH42,meH43,meH44,meH45,meH46,meH47/)

nmbH1=(/nmbH11,nmbH12,nmbH13,nmbH14,nmbH15,nmbH16,nmbH17/)
;print(nmbH1)
nmbH2=(/nmbH21,nmbH22,nmbH23,nmbH24,nmbH25,nmbH26,nmbH27/)
nmbH3=(/nmbH31,nmbH32,nmbH33,nmbH34,nmbH35,nmbH36,nmbH37/)
nmbH4=(/nmbH41,nmbH42,nmbH43,nmbH44,nmbH45,nmbH46,nmbH47/)

nmeH1=(/nmeH11,nmeH12,nmeH13,nmeH14,nmeH15,nmeH16,nmeH17/)
;print(nmeH1)
nmeH2=(/nmeH21,nmeH22,nmeH23,nmeH24,nmeH25,nmeH26,nmeH27/)
nmeH3=(/nmeH31,nmeH32,nmeH33,nmeH34,nmeH35,nmeH36,nmeH37/)
nmeH4=(/nmeH41,nmeH42,nmeH43,nmeH44,nmeH45,nmeH46,nmeH47/)

rH1=(/rH11,rH12,rH13,rH14,rH15,rH16,rH17/)
;print(rH1)
rH2=(/rH21,rH22,rH23,rH24,rH25,rH26,rH27/)
rH3=(/rH31,rH32,rH33,rH34,rH35,rH36,rH37/)
rH4=(/rH41,rH42,rH43,rH44,rH45,rH46,rH47/)
psig_H1=(/psig_H11,psig_H12,psig_H13,psig_H14,psig_H15,psig_H16,psig_H17/)
psig_H2=(/psig_H21,psig_H22,psig_H23,psig_H24,psig_H25,psig_H26,psig_H27/)
psig_H3=(/psig_H31,psig_H32,psig_H33,psig_H34,psig_H35,psig_H36,psig_H37/)
psig_H4=(/psig_H41,psig_H42,psig_H43,psig_H44,psig_H45,psig_H46,psig_H47/)


mbLH1=(/mbLH11,mbLH12,mbLH13,mbLH14,mbLH15,mbLH16,mbLH17/)
;print(mbLH1)
mbLH2=(/mbLH21,mbLH22,mbLH23,mbLH24,mbLH25,mbLH26,mbLH27/)
mbLH3=(/mbLH31,mbLH32,mbLH33,mbLH34,mbLH35,mbLH36,mbLH37/)
mbLH4=(/mbLH41,mbLH42,mbLH43,mbLH44,mbLH45,mbLH46,mbLH47/)

meLH1=(/meLH11,meLH12,meLH13,meLH14,meLH15,meLH16,meLH17/)
;print(meLH1)
meLH2=(/meLH21,meLH22,meLH23,meLH24,meLH25,meLH26,meLH27/)
meLH3=(/meLH31,meLH32,meLH33,meLH34,meLH35,meLH36,meLH37/)
meLH4=(/meLH41,meLH42,meLH43,meLH44,meLH45,meLH46,meLH47/)

nmbLH1=(/nmbLH11,nmbLH12,nmbLH13,nmbLH14,nmbLH15,nmbLH16,nmbLH17/)
;print(nmbLH1)
nmbLH2=(/nmbLH21,nmbLH22,nmbLH23,nmbLH24,nmbLH25,nmbLH26,nmbLH27/)
nmbLH3=(/nmbLH31,nmbLH32,nmbLH33,nmbLH34,nmbLH35,nmbLH36,nmbLH37/)
nmbLH4=(/nmbLH41,nmbLH42,nmbLH43,nmbLH44,nmbLH45,nmbLH46,nmbLH47/)

nmeLH1=(/nmeLH11,nmeLH12,nmeLH13,nmeLH14,nmeLH15,nmeLH16,nmeLH17/)
;print(nmeLH1)
nmeLH2=(/nmeLH21,nmeLH22,nmeLH23,nmeLH24,nmeLH25,nmeLH26,nmeLH27/)
nmeLH3=(/nmeLH31,nmeLH32,nmeLH33,nmeLH34,nmeLH35,nmeLH36,nmeLH37/)
nmeLH4=(/nmeLH41,nmeLH42,nmeLH43,nmeLH44,nmeLH45,nmeLH46,nmeLH47/)

rLH1=(/rLH11,rLH12,rLH13,rLH14,rLH15,rLH16,rLH17/)
;print(rLH1)
rLH2=(/rLH21,rLH22,rLH23,rLH24,rLH25,rLH26,rLH27/)
rLH3=(/rLH31,rLH32,rLH33,rLH34,rLH35,rLH36,rLH37/)
rLH4=(/rLH41,rLH42,rLH43,rLH44,rLH45,rLH46,rLH47/)
psig_LH1=(/psig_LH11,psig_LH12,psig_LH13,psig_LH14,psig_LH15,psig_LH16,psig_LH17/)
psig_LH2=(/psig_LH21,psig_LH22,psig_LH23,psig_LH24,psig_LH25,psig_LH26,psig_LH27/)
psig_LH3=(/psig_LH31,psig_LH32,psig_LH33,psig_LH34,psig_LH35,psig_LH36,psig_LH37/)
psig_LH4=(/psig_LH41,psig_LH42,psig_LH43,psig_LH44,psig_LH45,psig_LH46,psig_LH47/)

mbust1=(/mbust11,mbust12,mbust13,mbust14,mbust15,mbust16,mbust17/)
;print(mbust1)
mbust2=(/mbust21,mbust22,mbust23,mbust24,mbust25,mbust26,mbust27/)
mbust3=(/mbust31,mbust32,mbust33,mbust34,mbust35,mbust36,mbust37/)
mbust4=(/mbust41,mbust42,mbust43,mbust44,mbust45,mbust46,mbust47/)

meust1=(/meust11,meust12,meust13,meust14,meust15,meust16,meust17/)
;print(meust1)
meust2=(/meust21,meust22,meust23,meust24,meust25,meust26,meust27/)
meust3=(/meust31,meust32,meust33,meust34,meust35,meust36,meust37/)
meust4=(/meust41,meust42,meust43,meust44,meust45,meust46,meust47/)

nmbust1=(/nmbust11,nmbust12,nmbust13,nmbust14,nmbust15,nmbust16,nmbust17/)
;print(nmbust1)
nmbust2=(/nmbust21,nmbust22,nmbust23,nmbust24,nmbust25,nmbust26,nmbust27/)
nmbust3=(/nmbust31,nmbust32,nmbust33,nmbust34,nmbust35,nmbust36,nmbust37/)
nmbust4=(/nmbust41,nmbust42,nmbust43,nmbust44,nmbust45,nmbust46,nmbust47/)

nmeust1=(/nmeust11,nmeust12,nmeust13,nmeust14,nmeust15,nmeust16,nmeust17/)
;print(nmeust1)
nmeust2=(/nmeust21,nmeust22,nmeust23,nmeust24,nmeust25,nmeust26,nmeust27/)
nmeust3=(/nmeust31,nmeust32,nmeust33,nmeust34,nmeust35,nmeust36,nmeust37/)
nmeust4=(/nmeust41,nmeust42,nmeust43,nmeust44,nmeust45,nmeust46,nmeust47/)

rust1=(/rust11,rust12,rust13,rust14,rust15,rust16,rust17/)
;print(rust1)
rust2=(/rust21,rust22,rust23,rust24,rust25,rust26,rust27/)
rust3=(/rust31,rust32,rust33,rust34,rust35,rust36,rust37/)
rust4=(/rust41,rust42,rust43,rust44,rust45,rust46,rust47/)
psig_ust1=(/psig_ust11,psig_ust12,psig_ust13,psig_ust14,psig_ust15,psig_ust16,psig_ust17/)
psig_ust2=(/psig_ust21,psig_ust22,psig_ust23,psig_ust24,psig_ust25,psig_ust26,psig_ust27/)
psig_ust3=(/psig_ust31,psig_ust32,psig_ust33,psig_ust34,psig_ust35,psig_ust36,psig_ust37/)
psig_ust4=(/psig_ust41,psig_ust42,psig_ust43,psig_ust44,psig_ust45,psig_ust46,psig_ust47/)


mbRn1=(/mbRn11,mbRn12,mbRn13,mbRn14,mbRn15,mbRn16,mbRn17/)
;print(mbRn1)
mbRn2=(/mbRn21,mbRn22,mbRn23,mbRn24,mbRn25,mbRn26,mbRn27/)
mbRn3=(/mbRn31,mbRn32,mbRn33,mbRn34,mbRn35,mbRn36,mbRn37/)
mbRn4=(/mbRn41,mbRn42,mbRn43,mbRn44,mbRn45,mbRn46,mbRn47/)

meRn1=(/meRn11,meRn12,meRn13,meRn14,meRn15,meRn16,meRn17/)
;print(meRn1)
meRn2=(/meRn21,meRn22,meRn23,meRn24,meRn25,meRn26,meRn27/)
meRn3=(/meRn31,meRn32,meRn33,meRn34,meRn35,meRn36,meRn37/)
meRn4=(/meRn41,meRn42,meRn43,meRn44,meRn45,meRn46,meRn47/)

nmbRn1=(/nmbRn11,nmbRn12,nmbRn13,nmbRn14,nmbRn15,nmbRn16,nmbRn17/)
;print(nmbRn1)
nmbRn2=(/nmbRn21,nmbRn22,nmbRn23,nmbRn24,nmbRn25,nmbRn26,nmbRn27/)
nmbRn3=(/nmbRn31,nmbRn32,nmbRn33,nmbRn34,nmbRn35,nmbRn36,nmbRn37/)
nmbRn4=(/nmbRn41,nmbRn42,nmbRn43,nmbRn44,nmbRn45,nmbRn46,nmbRn47/)

nmeRn1=(/nmeRn11,nmeRn12,nmeRn13,nmeRn14,nmeRn15,nmeRn16,nmeRn17/)
;print(nmeRn1)
nmeRn2=(/nmeRn21,nmeRn22,nmeRn23,nmeRn24,nmeRn25,nmeRn26,nmeRn27/)
nmeRn3=(/nmeRn31,nmeRn32,nmeRn33,nmeRn34,nmeRn35,nmeRn36,nmeRn37/)
nmeRn4=(/nmeRn41,nmeRn42,nmeRn43,nmeRn44,nmeRn45,nmeRn46,nmeRn47/)

rRn1=(/rRn11,rRn12,rRn13,rRn14,rRn15,rRn16,rRn17/)
;print(rRn1)
rRn2=(/rRn21,rRn22,rRn23,rRn24,rRn25,rRn26,rRn27/)
rRn3=(/rRn31,rRn32,rRn33,rRn34,rRn35,rRn36,rRn37/)
rRn4=(/rRn41,rRn42,rRn43,rRn44,rRn45,rRn46,rRn47/)
psig_Rn1=(/psig_Rn11,psig_Rn12,psig_Rn13,psig_Rn14,psig_Rn15,psig_Rn16,psig_Rn17/)
psig_Rn2=(/psig_Rn21,psig_Rn22,psig_Rn23,psig_Rn24,psig_Rn25,psig_Rn26,psig_Rn27/)
psig_Rn3=(/psig_Rn31,psig_Rn32,psig_Rn33,psig_Rn34,psig_Rn35,psig_Rn36,psig_Rn37/)
psig_Rn4=(/psig_Rn41,psig_Rn42,psig_Rn43,psig_Rn44,psig_Rn45,psig_Rn46,psig_Rn47/)

csv_filename="./Turb_Stat_NonPCAPs_Daytime.csv"
header=[/"obs_H"+",stdev_H"+",MB_H_ACM2"+",MB_H_YSU"+",MB_H_MYJ"+",MB_H_MYNN"+",ME_H_ACM2"+",ME_H_YSU"+",ME_H_MYJ"+",ME_H_MYNN"+",NMB_H_ACM2"+",NMB_H_YSU"+",NMB_H_MYJ"+",NMB_H_MYNN"+",NME_H_ACM2"+",NME_H_YSU"+",NME_H_MYJ"+",NME_H_MYNN"+",R_H_ACM2"+",R_H_YSU"+",R_H_MYJ"+",R_H_MYNN"+",Psig_H_ACM2"+",Psig_H_YSU"+",Psig_H_MYJ"+",Psig_H_MYNN"+",obs_LH"+",stdev_LH"+",MB_LH_ACM2"+",MB_LH_YSU"+",MB_LH_MYJ"+",MB_LH_MYNN"+",ME_LH_ACM2"+",ME_LH_YSU"+",ME_LH_MYJ"+",ME_LH_MYNN"+",NMB_LH_ACM2"+",NMB_LH_YSU"+",NMB_LH_MYJ"+",NMB_LH_MYNN"+",NME_LH_ACM2"+",NME_LH_YSU"+",NME_LH_MYJ"+",NME_LH_MYNN"+",R_LH_ACM2"+",R_LH_YSU"+",R_LH_MYJ"+",R_LH_MYNN"+",Psig_LH_ACM2"+",Psig_LH_YSU"+",Psig_LH_MYJ"+",Psig_LH_MYNN"+",obs_ust"+",stdev_ust"+",MB_ust_ACM2"+",MB_ust_YSU"+",MB_ust_MYJ"+",MB_ust_MYNN"+",ME_ust_ACM2"+",ME_ust_YSU"+",ME_ust_MYJ"+",ME_ust_MYNN"+",NMB_ust_ACM2"+",NMB_ust_YSU"+",NMB_ust_MYJ"+",NMB_ust_MYNN"+",NME_ust_ACM2"+",NME_ust_YSU"+",NME_ust_MYJ"+",NME_ust_MYNN"+",R_ust_ACM2"+",R_ust_YSU"+",R_ust_MYJ"+",R_ust_MYNN"+",Psig_ust_ACM2"+",Psig_ust_YSU"+",Psig_ust_MYJ"+",Psig_ust_MYNN"+",obs_Rn"+",stdev_Rn"+",MB_Rn_ACM2"+",MB_Rn_YSU"+",MB_Rn_MYJ"+",MB_Rn_MYNN"+",ME_Rn_ACM2"+",ME_Rn_YSU"+",ME_Rn_MYJ"+",ME_Rn_MYNN"+",NMB_Rn_ACM2"+",NMB_Rn_YSU"+",NMB_Rn_MYJ"+",NMB_Rn_MYNN"+",NME_Rn_ACM2"+",NME_Rn_YSU"+",NME_Rn_MYJ"+",NME_Rn_MYNN"+",R_Rn_ACM2"+",R_Rn_YSU"+",R_Rn_MYJ"+",R_Rn_MYNN"+",Psig_Rn_ACM2"+",Psig_Rn_YSU"+",Psig_Rn_MYJ"+",Psig_Rn_MYNN"/]
write_table(csv_filename,"w",header,"%s")
;do i=0,6,1
alist=[/avgnewobsH,stddevnewobsH,mbH1,mbH2,mbH3,mbH4,meH1,meH2,meH3,meH4,nmbH1,nmbH2,nmbH3,nmbH4,nmeH1,nmeH2,nmeH3,nmeH4,rH1,rH2,rH3,rH4,psig_H1,psig_H2,psig_H3,psig_H4,avgnewobsLH,stddevnewobsLH,mbLH1,mbLH2,mbLH3,mbLH4,meLH1,meLH2,meLH3,meLH4,nmbLH1,nmbLH2,nmbLH3,nmbLH4,nmeLH1,nmeLH2,nmeLH3,nmeLH4,rLH1,rLH3,rLH3,rLH4,psig_LH1,psig_LH2,psig_LH3,psig_LH4,avgnewobsust,stddevnewobsust,mbust1,mbust2,mbust3,mbust4,meust1,meust2,meust3,meust4,nmbust1,nmbust2,nmbust3,nmbust4,nmeust1,nmeust2,nmeust3,nmeust4,rust1,rust3,rust3,rust4,psig_ust1,psig_ust2,psig_ust3,psig_ust4,avgnewobsRn,stddevnewobsRn,mbRn1,mbRn2,mbRn3,mbRn4,meRn1,meRn2,meRn3,meRn4,nmbRn1,nmbRn2,nmbRn3,nmbRn4,nmeRn1,nmeRn2,nmeRn3,nmeRn4,rRn1,rRn2,rRn3,rRn4,psig_Rn1,psig_Rn2,psig_Rn3,psig_Rn4/]
format="%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%s,%s,%s,%s,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%s,%s,%s,%s,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%s,%s,%s,%s,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%s,%s,%s,%s"
write_table(csv_filename, "a", alist, format)
end
