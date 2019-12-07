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
  ; minlat   = lat2(0,0,0,171);40.29941
  ;maxlat  = lat2(0,0,171,0);40.98658
  ;minlon   = lon2(0,0,171,0);-112.326
  ;maxlon   = lon2(0,0,0,171);-111.4792
 minlat   = 40.3
  maxlat   = 41.1
  minlon   = -112.326
  maxlon   = -111.5
  
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
wks = gsn_open_wks("png", "topofinal_ISS")
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
  res@cnFillPalette      = cmap(3:,:)
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
  ;********NEW FILLED MARKERS**************
  mstring = "y"
  fontnum = 35
  xoffset = 0.0
  yoffset = 0.0
  ratio   = 1.0
  size    = 30
  angle   = 0.0

  FilledSquare = NhlNewMarker(wks, mstring, fontnum, xoffset, yoffset, ratio, size, angle)

mstring1 = "u"
  fontnum1 = 34
  xoffset1 = 0.0
  yoffset1 = 0.0
  ratio1   = 1.0
  size1    = 1.5
  angle1   = 0.0

  FilledTrangle = NhlNewMarker(wks, mstring1, fontnum1, xoffset1, yoffset1, ratio1, size1, angle1)
  ;***********NEW FILLED MARKERS*************************
  plot = gsn_csm_contour_map(wks,elev,res)
  
   pmres = True
  pmres@gsMarkerColor = "red"
  pmres@gsMarkerIndex = 16
  pmres@gsMarkerSizeF = 0.015
  pmres@gsMarkerThicknessF = 4
  marker1 = gsn_add_polymarker(wks,plot,-112.103,40.779,pmres)
  marker2 = gsn_add_polymarker(wks,plot,-111.913,40.738,pmres)
  marker3 = gsn_add_polymarker(wks,plot,-111.839,40.697,pmres)
  marker4 = gsn_add_polymarker(wks,plot,-111.995,40.681,pmres)
  marker5 = gsn_add_polymarker(wks,plot,-111.804,40.614,pmres)
  marker6 = gsn_add_polymarker(wks,plot,-112.062,40.594,pmres)
  marker7 = gsn_add_polymarker(wks,plot,-111.974,40.514,pmres)
   pmres1 = True
   pmres1=pmres
  pmres1@gsMarkerColor = "black"
  pmres1@gsMarkerIndex = 5 ;downtranagle
  ;pmres1@gsMarkerSizeF = 0.015
  pmres1@gsMarkerThicknessF = 5
  ;pmres1@gsMarkerColor = "black"
  marker8=gsn_add_polymarker(wks,plot,-111.9252,40.6006,pmres1)  ;ncar sounding
   pmres2 = True
   pmres2=pmres
  pmres2@gsMarkerColor = "Black"
  pmres2@gsMarkerIndex = FilledTrangle ;downtranagle
  ;pmres2@gsMarkerSizeF = 0.015
  ;pmres2@gsMarkerThicknessF = 4.0
  pmres2@gsMarkerColor = "gold"
 ; marker9=gsn_add_polymarker(wks,plot,-111.885,40.903,pmres2) ;csn network
  marker10=gsn_add_polymarker(wks,plot,-111.872,40.7364,pmres2)
  ;marker11=gsn_add_polymarker(wks,plot,-111.714,40.3414,pmres2) located in utah valley
 ; pmres3=True  ;add a rectagle in the left corner
  ;pmres3@gsMarkerColor="white"
  ;pmres3@gsMarkerOpacityF = 0.6
  ;pmres3@gsMarkerIndex=FilledSquare
  ;marker11=gsn_add_polymarker(wks, plot, -112.326, 40.3, pmres3)
  pmres3=True
   pmres3=pmres
  pmres3@gsMarkerColor = "black"
  pmres3@gsMarkerIndex = 2 
 ; marker15 = gsn_add_polymarker(wks,plot,-111.955,40.773,pmres3)
txres = True
 txres@txFontHeightF = 0.018
 marker11=gsn_add_polymarker(wks, plot, -112.31, 40.45, pmres)
 dum1= gsn_add_text(wks, plot, "ISFS", -112.25, 40.45, txres)
marker12=gsn_add_polymarker(wks, plot, -112.31, 40.40, pmres2)
 dum2 = gsn_add_text(wks,plot,"HW",-112.25,40.40,txres)
 ;marker13=gsn_add_polymarker(wks, plot, -112.31, 40.40, pmres1)
  ;dum3 = gsn_add_text(wks,plot,"NCAR sounding",-112.20,40.40,txres)
  marker14=gsn_add_polymarker(wks, plot, -112.31, 40.35, pmres1)
  dum4 = gsn_add_text(wks,plot,"ISS",-112.25,40.35,txres)
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
