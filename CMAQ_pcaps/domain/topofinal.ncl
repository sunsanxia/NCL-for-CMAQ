load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"


begin
;---Subsetting the data is not necessary, but it will make plotting go much faster.
  topo_file = "ETOPO1_Bed_c_gmt4.grd.nc";"ETOPO2_GLOBAL_2_ELEVATION.nc"
  a         = addfile(topo_file,"r")
  f1 = addfile("/data/gpfs/assoc/ataq/xsun/modify/ACM2_MPI/WRFV3/run_ACM2_pcaps8/wrfout_d02_2011-02-01_00:00:00.nc","r")
   f2 = addfile("/data/gpfs/home/xsun/CMAQ_v5.2/data/mcip/ACM2_pcaps/GRIDCRO2D_PCAPs_ACM2.nc","r")
   lat1 = wrf_user_getvar(f1,"XLAT",0)
  lon1 = wrf_user_getvar(f1,"XLONG",0)
  lat2=f2->LAT
  lon2=f2->LON
   minlat   = lat2(0,0,0,171);40.29941
  maxlat  = lat2(0,0,171,0);40.98658
  minlon   = lon2(0,0,171,0);-112.326
  maxlon   = lon2(0,0,0,171);-111.4792
 
 ; minlat=lat1(23,26)
 ; maxlat=lat1(194,197)
 ; minlon=lon1(23,26)
 ; maxlon=lon1(194,197)

  print(minlat)
  print(maxlat)
  print(minlon)
  print(maxlon)
  elev     = a->z({minlat:maxlat},{minlon:maxlon})

;---Will use this later for coloring the contours
wks = gsn_open_wks("png", "topofinal")
  ;cmap = read_colormap_file("MPL_gist_earth")
cmap = read_colormap_file("OceanLakeLandSnow")
;cmap = read_colormap_file("topo_15lev")
;cmap = read_colormap_file("MPL_terrain")
;---Set some resources for contouring and mapping
  res                    = True

  res@gsnMaximize        = True         ; maximize plot in frame

  res@gsnDraw            = False
  res@gsnFrame           = False

  res@cnFillOn           = True         ; turn on contour fill
  res@cnFillMode         = "RasterFill";"MeshFill"   ; for faster draw
  res@cnFillPalette      = cmap(1:,:)
    res@cnRasterSmoothingOn = True
 
  res@cnLinesOn          = False        ; turn off contour lines
  res@cnLineLabelsOn     = False        ; turn off line labels
  res@cnInfoLabelOn      = False        ; turn off info label
  res@lbBoxLinesOn       = False        ; turn off labelbar box lines
  res@lbTitleString      = "Elevation (m)"    ; add a labelbar title
  res@lbTitleFontHeightF = 0.015
  res@lbTitlePosition    = "Bottom"
  res@pmLabelBarOrthogonalPosF = 0.05
  res@pmLabelBarHeightF = 0.12
  res@lbLabelFontHeightF =0.013
  res@lbLabelStride = 3

;---Pick "nice" contour levels
  mnmxint = nice_mnmxintvl( min(elev), max(elev), 18, False)
  res@cnLevelSelectionMode = "ManualLevels"
  res@cnMinLevelValF       = mnmxint(0)
  res@cnMaxLevelValF       = mnmxint(1)
  res@cnLevelSpacingF      = mnmxint(2)/8.   ; Increase the number of levels 
                                             ; by choosing a smaller spacing.
