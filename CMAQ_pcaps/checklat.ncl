load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"


begin

  f1 = addfile("/data/gpfs/home/xsun/CMAQ_v5.2/data/mcip/ACM2_pcaps/GRIDCRO2D_PCAPs_ACM2.nc","r")
  latmcip=f1->LAT
  lonmcip=f1->LON
  f2 = addfile("/data/gpfs/home/xsun/modify/ACM2_MPI/WRFV3/run_ACM2_pcaps7/wrfout_d02_2011-01-27_00:00:00","r")
  latwrf=f2->XLAT
  lonwrf=f2->XLONG
  latmcip0=latmcip(0,0,1,1)
  lonmcip0=lonmcip(0,0,1,1)
  latwrf0=latwrf(0,26,23)
   lonwrf0=lonwrf(0,26,23)
 ; minlat=lat1(23,26)
 ; maxlat=lat1(194,197)
 ; minlon=lon1(23,26)
 ; maxlon=lon1(194,197)

  print(latwrf0)
  print(lonwrf0)
  print(latmcip0)
  print(lonmcip0)
  
end
