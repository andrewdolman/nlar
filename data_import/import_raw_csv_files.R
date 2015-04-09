## Test importing .csv files from NLA2007
library(stringr)
library(plyr)

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

save(list=names(lst), file = paste0("data/", "NLA2007_imported_csv_files", ".Rdata"), envir=as.environment(lst))
save(list="lst", file = paste0("data/", "NLA2007_imported_csv_files_as_list", ".Rdata"))


## Try to add the LABEL column from the text files as attributes to the appropriate columns in the appropriate dataframes.
# Problem is that there are more dataframes than text files

llply(lst_meta, function(x) x$LABEL)


