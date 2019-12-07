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
  ctime=wrf_times_c(f1[:]->Times,0)
utahtime=ctime-7 ;MST time
time=wrf_user_getvar(f1, "times", -1)

;res@trXMaxF=utahtime(743)

copy_VarAtts(ctime, utahtime)

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
obsH=(/obsH1(744:1487),obsH2(744:1487),obsH3(744:1487),obsH4(744:1487),obsH5(744:1487),obsH6(744:1487),obsH7(744:1487)/)
printVarSummary(obsH)
avgobsH=dim_avg_n(obsH,0)
obsust=(/obsust1(744:1487),obsust2(744:1487),obsust3(744:1487),obsust4(744:1487),obsust5(744:1487),obsust6(744:1487),obsust7(744:1487)/)
avgobsust=dim_avg_n(obsust,0)
obsRn=(/obsRn1(744:1487),obsRn2(744:1487),obsRn3(744:1487),obsRn4(744:1487),obsRn5(744:1487),obsRn6(744:1487),obsRn7(744:1487)/)
avgobsRn=dim_avg_n(obsRn,0)

acm2H=(/H11,H12,H13,H14,H15,H16,H17/)
acm2ust=(/ust11,ust12,ust13,ust14,ust15,ust16,ust17/)
acm2Rn=(/Rn11,Rn12,Rn13,Rn14,Rn15,Rn16,Rn17/)
avgacm2H=dim_avg_n(acm2H,0)
avgacm2ust=dim_avg_n(acm2ust,0)
avgacm2Rn=dim_avg_n(acm2Rn,0)


ysuH=(/H21,H22,H23,H24,H25,H26,H27/)
ysuust=(/ust21,ust22,ust23,ust24,ust25,ust26,ust27/)
ysuRn=(/Rn21,Rn22,Rn23,Rn24,Rn25,Rn26,Rn27/)
avgysuH=dim_avg_n(ysuH,0)
avgysuust=dim_avg_n(ysuust,0)
avgysuRn=dim_avg_n(ysuRn,0)



myjH=(/H31,H32,H33,H34,H35,H36,H37/)
myjust=(/ust31,ust32,ust33,ust34,ust35,ust36,ust37/)
myjRn=(/Rn31,Rn32,Rn33,Rn34,Rn35,Rn36,Rn37/)
avgmyjH=dim_avg_n(myjH,0)
avgmyjust=dim_avg_n(myjust,0)
avgmyjRn=dim_avg_n(myjRn,0)

mynnH=(/H41,H42,H43,H44,H45,H46,H47/)
mynnust=(/ust41,ust42,ust43,ust44,ust45,ust46,ust47/)
mynnRn=(/Rn41,Rn42,Rn43,Rn44,Rn45,Rn46,Rn47/)
avgmynnH=dim_avg_n(mynnH,0)
avgmynnust=dim_avg_n(mynnust,0)
avgmynnRn=dim_avg_n(mynnRn,0)
wks1=gsn_open_wks("png", "H_AvgSites_WRF_OBS_Jan2011")
wks2=gsn_open_wks("png", "ust_AvgSites_WRF_OBS_Jan2011")
wks3=gsn_open_wks("png", "Rn_AvgSites_WRF_OBS_Jan2011")
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
res1@tiYAxisString="H (W m-2)"

res2=res
res2@tiYAxisString="ust (m/s)"
res3=res
res3@tiYAxisString="Rn (W m-2)"

dataH=new((/5,744/),float)
dataH(0,:)=avgobsH
dataH(1,:)=avgmynnH
dataH(2,:)=avgmyjH
dataH(2,:)=avgysuH
dataH(2,:)=avgacm2H

dataust=new((/5,744/),float)
dataust(0,:)=avgobsust
dataust(1,:)=avgmynnust
dataust(2,:)=avgmyjust
dataust(2,:)=avgysuust
dataust(2,:)=avgacm2ust

datarealRn=new((/5,744/),float)
datarealRn(0,:)=avgobsRn
datarealRn(1,:)=avgmynnRn
datarealRn(2,:)=avgmyjRn
datarealRn(2,:)=avgysuRn
datarealRn(2,:)=avgacm2Rn

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
plot1=gsn_csm_xy(wks1, utahtime, dataH, res1)
plot2=gsn_csm_xy(wks2, utahtime, dataust, res2)
plot3=gsn_csm_xy(wks3, utahtime, datarealRn, res3)
csv_filename="./Turb_OBS_WRF_AvgSites.csv"
header=[/"time(utc)"+",obs_H"+",acm2_H"+",ysu_H"+",myj_H"+",mynn_H"+",obs_ust"+",acm2_ust"+",ysu_ust"+",myj_ust"+",mynn_ust"+",obs_Rn"+",acm2_Rn"+",ysu_Rn"+",myj_Rn"+",mynn_Rn"/]
write_table(csv_filename,"w",header,"%s")
;do i=0,6,1
printVarSummary(utahtime)
alist=[/time,avgobsH, avgacm2H,avgysuH,avgmyjH,avgmynnH,avgobsust, avgacm2ust,avgysuust,avgmyjust,avgmynnust,avgobsRn, avgacm2Rn,avgysuRn,avgmyjRn,avgmynnRn/]
format="%s,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g"
write_table(csv_filename, "a", alist, format)
end
