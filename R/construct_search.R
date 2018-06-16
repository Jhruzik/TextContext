#' Construct a Context Search
#'
#' This function is used to construct a string representing a regular expression for later use inside the \code{\link{check_context}} function. The basic idea is that you have two distinct entities (entityA and entityB) which are defined by a set of words. Inside a text, both entities might be seperated by one or more words or characters. The resulting regular expression can be used for further data analysis.
#' @param entityA A string vector containing all the words that make up the first entity.
#' @param entityB A string vector containing all the words that make up the second entity.
#' @param fill_length A numeric value indicating how far away the two entities are allowed to be from each other.
#' @param length_metric Either one of "words" or "chars". If "words", then fill_length represents the number of words. If "chars", fill_length represents the number of characters, including white space characters.
#' @param direction Either "bi", "right", or "left". If "bi" is selected, the search will allow for entityA followed by entityB or vice versa. If "right" is specified, entityA must be followed by entityB, while "left" looks for entityB followed by entityA.
#' @return A string value representing a regular expression.
#' @examples
#' A <- c("USA", "Russia", "China")
#' B <- c("United Nations", "NATO", "WTO")
#' search_w_bi <- construct_search(A, B, 30)
#' search_c_bi <- construct_search(A, B, 200,
#' "chars")
#' search_w_right <- construct_search(A, B, 30,
#' direction = "right")
#' search_c_left <- construct_search(A, B, 200,
#' "chars", direction = "left")
#' @seealso \code{\link{check_context}} for further use of this function.
#' @export
construct_search <- function(entityA, entityB, fill_length, length_metric = "words", direction = "bi") {

  #character conversion for input
  if (!is.character(entityA)) {
    entityA <- as.character(entityA)
  }

  if (!is.character(entityB)) {
    entityB <- as.character(entityB)
  }

  #paste single words into one string
  entityA <- paste0("(", stringr::str_c(entityA, collapse = "|"), ")")
  entityB <- paste0("(", stringr::str_c(entityB, collapse = "|"), ")")


  #create regular expression to fill potential gap between both entities
  if (length_metric == "words") {
    fill <- paste0("(?:\\w+\\W+){0,", fill_length, "}?")
  }else if (length_metric == "chars") {
    fill <- paste0(".{0,", fill_length, "}")
  }

  #create different regex for possible directions
  if (direction == "bi") {
    search <- paste0("((\\W|^)", entityA, "\\W+", fill, entityB, "(\\W|$))|(",
                     "(\\W|^)", entityB, "\\W+", fill, entityA, "(\\W|$))")
  }else if (direction == "right") {
    search <- paste0("(", entityA, fill, entityB, ")")
  }else if (direction == "left") {
    search <- paste0("(", entityB, fill, entityA, ")")
  }

  return(search)
}
