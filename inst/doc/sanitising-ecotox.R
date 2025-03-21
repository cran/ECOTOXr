## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----echo=FALSE, results='asis'-----------------------------------------------
htmltools::includeHTML("../man/figures/ecotox-workflow.svg")

## ----unit_mishmash------------------------------------------------------------
library(ECOTOXr) |> suppressMessages()
library(dplyr)   |> suppressMessages()

mishmash <-
  c("ppm-d", "ml/2.5 cm eu", "fl oz/10 gal/1k sqft", "kg/100 L",
    "mopm", "ng/kg", "ug", "AI ng/g", "PH", "pm", "uM/cm3", "1e-4 mM",
    "degree", "fs", "mg/TI", "RR", "ug/g org/d", "1e+4 IU/TI", "pg/mg TE",
    "pmol/mg", "1e-9/l", "no >15 cm", "umol/mg pro", "cc/org/wk", "PIg/L",
    "ug/100 ul/org", "ae mg/kg diet/d", "umol/mg/h", "cmol/kg d soil",
    "ug/L diet", "kg/100 kg sd", "1e+6 cells", "ul diet", "S", "mmol/h/g TI",
    "g/70 d", "vg", "ng/200 mg diet", "uS/cm2", "AI ml/ha", "AI pt/acre",
    "mg P/h/g TI", "no/m", "kg/ton sd", "ug/g wet wt", "AI mg/2 L diet",
    "nmol/TI", "umol/g wet wt", "PSU", "Wijs number")

## ----as_unit------------------------------------------------------------------
as_unit_ecotox(mishmash, warn = FALSE)

## ----unit_process-------------------------------------------------------------
tibble(mishmash_unit = mishmash) |>
  process_ecotox_units(.names = "{.col}_parsed", warn = FALSE)

## ----unit_annotation----------------------------------------------------------
as_unit_ecotox(c("mg/L CO3", "mg/L CaCO3", "mg/L HCO3"))

## ----as_numeric---------------------------------------------------------------
## Text fields as possibly encountered in the database
text_records <-
  c("10", " 2", "3 ", "~5", "9.2*", "2,33",
    "2,333", "2.1(1.0 - 3.2)", "1-5", "1e-3")
  
as_numeric_ecotox(text_records)

## ----process_numerics---------------------------------------------------------
text_tbl <- tibble(conc1_mean = text_records)

process_ecotox_numerics(text_tbl, warn = FALSE)

## ----process_numerics_rename--------------------------------------------------
process_ecotox_numerics(text_tbl, warn = FALSE, .names = "{.col}_num") |>
  mutate(
    test = is.na(as.numeric(conc1_mean)) &
      !is.na(as_numeric_ecotox(conc1_mean, warn = FALSE))
    )

## ----numerics_and_units-------------------------------------------------------
tibble(
  conc1_mean = c("1", "2", "5e-4", "0.2"),
  conc1_unit = c("mg/L", "M", "% w/v", "ppt w/v")
) |>
  process_ecotox_numerics(add_units = TRUE) |>
  mutate(
    conc1_mean_standard = mixed_to_single_unit(conc1_mean, "ug/L")
  )

## ----as_date_ecotox-----------------------------------------------------------
char_date <- c("5-19-1987   ", "5/dd/2021", "3/19/yyyy", "1985", "mm/19/1999",
               "October 2004", "nr/nr/2015")

as_date_ecotox(char_date)

## ----process_ecotox_dates-----------------------------------------------------
tibble(
  my_date = char_date
) |>
  process_ecotox_dates()

