newTreatment <-
  data.frame(date = as.Date(Sys.time()),
             type = "Befund",
             calf = NA,
             eartag = NA,
             diagnosis  = NA,
             temperature = NA,
             drug = NA,
             nextTreatment = NA,
             waitingTime = NA,
             AuANr = NA,
             actions = NA,
             user = NA,
             notes = input$notes)
