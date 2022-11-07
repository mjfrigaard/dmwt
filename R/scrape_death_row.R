#' Scrape Texas Department of Criminal Justice website
#'
#' @return ExecutedOffenders table of executed offenders
#' @export scrape_death_row
#'
#' @examples # not run
#' # ExecutedOffenders <- scrape_death_row()
scrape_death_row <- function() {
  webpage_url <- "http://www.tdcj.state.tx.us/death_row/dr_executed_offenders.html"
  webpage <- xml2::read_html(webpage_url)
  ExOffndrsRaw <- rvest::html_table(webpage)[[1]]
  ExOffndrsTbl <- tibble::as_tibble(x = ExOffndrsRaw, .name_repair = "unique")
  ExOffndrsNms <- janitor::clean_names(dat = ExOffndrsTbl, case = "snake")
  ExecutedOffenders <- purrr::set_names(x = ExOffndrsNms,
                          nm = c("execution", "offender_info", "last_statement",
                                "last_name", "first_name", "tdcj_number",
                                "age", "date", "race", "county"))
  return(ExecutedOffenders)
}
