
f.analyze.file.summary<-function(file){
  #This function prints out a concise summary of the contents of a .img/.hdr image pair
 file.name<-substring(file,1,nchar(file)-4)
 file.hdr<-paste(file.name,".hdr",sep="")
 file.img<-paste(file.name,".img",sep="")
 hdr<-f.read.analyze.header(file.hdr)
 print("",quote=F)
 print(paste("       File name:",file.img),quote=F)
 print(paste("  Data Dimension:",paste(hdr$dim[1],"-D",sep="")),quote=F)
 print(paste("     X dimension:",hdr$dim[2]),quote=F)
 print(paste("     Y dimension:",hdr$dim[3]),quote=F)
 print(paste("     Z dimension:",hdr$dim[4]),quote=F)
 print(paste("  Time dimension:",hdr$dim[5],"time points"),quote=F)
 print(paste("Voxel dimensions:",paste(hdr$pixdim[2],hdr$vox.units,"x",
                                   hdr$pixdim[3],hdr$vox.units,"x",
                                   hdr$pixdim[4],hdr$vox.units)),quote=F)
 print(paste("       Data type:",hdr$data.type,paste("(",hdr$bitpix," bits per voxel)",sep="")),quote=F)
}
