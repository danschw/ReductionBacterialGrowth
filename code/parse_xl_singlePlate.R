# Parse plate data from Excel

# Synergy H1 with software version 3.03.14
# the plate data is at B26:N34


read_synergy_plate <- function(xl_path){
  library(tidyverse)
  library(readxl)
  
  sheets <- excel_sheets(xl_path)
  
  #make tibble for data
  d <- tibble()
  
  for (i in sheets){
    
    #read in data
    dxl <- read_excel(xl_path, sheet = i, range = "B26:N34")%>%
      rename("row"="...1")%>%
      # tansform to long format
      pivot_longer(-row, names_to="col", values_to=i)
    #join to rest of data
    if (i==sheets[1]){
      d <- dxl
    } else{
      d <- full_join(d,dxl)
    }     
  }
  return(d)
}
  
  
 