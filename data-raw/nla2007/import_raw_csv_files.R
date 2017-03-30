## Test importing .csv files from NLA2007
library(stringr)
library(tidyverse)

paths <- list.dirs("data-raw/nla2007")

csv_files <- unlist(plyr::llply(paths, list.files, pattern = "\\.csv$", full.names=T))
txt_files <- unlist(plyr::llply(paths, list.files, pattern = "\\.txt$", full.names=T))

lst <- plyr::llply(csv_files, function(x) read.csv(file=x, as.is = TRUE))
lst_meta <- plyr::llply(txt_files, function(x) read.csv(file=x, as.is = TRUE, sep="\t"))

csv_nms <- basename(csv_files)
csv_nms <- str_replace_all(csv_nms, ".csv", "")
names(lst) <- csv_nms

txt_nms <- basename(txt_files)
txt_nms <- str_replace_all(txt_nms, ".txt", "")
names(lst_meta) <- txt_nms

#save(list=names(lst), file = paste0("data/", "NLA2007_imported_csv_files", ".Rdata"), envir=as.environment(lst))
#save(list="lst", file = paste0("data/", "NLA2007_imported_csv_files_as_list", ".Rdata"))

list2env(lst, envir=.GlobalEnv)

devtools::use_data(`NLA2007_Basin_Landuse_Metrics_20061022`, `NLA2007_Buffer_Landuse_Metrics_20091022`, 
                   `NLA2007_Chemical_ConditionEstimates_20091123`, `NLA2007_MeanDO_ConditionEstimate_20091123`, 
                   `NLA2007_MeanDO_Data_20091007`, `NLA2007_PHab_CondtionEstimates_20091130`, 
                   `NLA2007_PHab_IndexValues`, `NLA2007_PHab_Metrics_A`, `NLA2007_PHab_Metrics_B`, 
                   `NLA2007_Phytoplankton_DiatomCount_20091125`, `NLA2007_Phytoplankton_SampleInfo_20091023`, 
                   `NLA2007_Phytoplankton_SoftAlgaeCount_20091023`, `NLA2007_Plankton_OEModel_AnalysisData_20091019`, 
                   `NLA2007_Plankton_OEModel_ConditionEstimates_20091125`, `NLA2007_Plankton_OEModel_ValidSitesUsed_20091021`, 
                   `NLA2007_Profile_20091008`, `NLA2007_Recreational_ConditionEstimates_20091123`, 
                   `NLA2007_SampledLakeInformation_20091113`, `NLA2007_Secchi_20091008`, 
                   `NLA2007_SedimentDiatoms_Count_Bottom_20091026`, `NLA2007_SedimentDiatoms_Count_Top_20091026`, 
                   `NLA2007_SedimentDiatoms_IBI_ConditionEstimate_20091123`, `NLA2007_SedimentDiatoms_Index_Data_20091123`, 
                   `NLA2007_SedimentDiatoms_InferenceModel_20091124`, `NLA2007_SedimentDiatoms_InferenceModel_ConditionEstimate_20091124`, 
                   `NLA2007_SedimentDiatoms_SampleInformation_20091102`, `NLA2007_SedimentDiatoms_Top&Bottom_InferenceModel_Data_20091103`, 
                   `NLA2007_Trophic_ConditionEstimate_20091123`, `NLA2007_VisualAssessment_20091015`, 
                   `NLA2007_WaterQuality_20091123`, `NLA2007_Zooplankton_Count_20091022`, 
                   `NLA2007_Zooplankton_SampleInformation_20091020`, overwrite = T)

nla_2007_key <- plyr::ldply(lst_meta, function(x) data.frame(NAME = x$NAME, LABEL = x$LABEL), .id = "SHEET") %>% 
  dplyr::tbl_df() %>% 
  group_by(NAME) %>% 
  select(NAME, SHEET, LABEL) %>% 
  arrange(NAME, SHEET, LABEL)

devtools::use_data(nla_2007_key)



