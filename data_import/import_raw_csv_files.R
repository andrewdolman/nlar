## Test importing .csv files from NLA2007
library(stringr)
library(plyr)
#library(readr)

# folder_names <- dir("inst/extdata/nla2007/")
# 
# clean_names <- str_replace_all(folder_names, " ", "_")

paths <- list.dirs("inst/extdata/nla2007/")

csv_files <- unlist(llply(paths, list.files, pattern = "\\.csv$", full.names=T))
txt_files <- unlist(llply(paths, list.files, pattern = "\\.txt$", full.names=T))

lst <- llply(csv_files, function(x) read.csv(file=x, as.is = TRUE))
lst_meta <- llply(txt_files, function(x) read.csv(file=x, as.is = TRUE, sep="\t"))

csv_nms <- basename(csv_files)
csv_nms <- str_replace_all(csv_nms, ".csv", "")
names(lst) <- csv_nms

txt_nms <- basename(txt_files)
txt_nms <- str_replace_all(txt_nms, ".txt", "")
names(lst_meta) <- txt_nms

llply(lst_meta, function(x) x$LABEL)

save(list=names(lst), file = paste0("data/", "NLA2007_imported_csv_files", ".Rdata"), envir=as.environment(lst))
save(list="lst", file = paste0("data/", "NLA2007_imported_csv_files_as_list", ".Rdata"))

#load("data/test2.Rdata")




tmp <- read.csv("inst/extdata/nla2007/Information for Lakes that were Sampled/LakeInformation_sampled_20091113.csv", as.is = TRUE)
tmp_meta <- read.csv("inst/extdata/nla2007/Information for Lakes that were Sampled/LakesInformation_Sampled_info_20091113.txt", as.is = TRUE, sep="\t")
tmp_meta$LABEL

attr(tmp, "LABEL") <- tmp_meta$LABEL
  
tmp2 <- lapply(names(tmp), function(x) attr(tmp[,x], "LABEL") <- "test")

attributes(tmp)




