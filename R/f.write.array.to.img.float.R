

f.write.array.to.img.float<-function(mat,file){
  #writes an array into a .img file of 4 byte flotas

  dm<-dim(mat)
  dm.ln<-length(dm)
  num.data.pts<-length(mat)
  
  .C("writefloat",
     as.single(mat),
     file,
     as.integer(num.data.pts))
}
