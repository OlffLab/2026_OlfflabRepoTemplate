#################################################
# How to read from a Google Sheets database in R
# where the whole database is read as a list object, 
# with each sheet as a separate data frame in the list
# More info: f.o.ledidi@rug.nl
# Example data: wildlife census data for 14 transects 
# of 4 km long each, 200 m wide,2023-2024
##################################################-

#--------------------------01 Set up the environment ----
# !!!Remember to first pull the latest changes from the Github repository in the Git tab topright

# run the setup script for user-defined functions and Google Sheets authentication
source("scripts/01-setup.R")
gsheets_auth() # authenticate google sheets access, this will open a browser window for authentication if not already authenticated, note this function is defined in script 01-setup.r

# load libraries specific for this script (not in 01-setup.R)

#--------------------------02 read the data  and prepare dataframe for analysis----
# database link is the url to the google sheets database (not a published csv file anymore)
# reading requires google sheets authentication (see above)
database_link <- "https://docs.google.com/spreadsheets/d/1m-liu8omZMewqz_YP9j_YUmQ0zwATl3z4aRLnZFnfWc"
# to view the database in the browser: 
# browseURL(database_link)
# read the data from the database, useing the function read_gsdb() that is defined in the script 01-setup.r
data <- read_gsdb(database_link, sheets=c("DimTransect", "DimSection", "FactSectionAnimals", "DimSpecies")) 
# combine the tables through a relational database join
names(data$FactSectionAnimals) # list variables
# use a sequential join to combine the tables, starting with the fact table and then joining the dimension tables
# and mutate,filter the data
alldata<- data$FactSectionAnimals |>
  left_join(data$DimSpecies, by = "SpCode2") |>
  left_join(data$DimSection, by = "Section_ID") |>
  left_join(data$DimTransect, by = "Transect_ID") |>
  dplyr::mutate(SectionCount=CountLeft+CountRight,  
                FirstDate=as.Date(FirstDate)) |>  # convert date column to date format
  dplyr::select(-Date) # remove the original date column if not needed anymore
names(combidata)

#--------------------------03 analyse the data----
alldata |> 
  group_by(Name_eng) |> 
  summarise(TotalCount = sum(SectionCount, na.rm = TRUE)) |> 
  arrange(desc(TotalCount))

