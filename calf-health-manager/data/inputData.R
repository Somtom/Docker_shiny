data <- list(calves = data.frame(nr = c(1:30),
                                 eartags = paste0("DE03487700",
                                                  (62 + 1:30))),
             diseases = c("disease 1", "disease 2", "disease 3"),
             drugs = c("drug 1", "drug 2", "drug 3"),
             recepiesElectrolyt = c("Elektrolyt 1", "Elektrolyt 2"),
             recepiesMedicine = c("Medicine 1", "Medicine 2"))


treatmentTable <- 
  data.frame(
    date = as.Date(c("2017-06-20", "2017-06-25", "2017-06-30")),
    type = c("Befund mit Medikament", "Befund ohne Medikament", "Impfung"),
    calf = c(2,10,4),
    eartag = c("DE0348770063", "DE0348770072", "DE0348770068"),
    diagnosis = c("disease 1", "disease 2", NA),
    temperature = c(40.3, 38.9, NA),
    drug = c("Medikament 1", NA, "Impfstoff 1"),
    nextTreatment = c(NA, NA, 14),
    waitingTime = c(10, NA, NA),
    AuANr = c(12345, NA, NA),
    actions = c("Elektrolyt Rezept 1, Medizinrezept 2", NA, "Erinnerung"),
    user = c("Martin", "Martin", "Johanna"),
    notes = c(NA, "nur leichter Durchfall", NA)
  )