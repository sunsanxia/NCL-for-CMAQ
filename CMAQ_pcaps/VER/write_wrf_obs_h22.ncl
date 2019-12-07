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
datename="/data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/H22_NCAR_OBS.csv"
delim=","
vars=asciiread(datename, -1, "string")
obsdate=tointeger(str_get_field(vars(1::), 1, delim))
print(obsdate)

obstime=tointeger(str_get_field(vars(1::), 2, delim))
print(obstime)

wrfi=tointeger(str_get_field(vars(1::), 4, delim))
print(wrfi)
obsh22=tofloat(str_get_field(vars(1::), 3, delim))
print(obsh22)
obsh22all=new(744,float)


datename2="/data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/H22_KSLC_OBS.csv"
;delim2=","
vars2=asciiread(datename2, -1, "string")
obsdate2=tointeger(str_get_field(vars2(1::), 1, delim))
print(obsdate2)

obstime2=tointeger(str_get_field(vars2(1::), 2, delim))
print(obstime2)

wrfi2=tointeger(str_get_field(vars2(1::), 4, delim))
print(wrfi2)
obsh222=tofloat(str_get_field(vars2(1::), 3, delim))
print(obsh222)
obsh22all2=new(744,float)

do i=0,743
   obsh22all(i)=999
    obsh22all2(i)=999
end do 
do i=0,743
    do j=0, 65
       if (i.eq.wrfi(j))
         obsh22all(i)=obsh22(j)
       end if
    end do
end do
do i=0,743
  do j= 0,60
      if (i.eq.wrfi2(j))
         obsh22all2(i)=obsh222(j)
       end if
    end do
end do
print(obsh22all2)
obsh22all@_FillValue = 999
obsh22all2@_FillValue = 999
fils1 = systemfunc("ls /data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/wrfoutJan/ACM2/wrfout_d02*")
f1 = addfiles(fils1,"r")
time=wrf_user_getvar(f1, "times", -1)
print(time(wrfi(65)))

wrfh22name="/data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/H22_WRF_NCAR.csv"
delim2=","
wrfvars=asciiread(wrfh22name, -1, "string")
wrftime=tointeger(str_get_field(wrfvars(1::), 1, delim2))
print(wrftime)
h22acm2=tofloat(str_get_field(wrfvars(1::), 2, delim2))
h22ysu=tofloat(str_get_field(wrfvars(1::), 3, delim2))
h22myj=tofloat(str_get_field(wrfvars(1::), 4, delim2))
h22mynn=tofloat(str_get_field(wrfvars(1::), 5, delim2))
print(h22acm2)

wrfh22name2="/data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/VER/H22_WRF_KSLC.csv"
delim2=","
wrfvars2=asciiread(wrfh22name2, -1, "string")
wrftime2=tointeger(str_get_field(wrfvars2(1::), 1, delim2))
print(wrftime2)
h22acm22=tofloat(str_get_field(wrfvars2(1::), 2, delim2))
h22ysu2=tofloat(str_get_field(wrfvars2(1::), 3, delim2))
h22myj2=tofloat(str_get_field(wrfvars2(1::), 4, delim2))
h22mynn2=tofloat(str_get_field(wrfvars2(1::), 5, delim2))
print(h22acm22)

csv_filename="./All_H22_NCAR_KSLC.csv"
header=[/"Time(UTC)"+",OBS_NCAR"+",ACM2_H22"+",YSU_H22"+",MYJ_H22"+",MYNN_H22"+",OBS_KSLC"+",ACM2_H22"+",YSU_H22"+",MYJ_H22"+",MYNN_H22"/]
write_table(csv_filename,"w",header,"%s")
alist=[/time,obsh22all,h22acm2,h22ysu,h22myj,h22mynn,obsh22all2,h22acm22,h22ysu2,h22myj2,h22mynn2/]
format="%s,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g"
write_table(csv_filename, "a", alist, format)

end
