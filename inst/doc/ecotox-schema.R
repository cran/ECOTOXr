## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----echo=FALSE, results='asis'-----------------------------------------------
htmltools::tags$div(
  htmltools::includeHTML("../man/figures/ecotox-schema.svg"),
  onmousemove = "mousemove_schema();",
  style = "position: relative; width: 100%; height: 400px; overflow: scroll;"
)

## ----eval = FALSE-------------------------------------------------------------
#  library(dplyr)
#  
#  if (check_ecotox_availability()) {
#    con <- dbConnectEcotox()
#  
#    insects <-
#      tbl(con, "species") |>
#      filter(class == "Insecta") |>
#      ## Specify which fields you want from the table.
#      ## Make sure to include the key that links with
#      ## other tables ('species_number')
#      select(species_number, common_name, latin_name)
#  
#  }

## ----eval = FALSE-------------------------------------------------------------
#  if (check_ecotox_availability()) {
#    results <-
#      insects |>
#  
#      ## First join the 'tests' table
#  
#      left_join(
#        tbl(con, "tests") |> select(test_id, species_number),
#        by = "species_number"
#      ) |>
#  
#      ## Then join the 'results' table
#  
#      left_join(
#        tbl(con, "results"),
#        by = "test_id"
#      ) |>
#  
#      ## dplyr performs queries lazily, call
#      ## 'collect' to actually get the results
#  
#      collect()
#  
#    close(con)
#  }

## ----eval = FALSE-------------------------------------------------------------
#  if (check_ecotox_availability()) {
#    con <- dbConnectEcotox()
#  
#    ## pick a random species
#    species <-
#      tbl(con, "species") |>
#      mutate(random = runif(n())) |>
#      slice_min(n = 1, order_by = random) |>
#      select(!random)
#  
#    ## pick a random chemical
#    chem <-
#      tbl(con, "chemicals") |>
#      rename(test_cas = "cas_number") |>
#      mutate(random = runif(n())) |>
#      slice_min(n = 1, order_by = random) |>
#      select(!random)
#  
#    ## join the randomly picked species and test chemical
#    ## with the 'tests' and 'results' table
#    results <-
#      tbl(con, "tests") |>
#      select(test_id, test_cas, species_number) |>
#      right_join(species,
#                 by = "species_number") |>
#      right_join(chem,
#                 by = "test_cas") |>
#      inner_join(tbl(con, "results") |>
#                   select(1:10),
#                 by = "test_id") |>
#      collect()
#  
#    close(con)
#  }

## ----eval = FALSE-------------------------------------------------------------
#  if (check_ecotox_availability()) {
#    con <- dbConnectEcotox()
#  
#    dose_info <-
#      tbl(con, "doses") |>
#      ## Let's select the dose information for the first test in the database
#      filter(test_id == 1) |>
#      left_join(tbl(con, "dose_response_details"), by = "dose_id") |>
#      left_join(tbl(con, "dose_responses"), by = c("dose_resp_id", "test_id")) |>
#      left_join(tbl(con, "dose_response_links"), by = "dose_resp_id") |>
#      left_join(tbl(con, "results"), by = c("result_id", "test_id")) |>
#      collect()
#  
#    close(con)
#  }

## ----eval = FALSE-------------------------------------------------------------
#  ## In this example dose information is automatically nested
#  if (check_ecotox_availability()) {
#    doses <-
#      search_ecotox(
#        list(
#          result_id = list(
#            terms = 1182449,
#            method = "exact")),
#        output_fields = c("results.result_id", "doses.dose_number"))
#  }

## ----tab-dif, echo=FALSE, message=FALSE, warning=FALSE------------------------
library(kableExtra)
library(dplyr)
ECOTOXr:::.db_specs |>
  mutate(
    table = sprintf("<div id='ec_%s'>%s</div>", .data$table, .data$table),
    field_name = ifelse(.data$primary_key != "" | .data$foreign_key != "",
                        sprintf("**%s**", .data$field_name), .data$field_name)
  ) |>
  select(table, fields = "field_name") |>
  kbl(escape = FALSE) |>
  collapse_rows(valign = "top")

