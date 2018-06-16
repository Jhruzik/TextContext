#' Logical Check for Presence Context within Text
#'
#' After constructing a search with \code{\link{construct_search}} you can use this function to do a logical test of whether or not the defined context is present within your text.
#' @param text A string value representing the text that is to be searched.
#' @param search The result of a \code{\link{construct_search}} call.
#' @param case_sensitive If TRUE, the function will ignore cases for all entities.
#' @return A logical TRUE/FALSE value. If TRUE, the searched context is present within text, while FALSE indicates the absence of the defined context.
#' @seealso \code{\link{construct_search}} for the construction of the search parameter.
#' @examples
#' text <- "The USA will intervene. A proposal has been submitted to the United Nations"
#' A <- c("USA", "Russia", "China")
#' B <- c("United Nations", "WTO", "NATO")
#' search <- construct_search(A, B, 50)
#' check_context(text, search)
check_context <- function(text, search, case_sensitive = FALSE) {

  if (!is.character(text)) {
    text <- as.character(text)
  }

  if (case_sensitive == FALSE) {
    return(stringr::str_detect(text, stringr::regex(search, ignore_case = TRUE)))
  }else if (case_sensitive == TRUE) {
    return(stringr::str_detect(text, stringr::regex(search, ignore_case = FALSE)))
  }

}
