

f.analyzeIO.gui<-function(){

  #starts GUI that allows user to explore an fMRI dataset stored in an ANALYZEfile
  
  path<-.path.package(package="AnalyzeIO")
  path.gui<-paste(path,"/AnalyzeIOgui.R",sep="")
  source(path.gui)}

