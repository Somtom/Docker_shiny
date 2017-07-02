data <- list(calves = data.frame(nr = c(1:30),
                                 eartags = paste0("DE03487700",
                                                  (62 + 1:30))),
             diseases = c("disease 1", "disease 2", "disease 3"),
             recepiesElectrolyt = c("Elektrolyt 1", "Elektrolyt 2"),
             recepiesMedicine = c("Medicine 1", "Medicine 2"))


treatmentTable <- 
  data.frame(
    Datum = as.Date(c("2017-06-20", "2017-06-25", "2017-06-30")),
    Art = c("Befund mit Medikament", "Befund ohne Medikament", "Impfung"),
    Kalb = c(2,10,4),
    Ohrmarke = c("DE0348770063", "DE0348770072", "DE0348770068"),
    Diagnose = c("disease 1", "disease 2", NA),
    Temp. = c(40.3, 38.9, NA),
    Medikament = c("Medikament 1", NA, "Impfstoff 1"),
    Nächste.Beh. = c(NA, NA, 14),
    Wartezeit = c(10, NA, NA),
    AuA.Nr = c(12345, NA, NA),
    Maßnahmen = c("Elektrolyt Rezept 1, Medizinrezept 2", NA, "Erinnerung"),
    Benutzer = c("Martin", "Martin", "Johanna"),
    Notizen = c(NA, "nur leichter Durchfall", NA)
  )