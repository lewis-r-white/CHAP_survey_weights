calculate_region_pct_LPG <- function(survey_design, regions, region_coefs) {
  pct_LPG_list <- numeric(length(regions))
  
  for (i in seq_along(regions)) {
    region_subset <- subset(survey_design, region == regions[i])
    region_fuel <- as.data.frame(svytotal(~collapsed_fuel, design = region_subset, na.rm = TRUE))
    region_lpg <- region_fuel[2,1]
    region_pop <- region_coefs[i]
    pct_LPG_list[i] <- round((region_lpg / region_pop) * 100, 1)
  }
  
  return(pct_LPG_list)
}
