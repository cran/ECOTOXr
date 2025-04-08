## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, warning=FALSE, message=FALSE--------------------------------------
library(ECOTOXr)

## ----eval = FALSE-------------------------------------------------------------
# search_ecotox(
#   list(
#     latin_name    = list(terms = "Daphnia magna", method = "exact"),
#     chemical_name = list(terms = "benzene",       method = "exact")
#   )
# )

## ----eval = FALSE, warning = FALSE--------------------------------------------
# search_ecotox(
#   list(
#     result_id = list(terms = "401386", method = "exact")
#   ),
#   as_data_frame = F
# )

## ----eval = FALSE, warning = FALSE--------------------------------------------
# con <- dbConnectEcotox()
# dplyr::tbl(con, "results") |>
#   dplyr::filter(result_id == "401386") |>
#   dplyr::collect()

## ----eval = FALSE, warning = FALSE--------------------------------------------
# dbGetQuery(con, "SELECT * FROM results WHERE result_id='401386'") |>
#   dplyr::as_tibble()

## -----------------------------------------------------------------------------
tryCatch({
  search_fields <-
    list_ecotox_web_fields(
      txAdvancedSpecEntries     = "daphnia magna",
      RBSPECSEARCHTYPE          = "EXACT",
      txAdvancedChemicalEntries = "benzene",
      RBCHEMSEARCHTYPE          = "EXACT")

  search_results <- websearch_ecotox(search_fields, verify_ssl = FALSE)

  search_results$`Aquatic-Export`
})

