#!/usr/bin/env Rscript

source("Lu_R_Lib.R")

mydata=read.csv("data.csv")

x=mydata[["SleepNum"]]
y1=mydata[["Sum_Concurent"]]
y2=mydata[["System"]]
y3=mydata[["CPU"]]
y4=mydata[["CPU_Concurent"]]

PdfPlotCurves(x, y1, x, y2, x, y3, x, y4
	      ,ylegends=c("Sum_Concurent","System","CPU","CPU_Concurent")
	      #,logAxis="xy"
	      )
