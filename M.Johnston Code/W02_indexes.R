## ----eval=FALSE--------------------------------------------------------------------------------------------------------
#install.packages("remotes")
#remotes::install_github("pfmc-assessments/nwfscSurvey")

library(dplyr)
library(nwfscSurvey)

## ----plot_cpue, fig.show='hide'----------------------------------------------------------------------------------------
# Pull survey data from NWFSC data warehouse
catchYE <- pull_catch(common_name = "yelloweye rockfish", # all lowercase 
                    survey = "NWFSC.Combo",
                    dir = NULL) # this is the default

catchWI <- pull_catch(common_name = "widow rockfish", # all lowercase 
                      survey = "NWFSC.Combo",
                      dir = NULL) # this is the default

plot_cpue(dir = NULL, catchYE, plot = 1:1)
plot_cpue(dir = NULL, catchWI)

## ----strata, results='hide'--------------------------------------------------------------------------------------------
strata <- CreateStrataDF.fn(
  names = c("shallow_s", "mid_s", "deep_s", "shallow_n", "mid_n", "deep_n"), 
  depths.shallow = c( 55,   200, 300,    55, 200, 300),
  depths.deep    = c(200,   300, 400,   200, 300, 400),
  lats.south     = c( 32,    32,  32,    42,  42,  42),
  lats.north     = c( 42,    42,  42,    49,  49,  49))
strata

## ----index_plot, fig.show='hide'---------------------------------------------------------------------------------------
biomassYE <- get_design_based(data = catchYE,  
                            strata = strata)
biomassWI <- get_design_based(data = catchWI,  
                            strata = strata)

plot_index(data = biomassYE, plot = 1)
plot_index(data = biomassWI, plot = 1)

## ----bio, fig.show='hide'---------------------------------------------------------------------------------------

bioYE <- pull_bio(common_name = "yelloweye rockfish",
                  survey = "NWFSC.Combo")
bioWI <- pull_bio(common_name = "widow rockfish",
                  survey = "NWFSC.Combo")

plot_bio_patterns(
  bio = bioYE, 
  col_name = "Length_cm")
plot_bio_patterns(
  bio = bioWI, 
  col_name = "Length_cm")

length_compsYE <- get_expanded_comps(
  bio_data = bioYE,
  catch_data = catchYE,
  comp_bins = seq(5, 70, 2),
  strata = strata,
  comp_column_name = "length_cm",
  output = "full_expansion_ss3_format",
  two_sex_comps = TRUE,
  input_n_method = "stewart_hamel")

length_compsWI <- get_expanded_comps(
  bio_data = bioWI,
  catch_data = catchWI,
  comp_bins = seq(5, 70, 2),
  strata = strata,
  comp_column_name = "length_cm",
  output = "full_expansion_ss3_format",
  two_sex_comps = TRUE,
  input_n_method = "stewart_hamel")

plot_comps(data = length_compsYE)
plot_comps(data = length_compsWI)
