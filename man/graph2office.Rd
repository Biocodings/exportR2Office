% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/graph2office.R
\name{graph2office}
\alias{graph2doc}
\alias{graph2office}
\alias{graph2ppt}
\title{Save currently active R graph to Microsoft Office / LibreOffice format}
\usage{
graph2office(x = NULL, file = "Rplot", fun = NULL, type = c("PPT",
  "DOC"), append = FALSE, aspectr = NULL, width = NULL, height = NULL,
  scaling = 100, paper = "auto", orient = ifelse(type[1] == "PPT",
  "landscape", "auto"), margins = c(top = 0.5, right = 0.5, bottom = 0.5, left
  = 0.5), center = TRUE, offx = 1, offy = 1, upscale = FALSE,
  vector.graphic = TRUE, font = ifelse(Sys.info()["sysname"] == "Windows",
  "Arial", "Helvetica")[[1]], ...)

graph2ppt(...)

graph2doc(...)
}
\arguments{
\item{x}{given \code{ggplot2} plot or \code{lattice} plot object to export; if
set to \code{NULL} the currently active R graph will be exported; not
supported for base R plots.}

\item{file}{name of output file. Any extension is ignored and added
according to the requested output type.}

\item{fun}{plot passed on as a function used to create it; useful especially
for base R plots.}

\item{type}{desired output type - \code{DOC} for Word document, \code{PPT} for Powerpoint.}

\item{append}{logical value - if \code{TRUE} and \code{type=PPT} it will append the graph
to the given file, where file can also be a given corporate template. If
\code{append=FALSE} any existing file will be overwritten. Currently ignored in
Word export.}

\item{aspectr}{desired width to height aspect ratio. If set to \code{NULL}, the
aspect ratio of the active graphics device is used.}

\item{width}{desired width in inches; can be combined with a desired
aspect ratio aspectr.}

\item{height}{desired height in inches; can be combined with a desired
aspect ratio aspectr.}

\item{scaling}{scale width & height by a certain percentage.}

\item{paper}{desired paper size to use - "A5" to "A1" for Powerpoint export,
or "A5" to "A3" for Word output; default "auto" automatically selects the
paper size that fits your graph. Graphs that are too large to fit on a given
paper size are scaled down.}

\item{orient}{desired paper orientation - "auto", "portrait" or "landscape";
default to "auto" for Word output and to "landscape" for Powerpoint.}

\item{margins}{vector with the desired margins that should be left blank in}

\item{center}{logical specifying whether or not to center the graph
in the exported Powerpoint.}

\item{offx}{if center is set to \code{FALSE}, the desired x offset at which to
place one's graph in Powerpoint output.}

\item{offy}{if center is set to \code{FALSE}, the desired y offset at which to
place one's graph in Powerpoint output.}

\item{upscale}{logical specifying whether or not to upscale one's graph to
make it page-filling (excluding the margins). Note that scaling may result
in a different look of one's graph relative to how it looks on the screen
due to the change in size.}

\item{vector.graphic}{logical specifying whether or not to output in
editable, vector \code{DrawingML} format. Defaults to \code{TRUE}, in which case editing
the plot in Powerpoint or Word is then possible after first ungrouping the
plot elements. If set to \code{FALSE}, the plot is rasterized to \code{PNG} bitmap
format at a resolution of 300 dpi.}

\item{font}{desired font to use; defaults to \code{"Arial"} on Windows
systems and to \code{"Helvetica"} on other systems.}

\item{\dots}{any other options are passed on to \code{ReporteR}'s \code{\link[ReporteRs]{addPlot}} function.}
}
\value{
\code{NULL}
}
\description{
Save the currently active R graph or a graph passed as an object or function
to Microsoft Office / LibreOffice format with sensible defaults
}
\section{Functions}{
\itemize{
\item \code{graph2ppt}: 

\item \code{graph2doc}: 
}}
\examples{
# export of ggplot2 plot
library(ggplot2)
x=qplot(Sepal.Length, Petal.Length, data = iris, color = Species, 
      size = Petal.Width, alpha = I(0.7))
x
graph2ppt(x=x) # export graph with current graphics window width & height
graph2ppt(x=x,width=9,aspectr=sqrt(2)) # export graph with A4 aspect ratio
graph2ppt(x=x,vector.graphic=FALSE,width=9,aspectr=sqrt(2)) # export as 300 dpi PNG bitmap

\dontrun{
# use active graph instead of passing plot as object
graph2ppt(file="ggplot2_plot.pptx", aspectr=1.7)
# add 2nd slide with same graph in A4 aspect ratio
graph2ppt(file="ggplot2_plot.pptx", aspectr=sqrt(2), append=TRUE) 
# add 3d slide with same graph in A4 aspect ratio with a width of 9 inches
graph2ppt(file="ggplot2_plot.pptx", width=10, aspectr=sqrt(2), append=TRUE) 
# add 4th slide with same graph with fixed width & height
graph2ppt(file="ggplot2_plot.pptx", width=6, height=5, append=TRUE)
# add 5th slide with page-filled version of same graph
graph2ppt(file="ggplot2_plot.pptx", margins=0, upscale=TRUE, append=TRUE) 

# export to Word
graph2doc(aspectr=1.7) 
graph2doc(paper="A3", orient="portrait", aspectr=1.7) 

# export of lattice plot
library(lattice)
library(effects)
fit=lm(prestige ~ type + income*education, data=Prestige)
plot(Effect(c("income", "education"), fit, partial.residuals=TRUE),multiline=TRUE, 
     span=1, show.fitted=TRUE, ci.style="bands")
graph2ppt(file="effect_plot.pptx")

# pass plot as object
x=plot(Effect(c("income", "education"), fit, partial.residuals=TRUE),multiline=TRUE, 
     span=1, show.fitted=TRUE, ci.style="bands")
graph2ppt(x=x,file="effect_plot.pptx")


# example export of base R plot
boxplot(mpg~cyl,data=mtcars,col="cyan2")
graph2ppt(file="boxplot.pptx")

# passing it as an object does not work
# p=boxplot(mpg~cyl,data=mtcars,col="cyan2")
# ylab="Miles Per Gallon",col="cyan2")
# graph2ppt(obj=p,file="boxplot.pptx") # this does not work

# passing it as a function does work
f=function() boxplot(mpg~cyl,data=mtcars,col="cyan2")
graph2ppt(fun=f, file="boxplot.pptx", aspectr=1.3)


# heatmap example
heatmap(as.matrix(eurodist))
graph2ppt(file="heatmap.pptx")
}
}
\author{
Tom Wenseleers
}
\seealso{
\code{\link{graph2tex}}, \code{\link{graph2vector}}, \code{\link{graph2svg}}, \code{\link{graph2pdf}}, \code{\link{graph2eps}},
\code{\link{graph2bitmap}}, \code{\link{graph2png}}, \code{\link{graph2tif}}, \code{\link{graph2jpg}}
}

