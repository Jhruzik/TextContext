#' Return a Snippet that Shows the Context found.
#'
#' This function can be used to extract a small text excerpt from a text based on a context search constructed with \code{\link{check_context}}. It will show the entire sentence from the first occurance of the first relevant entity to the first sentence of the second entity.
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
show_context <- function(text, search, case_sensitive = FALSE) {

  #get the raw and minimalistic context within text
  if (case_sensitive == FALSE){

    first_result <- stringr::str_trim(stringr::str_extract(text, stringr::regex(search, ignore_case = TRUE)))

  } else {

    first_result <- stringr::str_trim(stringr::str_extract(text, search))

  }

  first_result <- stringr::str_replace(first_result, "[.:?!]*$", "")#Trim punctuation characters at the end
  first_result <- stringr::str_replace_all(first_result, "([.|()\\^{}+$*?]|\\[|\\])", "\\\\\\1")#Escape all meta characters

  #Construct regular expression for sentence extraction
  if (!grepl(paste0("^", first_result), text)) {

    expanded_search <- paste0("((?<=[:.?!])|^)[^:.?!]*?", first_result, ".*?[.:?!]")

  }else {

    expanded_search <- paste0(first_result, ".*?[.:?!]")

  }

  #extract text excerpt
  context_match <- stringr::str_trim(stringr::str_extract(text, expanded_search))
  return(context_match)

}
