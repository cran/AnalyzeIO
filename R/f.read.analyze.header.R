
f.read.analyze.header<-function(file){
  #This function reads in the information from an ANALYZE format .hdr file
 file.name<-substring(file,1,nchar(file)-4)
 file.hdr<-paste(file.name,".hdr",sep="")
 file.img<-paste(file.name,".img",sep="")


 
#Detect whether the data is big or little endian. The first part of a .hdr file is the size of the file which is always a C int (i.e. 4 bytes) and always has value 348. Therefore trying to read it in assuming little-endian will tell you if that is the correct mode
 swap<-0
 if(.C("read4byte1",
	ans = integer(1),
	file.hdr,as.integer(1),
	as.integer(1),
	as.integer(0))$ans==348) swap<-1 


# A C function is used to read in all the components of the .hdr file
a<-.C("read_analyze_header",
      file.hdr,
      as.integer(swap),
      integer(1),
      paste(rep(" ",10),sep="",collapse=""),
      paste(rep(" ",18),sep="",collapse=""),
      integer(1),
      integer(1),
      paste(rep(" ",1),sep="",collapse=""),
      paste(rep(" ",1),sep="",collapse=""),
      integer(8),
      paste(rep(" ",4),sep="",collapse=""),
      paste(rep(" ",8),sep="",collapse=""),
      integer(1),
      integer(1),
      integer(1),
      integer(1),
      single(8),
      single(1),
      single(1),
      single(1),
      single(1),
      single(1),
      single(1),
      single(1),
      single(1),
      integer(1),
      integer(1),
      paste(rep(" ",80),sep="",collapse=""),
      paste(rep(" ",24),sep="",collapse=""),
      paste(rep(" ",1),sep="",collapse=""),
      paste(rep(" ",10),sep="",collapse=""),
      paste(rep(" ",10),sep="",collapse=""),
      paste(rep(" ",10),sep="",collapse=""),
      paste(rep(" ",10),sep="",collapse=""),
      paste(rep(" ",10),sep="",collapse=""),
      paste(rep(" ",10),sep="",collapse=""),
      paste(rep(" ",3),sep="",collapse=""),
      integer(1),
      integer(1),
      integer(1),
      integer(1),
      integer(1),
      integer(1),
      integer(1),
      integer(1))

#A list (called L) is created containing a selection of the useful components of the .hdr file

 L<-list()
 L$swap<-a[[2]]
 L$file.name<-file.img
 L$dim<-a[[10]]
 L$vox.units<-a[[11]]
 L$cal.units<-a[[12]]
 L$datatype<-a[[14]]
 if(L$datatype==0) L$data.type<-"unknown"
 if(L$datatype==1) L$data.type<-"binary"
 if(L$datatype==2) L$data.type<-"unsigned char"
 if(L$datatype==4) L$data.type<-"signed short"
 if(L$datatype==8) L$data.type<-"signed int"
 if(L$datatype==16) L$data.type<-"float"
 if(L$datatype==32) L$data.type<-"complex"
 if(L$datatype==64) L$data.type<-"double precision"
 if(L$datatype==128) L$data.type<-"rgb data"
 if(L$datatype==255) L$data.type<-"all"
 L$bitpix<-a[[15]]
 L$pixdim<-a[[17]]
 L$glmax<-a[[26]]
 L$glmin<-a[[27]]
         
 return(L)}

