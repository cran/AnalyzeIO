
f.basic.hdr.list.create<-function(mat,file.hdr){

 #creates a basic list that can be used to write a .hdr file
  
  dim<-dim(mat)
  dim<-c(length(dim),dim,rep(0,7-length(dim)))
  
  l<-list(file=file.hdr,
          size.of.header=348,
          data.type=paste(rep(" ",10),sep="",collapse=""),
          db.name=paste(rep(" ",18),sep="",collapse=""),
          extents=0,
          session.error=0,
          regular=character(1),
          hkey.un0=character(1),
          dim=as.integer(dim),
          vox.units="mm",
          cal.units="voxels",
          unused1=0,
          datatype=0,
          bitpix=0,
          dim.un0=0,
          pixdim=single(8),
          vox.offset=single(1),
          funused1=single(1),
          funused2=single(1),
          funused3=single(1),
          cal.max=single(1),
          cal.min=single(1),
          compressed=single(1),
          verified=single(1),
          glmax=0,
          glmin=0,
          descrip=paste(rep(" ",80),sep="",collapse=""),
          aux.file= paste(rep(" ",24),sep="",collapse=""),
          orient=paste(rep(" ",1),sep="",collapse=""),
          originator=paste(rep(" ",10),sep="",collapse=""),
          generated=paste(rep(" ",10),sep="",collapse=""),
          scannum=paste(rep(" ",10),sep="",collapse=""),
          patient.id=paste(rep(" ",10),sep="",collapse=""),
          exp.date=paste(rep(" ",10),sep="",collapse=""),
          exp.time=paste(rep(" ",10),sep="",collapse=""),
          hist.un0=paste(rep(" ",3),sep="",collapse=""),
          views=integer(1),
          vols.added=integer(1),
          start.field=integer(1),
          field.skip=integer(1),
          omax=integer(1),
          omin=integer(1),
          smax=integer(1),
          smin=integer(1) )
  return(l)
}
