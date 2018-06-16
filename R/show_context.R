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
show_context <- function(text, search) {

  #get the raw and minimalistic context within text
  first_result <- stringr::str_extract(text, search)

  if (!grepl(paste0("^", first_result), text) & !grepl("[.:!?]$", first_result)) {

    expanded_search <- paste0("(?<=[\\.:?!]).*", first_result, ".*?[\\.:?!]")

  }else if (grepl(paste0("^", first_result), text) & !grepl("[.:!?]$", first_result)) {

    expanded_search <- paste0(first_result, ".*?[.:?!]")

  }else if (!grepl(paste0("^", first_result), text) & grepl("[.:!?]$", text)) {

    expanded_search <- paste0("(?<=[.:?!]).*", first_result)

  }


  if (grepl(paste0("^", first_result), text) & grepl("[.:!?]$", text)) {

    context_match <- first_result

  }else {

    context_match <- stringr::str_trim(stringr::str_extract(text, expanded_search))

  }

  return(context_match)

}
