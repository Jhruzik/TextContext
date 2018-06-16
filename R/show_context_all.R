#' Return a List that Shows every Context Element found.
#'
#' This function can be used to extract all text excerpts from a text, based on a context search constructed with \code{\link{check_context}}. It will show the entire sentence from the first occurance of the first relevant entity to the first sentence of the second entity.
#' @param text A string value representing the text that is to be searched.
#' @param search The result of a \code{\link{construct_search}} call.
#' @return The function will return a sub-string of text which shows you where the context was found. This is just a snippet and does not necessarily include all of the relevant text. This is especially true if more than one word of the defined entity is present within text.
#' @seealso \code{\link{construct_search}} for the construction of search parameter.
#' @examples
#' text <- "There has been a crisis in Fantasia.
#' The USA will intervene. A proposal has been submitted to the United Nations"
#' A <- c("USA", "Russia", "China")
#' B <- c("United Nations", "WTO", "NATO")
#' search <- construct_search(A, B, 50)
#' check_context(text, search)
show_context_all <- function(text, search, case_sensitive = FALSE) {

  #get the raw and minimalistic context within text
  if (case_sensitive == FALSE){

    first_results <- stringr::str_trim(stringr::str_extract_all(text, stringr::regex(search, ignore_case = TRUE))[[1]])

  } else {

    first_results <- stringr::str_trim(stringr::str_extract_all(text, search)[[1]])

  }

  first_results <- stringr::str_replace(first_results, "[.:?!]*$", "")#Trim punctuation characters at the end

  #Define function to extract text snippet for every result in first_results
  get_excerpt_local <- function(result) {
    return(TextContext::show_context(text, result))
  }

  #Get excerpt for every result
  result <- list(unlist(lapply(first_results, get_excerpt_local)))

  return(result)
}
