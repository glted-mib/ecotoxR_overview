
library(tidyverse)
library(ggplot2)
library(ECOTOXr)

who_is_running<-'eap'
#who_is_running<-'stp'
if(Sys.info()[4]=="LZ2626UTPURUCKE"){
  root_dir <- file.path("c:", "git", "eco_ssds_pfas")
}else if(Sys.info()[4]=="LZ26TPURUCKE-2"){
  root_dir <- file.path("c:", "Users", "tpurucke", "git", "eco_ssds_pfas")
}else if(Sys.info()[4]=="LZ26EPAULUKO-2"){
  root_dir <- 'C:/Users/epauluko/OneDrive - Environmental Protection Agency (EPA)/Profile/Documents/GitHub/eco_ssds_pfas'
}else{
  root_dir <- file.path("/work", "HONEYBEE", who_is_running, "pollinator_probabilistic_loading")
}
print(root_dir)


#get latest developer version
#devtools::install_github('pepijn-devries/ECOTOXr')

### SQL database search  ; more comprehensive, but exact wording for the search functions can be challenging to discern

#download ASCII file version of ecotox library; note this may take a while. 
#download_ecotox_data()

list_ecotox_fields()
list_ecotox_fields("all")

#if you know the exact chemical and some of the species terms you want, you can use something like this:
search <-
  list(
    latin_name    = list(
      terms          = c("Skeletonema", "Daphnia"),
      method         = "contains"
    ),
    chemical_name = list(
      terms          = "benzene",
      method         = "exact"
    )
  )

## rows in the output result each represent a unique test id from the database
result <- search_ecotox(search)



#if you have multiple chemicals, you can stick it in a function:
listnames<-c(75898,  76051,  76131,  76142,  98088, 151677)

ecotoxsrch<-function(x){
  search <-
    list(
      cas_number = list(
        terms = x,
        method = "contains"
      )
    )
  
  result <- search_ecotox(search)
  result
  print(x)
}

output<-lapply(listnames,ecotoxsrch)

### websearch; limited to 10,00 records and limited set of search terms; I would only recommend this for a subset of chemicals and a more specific search query. 
list_ecotox_web_fields()

search_fields <-
  list_ecotox_web_fields(
    txAdvancedChemicalEntries = "benzene",
    RBCHEMSEARCHTYPE = "CONTAINS")

search_results <- websearch_ecotox(search_fields, habitat='aquire') #this specifys that the type should aquatic



#### CompTox dashboard:

#if you have CASRN data already in a list, read it in and convert it to a 
# casrn<-read.csv(paste0(root_dir,"/data_in/cas.csv")) #endpoint data
# list<-as.character(unique(casrn$x))


test<-websearch_comptox(list, inputType = "IDENTIFIER", downloadItems = c("DTXCID", "CASRN", "INCHIKEY", "IUPAC_NAME", "SMILES",
                                                                          "INCHI_STRING", "MS_READY_SMILES", "QSAR_READY_SMILES", "MOLECULAR_FORMULA",
                                                                          "AVERAGE_MASS", "MONOISOTOPIC_MASS", "QC_LEVEL", "SAFETY_DATA", "EXPOCAST",
                                                                          "DATA_SOURCES", "TOXVAL_DATA", "NUMBER_OF_PUBMED_ARTICLES", "PUBCHEM_DATA_SOURCES",
                                                                          "CPDAT_COUNT", "IRIS_LINK", "PPRTV_LINK", "WIKIPEDIA_ARTICLE", "QC_NOTES",
                                                                          "ABSTRACT_SHIFTER", "TOXPRINT_FINGERPRINT", "ACTOR_REPORT", "SYNONYM_IDENTIFIER",
                                                                          "RELATED_RELATIONSHIP", "ASSOCIATED_TOXCAST_ASSAYS", 
                                                                          "TOXVAL_DETAILS",
                                                                          "CHEMICAL_PROPERTIES_DETAILS", "BIOCONCENTRATION_FACTOR_TEST_PRED",
                                                                          "BOILING_POINT_DEGC_TEST_PRED", "48HR_DAPHNIA_LC50_MOL/L_TEST_PRED",
                                                                          "DENSITY_G/CM^3_TEST_PRED", "DEVTOX_TEST_PRED",
                                                                          "96HR_FATHEAD_MINNOW_MOL/L_TEST_PRED", "FLASH_POINT_DEGC_TEST_PRED",
                                                                          "MELTING_POINT_DEGC_TEST_PRED", "AMES_MUTAGENICITY_TEST_PRED",
                                                                          "ORAL_RAT_LD50_MOL/KG_TEST_PRED", "SURFACE_TENSION_DYN/CM_TEST_PRED",
                                                                          "THERMAL_CONDUCTIVITY_MW/(M*K)_TEST_PRED",
                                                                          "TETRAHYMENA_PYRIFORMIS_IGC50_MOL/L_TEST_PRED", "VISCOSITY_CP_CP_TEST_PRED", 
                                                                          
                                                                          "VAPOR_PRESSURE_MMHG_TEST_PRED", "WATER_SOLUBILITY_MOL/L_TEST_PRED",
                                                                          "ATMOSPHERIC_HYDROXYLATION_RATE_(AOH)_CM3/MOLECULE*SEC_OPERA_PRED",
                                                                          "BIOCONCENTRATION_FACTOR_OPERA_PRED",
                                                                          "BIODEGRADATION_HALF_LIFE_DAYS_DAYS_OPERA_PRED", "BOILING_POINT_DEGC_OPERA_PRED",
                                                                          "HENRYS_LAW_ATM-M3/MOLE_OPERA_PRED", "OPERA_KM_DAYS_OPERA_PRED",
                                                                          "OCTANOL_AIR_PARTITION_COEFF_LOGKOA_OPERA_PRED",
                                                                          "SOIL_ADSORPTION_COEFFICIENT_KOC_L/KG_OPERA_PRED",
                                                                          "OCTANOL_WATER_PARTITION_LOGP_OPERA_PRED", "MELTING_POINT_DEGC_OPERA_PRED", 
                                                                          
                                                                          "OPERA_PKAA_OPERA_PRED", "OPERA_PKAB_OPERA_PRED", "VAPOR_PRESSURE_MMHG_OPERA_PRED",
                                                                          "WATER_SOLUBILITY_MOL/L_OPERA_PRED",
                                                                          "EXPOCAST_MEDIAN_EXPOSURE_PREDICTION_MG/KG-BW/DAY", "NHANES",
                                                                          "TOXCAST_NUMBER_OF_ASSAYS/TOTAL", "TOXCAST_PERCENT_ACTIVE"))

cheminfo<-test[[2]]

