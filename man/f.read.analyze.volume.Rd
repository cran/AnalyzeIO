\name{f.read.analyze.volume}
\alias{f.read.analyze.volume}
\title{read whole .img file}
\description{Reads the ANALYZE image format .img file into an array.}
\usage{f.read.analyze.volume(file.img)}
\arguments{\item{file.img}{The location of the .img file to be read}}
\value{An array with the appropriate dimensions containing the image
  volume. A print out of the file information is also given. The
  function assumes that the corressponding .hdr file is in the same
  directory as the .img file. }
\seealso{
  \code{\link{f.read.analyze.slice}},
  \code{\link{f.read.analyze.slice.at.all.timepoints}},
  \code{\link{f.read.analyze.ts}}
}
\examples{a<-f.read.analyze.volume("./AnalyzeIO/example.img")
dim(a)}
\keyword{utilities}