;---Zoom in on map
;res@mpProjection = "LambertConformal"
;res@mpLambertParallel1F=33.0
;res@mpLambertParallel2F=45.0
;res@mpLambertMeridianF= -97.0
  res@mpMinLatF            = minlat
  res@mpMaxLatF            = maxlat
  res@mpMinLonF            = minlon
  res@mpMaxLonF            = maxlon
  res@mpCenterLonF         = (res@mpMinLonF + res@mpMaxLonF) / 2.

  res@mpDataBaseVersion    = "MediumRes"
  res@mpUSStateLineThicknessF = 2.0

  res@mpFillOn             = True
  res@mpOutlineOn          = True
  res@mpOutlineBoundarySets = "AllBoundaries"
  res@gsnAddCyclic         = False           ; don't add longitude cyclic point
 ;res@mpInlandWaterFillColor = "blue"
  res@mpFillColors = (/"Transparent","Transparent","Transparent","blue"/)
  res@mpFillDrawOrder = "PostDraw"
  res@mpOutlineDrawOrder = "PostDraw"
  res@mpPerimDrawOrder = "PostDraw"
  res@tfDoNDCOverlay = True
 ; res@tiMainString          = "Rivers of Colorado"
 res@mpGeophysicalLineColor = "seagreen"
 res@mpGeophysicalLineThicknessF = 2.5
 res@mpCountyLineThicknessF = 0.7
 
 ;res@mpOceanFillColor     = "blue"
  res@gsnLeftString         = ""
  res@gsnRightString        = ""
  res@pmTickMarkDisplayMode = "Always"
  res@pmTitleZone           = 4              ; move main title down a little
;res@mpInlandWaterFillColor = "blue"
;---Create map and return it.
  
  
  plot = gsn_csm_contour_map(wks,elev,res)
  
 ;  pmres = True
 ; pmres@gsMarkerColor = "Black"
 ; pmres@gsMarkerIndex = 4
 ; pmres@gsMarkerSizeF = 0.01
 ; pmres@gsMarkerThicknessF = 4.0
 ; marker1 = gsn_add_polymarker(wks,plot,-112.103,40.779,pmres)
 ; marker2 = gsn_add_polymarker(wks,plot,-111.913,40.738,pmres)
  ;marker3 = gsn_add_polymarker(wks,plot,-111.839,40.697,pmres)
 ; marker4 = gsn_add_polymarker(wks,plot,-111.995,40.681,pmres)
 ; marker5 = gsn_add_polymarker(wks,plot,-111.804,40.614,pmres)
 ; marker6 = gsn_add_polymarker(wks,plot,-112.062,40.594,pmres)
 ; marker7 = gsn_add_polymarker(wks,plot,-111.974,40.514,pmres)
  ; pmres1 = True
 ; pmres1@gsMarkerColor = "Black"
 ; pmres1@gsMarkerIndex = 8 ;downtranagle
  ;pmres1@gsMarkerSizeF = 0.01
  ;pmres1@gsMarkerThicknessF = 4.0
 ; pmres1@gsMarkerColor = "grey76"
  ;marker8=gsn_add_polymarker(wks,plot,-111.97907,40.78994,pmres1)
  

  ;txres = True
 ;txres@txFontHeightF = 0.015

 ;dum1= gsn_add_text(wks, plot, "BL", -112.130, 40.779, txres)
 ; ;dum2 = gsn_add_text(wks,plot,"DH",-111.940,40.738,txres)
  ;dum3 = gsn_add_text(wks,plot,"DM",-111.866,40.697,txres)
 ; dum4 = gsn_add_text(wks,plot,"DL1",-112.024,40.681,txres)
  ;dum5 = gsn_add_text(wks,plot,"DL2",-111.839,40.614,txres)
 ; dum6 = gsn_add_text(wks,plot,"PH",-112.089,40.594,txres)
 ; dum7 = gsn_add_text(wks,plot,"CR",-112.001,40.514,txres)
 ; txres2 = True
 ;txres2@txFontHeightF = 0.015
; txres2@txFontColor = "black"
  ; dum8 = gsn_add_text(wks,plot,"KSLC",-112.025,40.78994,txres2)

  ;txres1 = True
   ;txres1@txFontHeightF = 0.018
  ; txres1@txFontColor = "white"
  ; dum8 = gsn_add_text(wks, plot, "Salt Lake Valley", -111.93, 40.64, txres1)
  ; dum9 = gsn_add_text(wks, plot, "Great Salt Lake", -112.025, 40.95, txres1)
 
  draw(plot)
  ;txres = True
 ; txres@txFontHeightF = 0.03

 ; gsn_text_ndc(wks, "BL", 0.2, 0.7, txres)
  frame(wks)
end
