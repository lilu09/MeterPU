#!/usr/bin/env Rscript

source("Lu_R_Lib.R")


path="../" 

time_file=paste0(path,"time_event.csv")
original_data_file=paste0(path,"original_power_data.csv")
corrected_data_file=paste0(path, "corrected_power_data.csv")

time_data=read.csv(time_file)
original_data=read.csv(original_data_file)
corrected_data=read.csv(corrected_data_file)

min_v=min(original_data[[1]], corrected_data[[1]])


PlotCurves(
	      (original_data[[1]]-min_v)/1e3, original_data[[2]]
	      ,(corrected_data[[1]]-min_v)/1e3, corrected_data[[2]]
	      ,v1=(time_data[[1]]-min_v)/1e3
	      ,v2=(time_data[[2]]-min_v)/1e3
	      ,ylegends=c("Original Data", "Corrected Data")
	      ,xlabel="Time (ms)"
	      ,ylabel="Power (mW)"
	      )
