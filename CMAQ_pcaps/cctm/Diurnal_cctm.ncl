load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/time_axis_labels.ncl"
begin
scen="nonpcaps"
if (scen.eq."pcaps")
cctmfile="/data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/cctm/combines_post_Y.csv"
count=584
else
cctmfile="/data/gpfs/home/xsun/work/nclscripts/CMAQ_pcaps/cctm/combines_post_N.csv"
count=158
end if
delim=","
vars=asciiread(cctmfile, -1, "string")
delim=","
hr=tointeger(str_get_field(vars(1::),5,delim))
print(hr(0))
hnh31=tofloat(str_get_field(vars(1::), 6, delim))
hnh32=tofloat(str_get_field(vars(1::), 7, delim))
hnh33=tofloat(str_get_field(vars(1::), 8, delim))

hN2O51=tofloat(str_get_field(vars(1::), 9, delim))
hN2O52=tofloat(str_get_field(vars(1::), 10, delim))
hN2O53=tofloat(str_get_field(vars(1::), 11, delim))

hNHX1=tofloat(str_get_field(vars(1::), 12, delim))
hNHX2=tofloat(str_get_field(vars(1::), 13, delim))
hNHX3=tofloat(str_get_field(vars(1::), 14, delim))

hPM25_NH41=tofloat(str_get_field(vars(1::), 15, delim))
hPM25_NH42=tofloat(str_get_field(vars(1::), 16, delim))
hPM25_NH43=tofloat(str_get_field(vars(1::), 17, delim))

hPM25_NO31=tofloat(str_get_field(vars(1::), 18, delim))
hPM25_NO32=tofloat(str_get_field(vars(1::), 19, delim))
hPM25_NO33=tofloat(str_get_field(vars(1::), 20, delim))

hPM25_OC1=tofloat(str_get_field(vars(1::), 21, delim))
hPM25_OC2=tofloat(str_get_field(vars(1::), 22, delim))
hPM25_OC3=tofloat(str_get_field(vars(1::), 23, delim))

hPM25_EC1=tofloat(str_get_field(vars(1::), 24, delim))
hPM25_EC2=tofloat(str_get_field(vars(1::), 25, delim))
hPM25_EC3=tofloat(str_get_field(vars(1::), 26, delim))

