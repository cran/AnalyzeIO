
f.spectral.summary<-function(file,mask.file,ret.flag=F)
{
  #for an analyze .img file the periodogram of the time series are divided by a flat spectral estimate using the median periodogram ordinate. The resulting values are then combined within each Fourier frequency and quantiles are plotted against freequency. This provides a fast look at a fMRI dataset to identify any artefacts that reside at single frequencies.
  
########################
#get info about dataset
########################  
  file.name<-substring(file,1,nchar(file)-4)
  file.hdr<-paste(file.name,".hdr",sep="")
  file.img<-paste(file.name,".img",sep="")
  hdr<-f.read.analyze.header(file.hdr)
  nsl<-hdr$dim[4]
  nim<-hdr$dim[5]
  pxdim<-hdr$pixdim[2:4]
  
##################### 
#read in/create mask
#####################
  
  f.mask.create<-function(dat,pct=.1,slices=c(0)) {
  #function that creats a mask for an fMRI dataset by thresholding the mean of the pixel time series at a percentage point of the maximum intensity of the dataset
  file.name<-substring(dat$file,1,nchar(dat$file)-4)
  file.hdr<-paste(file.name,".hdr",sep="")
  hdr<-f.read.analyze.header(file.hdr)
  nsl<-hdr$dim[4]
  xc<-hdr$dim[2]
  yc<-hdr$dim[3]
 
  if(slices[1]==0){slices<-seq(1,nsl)}
  mask<-array(0,dim=c(length(slices),xc,yc))

  max.int<-0
  for(k in 1:length(slices)){        
    slice<-f.read.analyze.slice.at.all.timepoints(dat$file,slices[k])
    if(max(slice)>max.int){max.int<-max(slice)}
  }

  for(k in 1:length(slices)){        
    slice<-f.read.analyze.slice.at.all.timepoints(dat$file,slices[k])

    for(i in 1:(xc*yc)){
      a<-(i-1)%/%xc+1
      b<-i-(a-1)*xc     
      mask[k,b,a]<-mean(slice[b,a,])}

    if(mask[k,b,a]>=(pct*max.int)){mask[k,b,a]<-1}
    else{mask[k,b,a]<-0}
  }

  return(mask)

}

  if(mask.file!=F){mask<-f.read.analyze.volume(mask.file)}
  else{
dat<-list(file=file,mask.file=mask.file)
    mask<-f.mask.create(dat)}
  dim(mask)<-hdr$dim[2:4]
    
###############
#set constants
###############
  
  n<-floor(nim/2)+1

  
##########################
#initialise storage arrays
##########################

  res<-array(NA,dim=c(dim(mask),n))
 
#####################
#main evaluation loop
#####################
  
  for(l in 1:nsl){
    print(c("Processing slice",l))
 
    slice<-f.read.analyze.slice.at.all.timepoints(file,l)
  

    for(i in 1:(dim(slice)[1]*dim(slice)[2])){
      a<-(i-1)%/%dim(slice)[1]+1
      b<-i-(a-1)*dim(slice)[1]
      if(mask[b,a,l]==1){
        t<-Mod(fft(slice[b,a,])/sqrt(2*pi*nim))[1:n]
        s<-median(t)
        res[b,a,l,]<-t/s
      }
    }
  }
    
b<-apply(res,4,FUN=quantile,probs=seq(.5,1,.05),na.rm=T)
  plot(c(0,n-1),c(0,30),type="n",xlab="",ylab="",axes=F)
  axis(1,at=seq(0,n,5))
  axis(2,at=seq(0,30,5))
  for(i in 0:(n-1)){
  points(rep(i,11),b[,i+1])}
  if(ret.flag==T)  return(b)
}





