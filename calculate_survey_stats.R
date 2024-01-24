calculate_survey_stats <- function (survey_design, raking_option) {
  
  # Calculating the total number of respondents
  total_households <- coef(svytotal(c(rep(1, nrow(full_survey))), survey_design))
  
  # Calculating the number of rural respondents
  urban_rural_counts <- svytotal(~urban_rural_str, design = survey_design, na.rm = TRUE)
  
  rural_count <- coef(urban_rural_counts)["urban_rural_strrural"]
  urban_count <- coef(urban_rural_counts)["urban_rural_strurban"]
  
  # Calculating the percentage of rural respondents
  pct_rural <- (rural_count / total_households) * 100
  
  
  # Get all coefficients
  region_coefs <- coef(svytotal(~region, design = survey_design, na.rm = TRUE))
  
  # Construct the variable name
  region_coefs_var_name <- paste0("region_coefs_", raking_option)
  
  # Assign the coefficients to the dynamically named variable
  assign(region_coefs_var_name, region_coefs, envir = .GlobalEnv)
  
  
  #mean hh members
  hh_size <- coef(svymean(~total_hh_num, design = survey_design, na.rm = TRUE))
  
  #LPG main stove
  LPG_main <- coef(svytotal(~collapsed_fuel, design = survey_design))['collapsed_fuelLPG']
  
  pct_LPG <- LPG_main/total_households * 100
  
  #Charcoal or wood main stove
  CW_main <- coef(svytotal(~collapsed_fuel, design = survey_design))['collapsed_fuelcharcoal'] + coef(svytotal(~collapsed_fuel, design = survey_design))['collapsed_fuelwood']
  
  pct_CW <- CW_main/total_households * 100
  
  
  #URBAN
  #urban subset 
  urban_sub <- subset(survey_design, urban_rural == 1)
  
  #urban hh size
  hh_size_urban <- coef(svymean(~total_hh_num, design = urban_sub, na.rm = TRUE))
  
  #urban LPG primary stove 
  LPG_main_urban <- coef(svytotal(~collapsed_fuel, design = urban_sub, na.rm = TRUE))['collapsed_fuelLPG']
  
  pct_LPG_urban <- LPG_main_urban/urban_count * 100
  
  
  #RURAL
  #rural subset
  rural_sub <- subset(survey_design, urban_rural == 2)
  
  # rural hh size 
  hh_size_rural <- coef(svymean(~total_hh_num, design = rural_sub, na.rm = TRUE))
  
  # rural LPG primary stove
  LPG_main_rural <- coef(svytotal(~collapsed_fuel, design = rural_sub, na.rm = TRUE))['collapsed_fuelLPG']
  
  pct_LPG_rural <- LPG_main_rural/rural_count * 100
  
  
  #drinking water
  water_coefs <- coef(svytotal(~hh_water_source, design = survey_design, na.rm = TRUE))
  
  water_borehole <- water_coefs['hh_water_sourceHand pump/Closed borehole']
  pct_borehole <- water_borehole/total_households * 100
  
  water_sachet <- water_coefs['hh_water_sourceSachet/Pure water']
  pct_sachet <- water_sachet/total_households * 100
  
  water_pipe_tap <- water_coefs['hh_water_sourcePiped into home/compound'] + water_coefs['hh_water_sourcePublic tap']
  pct_pipe_tap <- water_pipe_tap/total_households * 100
  
  #check out house rooms
  rooms_two_plus <- coef(svytotal(~rooms_two_plus, design = survey_design))['rooms_two_plusYes']
  pct_rooms_two_plus <- rooms_two_plus/total_households * 100
  
  sleeping_rooms_two_plus <- coef(svytotal(~sleeping_rooms_two_plus, design = survey_design))['sleeping_rooms_two_plusYes']
  pct_sleeping_rooms_two_plus <- sleeping_rooms_two_plus/total_households * 100
  
  separate_cooking <- coef(svytotal(~separate_cooking, design = survey_design))['separate_cookingYes']
  pct_separate_cooking <- separate_cooking/total_households * 100
  
  #check out lighting 
  # Coefficients for light source
  light_source_coefs <- coef(svytotal(~light_source_main, design = survey_design, na.rm = TRUE))
  
  # Extract coefficients for electricity options
  electric_light <- light_source_coefs["light_source_mainElectricity: decentralized/solar"] + light_source_coefs["light_source_mainElectricity: national grid"]
  pct_electric_light <- electric_light/total_households * 100
  
  
  
  
  ## CREATING A DATA FRAME OF RESULTS
  
  variables <- c("total_households", "hh_size", "hh_size_rural", "hh_size_urban", "pct_rural", "pct_LPG", "pct_CW", "pct_LPG_urban", "pct_LPG_rural", "pct_borehole", "pct_sachet", "pct_pipe_tap", "pct_rooms_two_plus", "pct_sleeping_rooms_two_plus", "pct_separate_cooking", "pct_electric_light")
  
  values <- c(total_households, hh_size, hh_size_rural, hh_size_urban, pct_rural, pct_LPG, pct_CW, pct_LPG_urban, pct_LPG_rural, pct_borehole, pct_sachet, pct_pipe_tap, pct_rooms_two_plus, pct_sleeping_rooms_two_plus, pct_separate_cooking, pct_electric_light)
  
  #disable scientific notation for values
  formatted_values <- sapply(values, function(x) format(x, scientific = FALSE, nsmall = 2))
  
  #df with results
  #df <- data.frame(stat = variables, raking_option = formatted_values)
  
  df <- data.frame(stat = variables, setNames(list(formatted_values), raking_option))
  
  return(df)
}