hPM25_SO41=tofloat(str_get_field(vars(1::), 27, delim))
hPM25_SO42=tofloat(str_get_field(vars(1::), 28, delim))
hPM25_SO43=tofloat(str_get_field(vars(1::), 28, delim))
csv_filename="Diurnal_CCTM_"+scen+"_HW.csv"
header=[/"Hour"+",avenh31"+",avenh32"+",avenh33"+",aveN2O51"+",aveN2O52"+",aveN2O53"+",aveNHX1"+",aveNHX2"+",aveNHX3"+",avePM25_NH41"+",avePM25_NH42"+",avePM25_NH43"+",avePM25_NO31"+",avePM25_NO32"+",avePM25_NO33"+",avePM25_OC1"+",avePM25_OC2"+",avePM25_OC3"+",avePM25_EC1"+",avePM25_EC2"+",avePM25_EC3"+",avePM25_SO41"+",avePM25_SO42"+",avePM25_SO43"/]
write_table(csv_filename,"w",header,"%s")
do j=0,23,1
    n=0.0
    sumnh31=0.0
    sumnh32=0.0
    sumnh33=0.0

    sumN2O51=0.0
    sumN2O52=0.0
    sumN2O53=0.0

    sumNHX1=0.0
    sumNHX2=0.0
    sumNHX3=0.0

    sumPM25_NH41=0.0
    sumPM25_NH42=0.0
    sumPM25_NH43=0.0

    sumPM25_NO31=0.0
    sumPM25_NO32=0.0
    sumPM25_NO33=0.0

    sumPM25_OC1=0.0
    sumPM25_OC2=0.0
    sumPM25_OC3=0.0


    sumPM25_EC1=0.0
    sumPM25_EC2=0.0
    sumPM25_EC3=0.0

    sumPM25_SO41=0.0
    sumPM25_SO42=0.0
    sumPM25_SO43=0.0

  
    do i=0,count,1
        if(hr(i).eq.j)
            n=n+1
          sumnh31=sumnh31+hnh31(i)
          sumnh32=sumnh32+hnh32(i)
          sumnh33=sumnh33+hnh33(i)

            sumN2O51=sumN2O51+hN2O51(i)
          sumN2O52=sumN2O52+hN2O52(i)
          sumN2O53=sumN2O53+hN2O53(i)

             sumNHX1=sumNHX1+hNHX1(i)
          sumNHX2=sumNHX2+hNHX2(i)
          sumNHX3=sumNHX3+hNHX3(i)

           
             sumPM25_NH41=sumPM25_NH41+hPM25_NH41(i)
          sumPM25_NH42=sumPM25_NH42+hPM25_NH42(i)
          sumPM25_NH43=sumPM25_NH43+hPM25_NH43(i)

               sumPM25_NO31=sumPM25_NO31+hPM25_NO31(i)
          sumPM25_NO32=sumPM25_NO32+hPM25_NO32(i)
          sumPM25_NO33=sumPM25_NO33+hPM25_NO33(i)

            sumPM25_OC1=sumPM25_OC1+hPM25_OC1(i)
          sumPM25_OC2=sumPM25_OC2+hPM25_OC2(i)
          sumPM25_OC3=sumPM25_OC3+hPM25_OC3(i)

            sumPM25_EC1=sumPM25_EC1+hPM25_EC1(i)
          sumPM25_EC2=sumPM25_EC2+hPM25_EC2(i)
          sumPM25_EC3=sumPM25_EC3+hPM25_EC3(i)
          
           sumPM25_SO41=sumPM25_SO41+hPM25_SO41(i)
          sumPM25_SO42=sumPM25_SO42+hPM25_SO42(i)
          sumPM25_SO43=sumPM25_SO43+hPM25_SO43(i)
         end if
       end do
       avenh31=sumnh31/n
       avenh32=sumnh32/n
       avenh33=sumnh33/n

        aveN2O51=sumN2O51/n
       aveN2O52=sumN2O52/n
       aveN2O53=sumN2O53/n

        aveNHX1=sumNHX1/n
       aveNHX2=sumNHX2/n
       aveNHX3=sumNHX3/n

        avePM25_NH41=sumPM25_NH41/n
       avePM25_NH42=sumPM25_NH42/n
       avePM25_NH43=sumPM25_NH43/n

        avePM25_NO31=sumPM25_NO31/n
       avePM25_NO32=sumPM25_NO32/n
       avePM25_NO33=sumPM25_NO33/n

        avePM25_OC1=sumPM25_OC1/n
       avePM25_OC2=sumPM25_OC2/n
       avePM25_OC3=sumPM25_OC3/n

        avePM25_EC1=sumPM25_EC1/n
       avePM25_EC2=sumPM25_EC2/n
       avePM25_EC3=sumPM25_EC3/n

        avePM25_SO41=sumPM25_SO41/n
       avePM25_SO42=sumPM25_SO42/n
       avePM25_SO43=sumPM25_SO43/n
    alist=[/j,avenh31,avenh32,avenh33,aveN2O51,aveN2O52,aveN2O53,aveNHX1,aveNHX2,aveNHX3,avePM25_NH41,avePM25_NH42,avePM25_NH43,avePM25_NO31,avePM25_NO32,avePM25_NO33,avePM25_OC1,avePM25_OC2,avePM25_OC3,avePM25_EC1,avePM25_EC2,avePM25_EC3,avePM25_SO41,avePM25_SO42,avePM25_SO43/]
    format="%i,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g,%g"
write_table(csv_filename, "a", alist, format)
end do 
end