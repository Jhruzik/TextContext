# TextContext

This package makes looking for the presence of entity A (e.g. a topic) in the context of entity B easy.

### Prerequisites

This package was built using R version 3.4.4. and depends on the package *stringr*. You can install it in R via typing the following code into your console: `install.packages("stringr")`

### Installing

Since this package is not yet released on CRAN, I recommend installing it via the binaries under the releases tag. They have been built and tested on a Linux and Windows machine.

If you are using RStudio, just download either the Linux or Windows binary, open RStudio, click on Tools->Install Packages, choose to install from Package Archive File and browse to the binary.

### How to use it

The package comes with three basic functions: **construct_search**, **check_context**, and **show_context**. **construct_search** should always be your first function call since it produces the regular expressions necessary to look for more complex context within you texts.

**construct_search** takes three mandatory inputs and two optional ones. First you need to define your two entities. An entity is a set of words that define a topic or theme you are looking for. For example, c("USA", "China", "Russia") is a vector with three country names and they might stand for important international players. This way we define two entities that ought to be close together. For example, *entityA* may be equal to the mentioned vector while *entityB* could be equal to c("United Nations", "NATO", "WTO"). If we use those two vectors as input for entityA and entityB, we might be intersted to check whether one of those countries is mentioned in context with important international organizations. Of course, we need to define how far away those two entities are allowed to be. This is where we need to come up with a numeric value for *fill* which is dependent on the optional input *length_metric*. The default for *length_metric* is words. So if you input 40 for *fill* and leave *lenth_metric* to its default value, it will allow a gap of 40 or less words. You could also change *length_metric* to "chars" which would allow a gap of 40 or less characters (white spaces included). The last (optional) input is *direction*. Here you can define wheter it should check for entityA followed by entityB or vice versa. You could also specify "right" so that it would only check for entityA followed by entityB. Of course, "left" would imply to look for entityB followed by entityA.
The result of the function call will be a simple character string representing a regular expression. Here is a simple example:
```
A <- c("USA", "China", "Russia")
B <- c("United Nations", "NATO", "WTO")
final_search <- construct_search(A, B, 40, length_metric = "words", direction = "bi")
```
final_search will hold a regular expression which can be used in the following function as an input.
