
f.read.analyze.ts<-function(file,x,y,z){
  #Reads in a .img file into an array
  file.name<-substring(file,1,nchar(file)-4)
   file.hdr<-paste(file.name,".hdr",sep="")
   file.img<-paste(file.name,".img",sep="")
   hdr<-f.read.analyze.header(file.hdr)
  #f.analyze.file.summary(file)

  if(x<1 || x>hdr$dim[2]) stop("x is not in range")
  if(y<1 || y>hdr$dim[3]) stop("y is not in range")
  if(z<1 || z>hdr$dim[4]) stop("z is not in range")
  
offset.start<-(z-1)*hdr$dim[2]*hdr$dim[3]+(y-1)*hdr$dim[2]+(x-1)
offset.add<-hdr$dim[2]*hdr$dim[3]*hdr$dim[4]
  
vol<-1:hdr$dim[5]

  if(hdr$datatype==4){
  for(i in 1:hdr$dim[5]){

     v<-.C("read2byte1",
             mat=integer(1),
             file.img,
             as.integer(hdr$swap),
             as.integer(1),
	     as.integer(offset.start*2+2*(i-1)*offset.add))
     vol[i]<-v$mat}
   }
  
  if(hdr$datatype==8){
  for(i in 1:hdr$dim[5]){

     v<-.C("read4byte1",
             mat=integer(1),
             file.img,
             as.integer(hdr$swap),
             as.integer(1),
	     as.integer(offset.start*4+4*(i-1)*offset.add))
     vol[i]<-v$mat}
   }
  
  if(hdr$datatype==16){
  for(i in 1:hdr$dim[5]){

     v<-.C("readfloat1",
             mat=integer(1),
             file.img,
             as.integer(hdr$swap),
             as.integer(1),
	     as.integer(offset.start*4+4*(i-1)*offset.add))
     vol[i]<-v$mat}
   }
  
  if(hdr$datatype==64){
  for(i in 1:hdr$dim[5]){

     v<-.C("readdouble1",
             mat=integer(1),
             file.img,
             as.integer(hdr$swap),
             as.integer(1),
	     as.integer(offset.start*8+8*(i-1)*offset.add))
     vol[i]<-v$mat}
   }
  
     if(hdr$datatype==0||hdr$datatype==1||hdr$datatype==2||hdr$datatype==32||hdr$datatype==128||hdr$datatype==255) print(paste("The format",hdr$data.type,"is not supported yet. Please contact me if you want me to extend the functions to do this (marchini@stats.ox.ac.uk)"),quote=F)
       
   return(vol)}


