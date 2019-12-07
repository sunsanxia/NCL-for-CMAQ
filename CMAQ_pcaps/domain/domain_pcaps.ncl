
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
begin
;---------------------------------------------------------------------

f1 = addfile("/data/gpfs/assoc/ataq/xsun/soft/WPS/run_pcaps/geo_em.d01.nc","r")
f2 = addfile("/data/gpfs/assoc/ataq/xsun/modify/ACM2_MPI/WRFV3/run_ACM2_pcaps8/wrfout_d02_2011-02-01_00:00:00.nc","r")
;f3 = addfile("/data/gpfs/home/xsun/modify/ACM2/WRFV3/run_ACM2_IOP5/wrfout_d03_2011-01-01_00:00:00.nc","r")


;----------------------------------------------------------------------------
  

;------------------------------------------------------------------------------
;landuse = f1->LU_INDEX(0,:,:)
 ;landuse=wrf_user_getvar(f1, "HGT_M", 0)
  landuse=wrf_user_getvar(f1, "SOILTEMP", 0)
 wks = gsn_open_wks("png", "CMAQ_WRF_domain_model")
 ;colors = (/"white","snow"/)
 ;gsn_define_colormap(wks, colors)
;  wks = gsn_open_wks("x11", "Modles Performance")
var2 = wrf_user_getvar(f2,"HGT",0)
  lat2 = wrf_user_getvar(f2,"XLAT",0)
  lon2 = wrf_user_getvar(f2,"XLONG",0)
  ;var3 = wrf_user_getvar(f3,"HGT",0)
;lat3 = wrf_user_getvar(f3,"XLAT",0)
 ; lon3 = wrf_user_getvar(f3,"XLONG",0)
;minlat3=lat3(0,149)
;maxlat3=lat3(159,0)
;minlon3=lon3(0,149)
;maxlon3=lon3(159,0)
;print(minlat3)
;print(maxlat3)
;print(minlon3)
;print(maxlon3)
dom_dims = dimsizes(landuse)
  dom_rank = dimsizes(dom_dims)
  nx1 = dom_dims(dom_rank - 1) - 1
  ny1 = dom_dims(dom_rank - 2) - 1
  dom_dims = dimsizes(var2)
  dom_rank = dimsizes(dom_dims)
  nx2 = dom_dims(dom_rank - 1) - 1
  ny2 = dom_dims(dom_rank - 2) - 1
 ; dom_dims = dimsizes(var3)
 ; dom_rank = dimsizes(dom_dims)
 ; nx3 = dom_dims(dom_rank - 1) - 1
 ; ny3 = dom_dims(dom_rank - 2) - 1

  

   xbox_out = new(5,float)
 ybox_out = new(5,float)
 lnres=True
 lnres@gsLineThicknessF = 3.5

;--------set resources
  res = True
  ;res@Footer=False
 ; res@tiMainString = "NAM-ACM2(MODIS)"
  ; res@tiMainString = "NAM-ACM2"
  ;  res@tiMainString = "NARR-ACM2"
  ;res@tiMainString = "NAM-ACM2(Non-nudge)"
  res@gsnDraw              = False
  res@gsnFrame             = False
  
  res@gsnMaximize = True
    res@cnFillOn    = True
  res@tfDoNDCOverlay = True
  res@tmXBLabelFontHeightF = 0.0155
  res@tmYLLabelFontHeightF=0.0155
 res@gsnSpreadColors = False
  res@cnFillOn = True
  res@cnLineLabelsOn = False 
 res@cnLinesOn = False
  res@cnInfoLabelOn = False
res@gsnLeftString = " "
res@gsnRightString = " "
res@lbLabelBarOn = False    ; not display label
 res@pmLabelBarHeightF = 0.1
 res@lbLabelFontHeightF = 0.01
  res = wrf_map_resources(f1, res)
 res@mpProvincialLineColor = "Black"
  res@mpGeophysicalLineColor = "Black"
  res@mpNationalLineColor    = "Black"
  res@mpUSStateLineColor     = "Black"
  res@mpGridLineColor        = "Black"
  res@mpLimbLineColor        = "Black"
  res@mpPerimLineColor       = "Black"
   res@mpCountyLineColor = 0
   res@mpInlandWaterFillColor = 0
  res@mpUSStateLineThicknessF = 1.2
 ; res@mpMinLatF = 45.0 
  opts=res
  opts@cnFillOn = True
  ;opts@cnFillPalette=(/"snow","siennal"/)
  ;opts@cnFillMode = "RasterFill"
  opts@cnLevelSelectionMode = "ManualLevels"
 opts@cnMinLevelValF = 1
; cnLevelSpacingF
opts@cnLevelSpacingF =1
opts@cnMaxLevelValF = 20  
opts@cnMonoFillColor = True

opts@cnFillColor = 0  ;set color to background
opts@cnCellFillEdgeColor = "Black"
 ; opts@ContourParameters = (/1,20,1/)
;contour=wrf_contour(f1, wks, landuse,opts)
 plot=gsn_csm_contour_map(wks, landuse, opts)
 pmres = True
  pmres@gsMarkerColor = "Black"
  pmres@gsMarkerIndex = 4
  pmres@gsMarkerSizeF = 0.015
  pmres@gsMarkerThicknessF = 2.0
  text2 = "d02"
  ;text3 = "d03"

   txres = True
   txres@txFontHeightF =0.02
  d2=gsn_add_text(wks, plot, text2,-113.7,42,txres)
  ;d3=gsn_add_text(wks, plot, text3,-112.5,41.2,txres)

 ;plot = wrf_map_overlays(f1, wks, (/contour/),pltres,mpres) 
 ;marker=gsn_add_polymarker(wks,plot,-119.406023,45.713560,pmres)
 draw(plot)

 xbox = (/lon2(0,0),lon2(0,nx2),lon2(ny2,nx2),lon2(ny2,0),lon2(0,0)/)
  ybox = (/lat2(0,0),lat2(0,nx2),lat2(ny2,nx2),lat2(ny2,0),lat2(0,0)/)
  datatondc(plot, xbox, ybox, xbox_out, ybox_out)
  gsn_polyline_ndc(wks, xbox_out, ybox_out, lnres)

 ; xbox = (/lon3(0,0),lon3(0,nx3),lon3(ny3,nx3),lon3(ny3,0),lon3(0,0)/)
  ;ybox = (/lat3(0,0),lat3(0,nx3),lat3(ny3,nx3),lat3(ny3,0),lat3(0,0)/)
  ;datatondc(plot, xbox, ybox, xbox_out, ybox_out)
  ;gsn_polyline_ndc(wks, xbox_out, ybox_out, lnres)
  
  gsn_polyline_ndc(wks, xbox_out, ybox_out, lnres)
   
; draw(marker)
 frame(wks)           ; lets frame the plot - do not delete
  
 
end















