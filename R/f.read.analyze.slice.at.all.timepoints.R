
f.read.analyze.slice.at.all.timepoints<-function(file,slice){
  #Reads in a slice of a .img file at all time points into an array
  file.name<-substring(file,1,nchar(file)-4)
   file.hdr<-paste(file.name,".hdr",sep="")
   file.img<-paste(file.name,".img",sep="")
   hdr<-f.read.analyze.header(file.hdr)
  #f.analyze.file.summary(file)

  #num.dim<-hdr$dim[1]
   dim<-hdr$dim[2:3]
  
  num.data.pts<-dim[1]*dim[2]
  if(slice<1 || slice>hdr$dim[4]) stop("slice is not in range")

  vl<-array(0,dim=hdr$dim[c(2,3,5)])
            
   if(hdr$datatype==4){
      for(i in 1:hdr$dim[5]){          
  offset<-(i-1)*hdr$dim[2]*hdr$dim[3]*hdr$dim[4]+(slice-1)*hdr$dim[2]*hdr$dim[3]
     vol<-.C("read2byte1",
             mat=integer(num.data.pts),
             file.img,
             as.integer(hdr$swap),
             as.integer(num.data.pts),
	     as.integer(offset*2))
     vol<-array(vol$mat,dim=dim)
  vl[,,i]<-vol
}
    }
      
   if(hdr$datatype==8){
     for(i in 1:hdr$dim[5]){          
  offset<-(i-1)*hdr$dim[2]*hdr$dim[3]*hdr$dim[4]+(slice-1)*hdr$dim[2]*hdr$dim[3]
     vol<-.C("read4byte1",
             mat=integer(num.data.pts),
             file.img,
             as.integer(hdr$swap),
             as.integer(num.data.pts),
	     as.integer(offset*4))
     vol<-array(vol$mat,dim=dim)
   vl[,,i]<-vol
   }
   }
            
   if(hdr$datatype==16){
     for(i in 1:hdr$dim[5]){          
  offset<-(i-1)*hdr$dim[2]*hdr$dim[3]*hdr$dim[4]+(slice-1)*hdr$dim[2]*hdr$dim[3]
     vol<-.C("readfloat1",
             mat=single(num.data.pts),
             file.img,
             as.integer(hdr$swap),
             as.integer(num.data.pts),
	     as.integer(offset*4))
     vol<-array(vol$mat,dim=dim)
   }
   }
            
   if(hdr$datatype==64){
     for(i in 1:hdr$dim[5]){          
  offset<-(i-1)*hdr$dim[2]*hdr$dim[3]*hdr$dim[4]+(slice-1)*hdr$dim[2]*hdr$dim[3]
     vol<-.C("readdouble1",
             mat=numeric(num.data.pts),
             file.img,
             as.integer(hdr$swap),
             as.integer(num.data.pts),
	     as.integer(offset*8))
     vol<-array(vol$mat,dim=dim)
   }}
  
     if(hdr$datatype==0||hdr$datatype==1||hdr$datatype==2||hdr$datatype==32||hdr$datatype==128||hdr$datatype==255) print(paste("The format",hdr$data.type,"is not supported yet. Please contact me if you want me to extend the functions to do this (marchini@stats.ox.ac.uk)"),quote=F)
       
   return(vl)}
