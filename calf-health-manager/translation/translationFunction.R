tr <- function(text, input = input){ # translates text into current language
  if (is.null(input$language)) {return("no Language provided")}
  sapply(text,function(s) translation[[s]][[input$language]], USE.NAMES = FALSE)
}