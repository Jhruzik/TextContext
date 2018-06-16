#' Return a list that shows every context element found.
#'
#' This function can be used to extract all text excerpts from a text, based on a context search constructed with \code{\link{check_context}}. It will show the entire sentence from the first occurance of the first relevant entity to the first sentence of the second entity.
#' @param text A string value representing the text that is to be searched.
#' @param search The result of a \code{\link{construct_search}} call.
#' @param case_sensitive If TRUE, the function will ignore cases for all entities.
#' @return The function will return a list of sub-strings of text which shows you where the contexts were found.
#' @seealso \code{\link{construct_search}} for the construction of the search parameter.
show_context_all <- function(text, search, case_sensitive = FALSE) {

  #get the raw and minimalistic contexts within text
  if (case_sensitive == FALSE){

    first_results <- stringr::str_trim(stringr::str_extract_all(text, stringr::regex(search, ignore_case = TRUE))[[1]])

  } else {

    first_results <- stringr::str_trim(stringr::str_extract_all(text, search)[[1]])

  }

  first_results <- stringr::str_replace(first_results, "[.:?!]*$", "")#Trim punctuation characters at the end
  first_results <- stringr::str_replace_all(first_results, "([.|()\\^{}+$*?]|\\[|\\])", "\\\\\\1")#Escape all meta characters

  #Define a function to extract a text snippet for every result in first_results
  get_excerpt_local <- function(result) {
    return(TextContext::show_context(text, result))
  }

  #Get excerpt for every result
  result <- list(unlist(lapply(first_results, get_excerpt_local)))

  return(result)
}
