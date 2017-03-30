# nlar

Data from the National Lakes Assessment 2007 as an R package.

U.S. Environmental Protection Agency. 2010. National Aquatic Resource Surveys. 

National Lakes Assessment 2007 (data and metadata files). Available from 
U.S. EPA website: http://www.epa.gov/national-aquatic-resource-surveys/data-national-aquatic-resource-surveys. 

The National Lakes Assessment 2007 data were a result of the collective efforts 
of dedicated field crews, laboratory staff, data management and quality control staff, 
analysts and many others from EPA, states, tribes, federal agencies, universities, 
and other organizations. Please contact nars-hq@epa.gov with any questions.


## Structure

Each supplied .csv has been imported as a separate data.frame (actually tibble).

NLA2007_KEY is a dataframe with a description all variables across all dataframes

NLA_SELECTED_VARIABLES is a subset of variables, mostly site characteristics and nutrient data

NLA_SELECTED_VARIABLES_KEY contains the descriptions for this subset
