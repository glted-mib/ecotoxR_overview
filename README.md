# ecotoxR_overview
ECOTOXr allows users to directly import records from both the USEPA ECOTOX database and the CompTox database into an R script, bypassing the need to download records online. There are several ways users can do this. To connect to ECOTOX, users can either use a search function that links to an SQLite database from zip archived tables downloaded from the EPA website, or an experimental web search function that links you to the ecotox database online. This latter function is imperfect, and as stated in the cran document, it may not work for some inputs. 


I recommend getting the latest developer version: devtools::install_github('pepijn-devries/ECOTOXr')

To use the more maintained SQL-based search function, you’ll first need to download the associated ASCII file; this will allow you to use the standard ‘search’ function which has more flexibility in the search commands: download_ecotox_data()

More detailed information can be found here, but the examples are not perfect for large groups of chemicals, and some of the functions are somewhat outdated: https://cran.r-project.org/web/packages/ECOTOXr/readme/README.html

The script 'ecotoxR.r' contains examples for all basic search functions, both the SQL-based and web-based search function for ecotox, and the web-based search function for comptox. 


