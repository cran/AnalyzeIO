
f.write.array.to.img.2bytes<-function(mat,file){
  #writes an array into a .img file of 2 byte integers 

  dm<-dim(mat)
  dm.ln<-length(dm)
  num.data.pts<-length(mat)
  
  .C("write2byte",
     as.integer(mat),
     file,
     as.integer(num.data.pts))

  }

