context("Searches")

search_a <- TextContext::construct_search(c("WordA", "WordB"), c("WordC", "WordD"), 50)
search_b <- TextContext::construct_search(c("Cat", "Dog"), c("House", "Flat"), 250, "chars")
search_c <- TextContext::construct_search(c("USA", "Russia"), c("Military", "Soldiers"), 250, "chars", direction = "right")

test_that("Context check works", {
  expect_true(TextContext::check_context("This is an example where WordA is near to WordC", search_a))
  expect_false(TextContext::check_context("This is an example where WordAmessedup is near to WordC", search_a))
  expect_false(TextContext::check_context("This is an example where WordA is very very very very
                                          very very very very very very very very very very very very
                                          very very very very very very very very very very very very
                                          very very very very very very very very very very very very
                                          very very very very very very very very very very very very
                                          very very very very very very very very very very very very
                                          very very very very very very very very very very very very
                                          very very very very very very very very very very very very
                                          very very very very very very very very very very very very
                                          very very very very very very very very very very very very
                                          far away from WordC", search_a))
  expect_true(TextContext::check_context("the dog and cat are in the house", search_b))
  expect_false(TextContext::check_context("the dog and cat are in the house", search_b, case_sensitive = TRUE))
  expect_true(TextContext::check_context("Russia will increase its spending on Military.", search_c))
  expect_false(TextContext::check_context("The soldiers of the USA are brave", search_c))
})


test_that("Simple Context Extraction works", {
  expect_equal(TextContext::show_context("Here you will find an example text! This is WordA and here comes WordD. Some more text?",
                                         search_a),
               "This is WordA and here comes WordD.")

  expect_equal(TextContext::show_context("WordA is here and here comes WordD. Some more text?",
                                         search_a),
               "WordA is here and here comes WordD.")

  expect_equal(TextContext::show_context("Some text! This is some example Text with WordA and WordD.", search_a),
               "This is some example Text with WordA and WordD.")

  expect_equal(TextContext::show_context("WordA and WordD!", search_a),
               "WordA and WordD!")

})

test_that("Complex Context Extraction works", {
  A <- c("USA", "China", "Russia")
  B <- c("United Nations", "NATO", "WTO")
  final_search <- construct_search(A, B, 40, length_metric = "words", direction = "bi")
  text <- "This is just an example. The USA are going to intervene. A motion has been proposed to the United Nations. This should help. However, there are also other players. Russia might veto it. They have been an active player within the United Nations as well. This is just some more example stuff. Here I would also like to talk about China. China is more interested in trade stuff so they will talk about WTO."
  expect_equal(TextContext::show_context_all(text, final_search),
               list(c("The USA are going to intervene. A motion has been proposed to the United Nations.",
                    "Russia might veto it. They have been an active player within the United Nations as well.",
                    "Here I would also like to talk about China. China is more interested in trade stuff so they will talk about WTO.")))
})
