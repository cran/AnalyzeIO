f.write.analyze<-function(mat,file,size="float",pixdim=c(4,4,6),vox.units="mm",cal.units="pixels"){

  #Creates a .img and .hdr pair of files froma given array

  if(max(mat)=="NA") return("NA values in array not allowed. Files not written.")
  
  file.img<-paste(file,".img",sep="")
  file.hdr<-paste(file,".hdr",sep="")

  L<-f.basic.hdr.list.create(mat,file.hdr)
  
  if(size=="float"){
    L$datatype<-16
    L$bitpix<-32
    L$vox.units<-vox.units
    L$cal.units<-cal.units
    L$pixdim<-c(4,pixdim,0,0,0,0)
    L$data.type<-"float"
    L$glmax<-as.integer(floor(max(mat)))
    L$glmin<-as.integer(floor(min(mat)))
    f.write.array.to.img.float(mat,file.img)
  }
  if(size=="int"){
    if(max(mat)>32767 || min(mat)<(-32768)) return("Values are outside integer range. Files not written.")
    L$datatype<-4
    L$bitpix<-16
    L$vox.units<-vox.units
    L$cal.units<-cal.units
    L$pixdim<-c(4,pixdim,0,0,0,0)
    L$data.type<-"signed short"
    L$glmax<-as.integer(floor(max(mat)))
    L$glmin<-as.integer(floor(min(mat)))
    f.write.array.to.img.2bytes(mat,file.img)
  }
  
  f.write.list.to.hdr(L,file.hdr)
}
  
