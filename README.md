# TextContext

This package makes looking for the presence of entity A (e.g. a topic) in the context of entity B easy.

### Prerequisites

This package was built using R version 3.4.4. and depends on the package *stringr*. You can install it in R by typing the following code into your console: `install.packages("stringr")`

### Installing

Since this package is not yet released on CRAN, I recommend installing it via the binaries under the releases tag. They have been built and tested on a Linux machine. A Windows binary is also provided but it has not been tested yet.

If you are using R Studio, just download either the binary, open R Studio, click on Tools->Install Packages, choose to install from Package Archive File and browse to the binary.

### How to use it

The package comes with four basic functions: **construct_search**, **check_context**, **show_context**, and **show_context_all**. **construct_search** should always be your first function call since it produces the regular expression necessary to look for more complex context within you texts.

**construct_search** takes three mandatory inputs and two optional ones. First you need to define your two entities. An entity is a set of words that define a topic or theme you are looking for. For example, c("USA", "China", "Russia") is a vector with three country names and they might stand for important international players. Next, we define the second entity which should be near the first one. For example, *entityA* may be equal to the mentioned vector while *entityB* could be equal to c("United Nations", "NATO", "WTO"). If we use those two vectors as input for entityA and entityB, we might be interested to check whether one of those countries is mentioned in context with important international organizations. Of course, we need to define how far away those two entities are allowed to be. This is where we need to come up with a numeric value for *fill* which is dependent on the optional input *length_metric*. The default for *length_metric* is words. So if you input 40 for *fill* and leave *lenth_metric* to its default value, it will allow a gap of 40 or less words between those two entities. You could also change *length_metric* to "chars" which would allow a gap of 40 or less characters (white spaces included). The last (optional) input is *direction*. Here you can define whether it should check for entityA followed by entityB or vice versa. You could also specify "right" so that it would only check for entityA followed by entityB. Of course, "left" would imply to look for entityB followed by entityA.
The result of the function call will be a simple character string representing a regular expression. Here is a simple example:

```
A <- c("USA", "China", "Russia")
B <- c("United Nations", "NATO", "WTO")
final_search <- construct_search(A, B, 40, length_metric = "words", direction = "bi")
```
final_search will hold a regular expression which can be used in the following function as input.

**check_context** takes two mandatory and one optional input. It needs *text* and *search*. *text* represents the text you would like to check, while *search* is the output of **construct_search**. The default value for *case_sensitive* is FALSE which will match both upper and lower case versions of the words that make up your entities. The result will be a TRUE/FALSE value. If TRUE, the defined context was found within text. If FALSE, the defined context could not be found within text. Here is an example that builds upon the constructed search from the last example:

```
text <- "Due to a humanitarian crisis in Fantasia, many people are in need. The USA has promissed to help. A proposal has been submitted to the United Nations. This will surely send a strong signal to the international community."

check_context(text, final_search)

#Returns TRUE
```

If you are interested in a short snippet of what the actual context within text is, you can use the **show_context** function which takes the same input as **check_context**. However, it will return a short text excerpt from *text*. It will include the sentence of where the first entity is mentioned up until the first sentence where the second entity is mentioned. If you would like to have all the relevant text snippets for a single text, you can use **show_context_all** which will return a list.

### Potential Use Cases

This package was written to support your every day text mining needs. Its **check_context** function might be used for filtering out irrelevant articles or for the creation of new variables. Most importantly, it introduces a near operator to your text search.

### License

All of the source code can be used for any private or commercial purpose. Note that this code is still in an early development status and has not yet been submitted to CRAN. Hence, any publication of this code without approval is prohibited.

### Future Development

If you have an opinion about the code and would like to point out potential errors or flaws, I am more than excited to hear about it. If you are also interested in working on this package, I'll be glad to add you to this repository.
