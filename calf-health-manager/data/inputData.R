set.seed(12)

data <- list(calves = data.frame(nr = c(1:30),
                                 eartag = paste0("DE03487700",
                                                  (62 + 1:30)),
                                 feeder = as.character(c(rep(121,20), rep(56,10))),
                                 feedingDay = c(round(rnorm(30,15,5)))),
             findings = c("high temperature", "high breathing frequency", "abnormal feces"),
             diseases = c("", "disease 1", "disease 2", "disease 3"),
             drugs = c("drug 1", "drug 2", "drug 3"),
             vaccinationPurpose = c("BHV1", "BVD", "BTV", "MKS"),
             vaccines = c("vaccine 1", "vaccine 2", "vaccine 3"),
             recepiesElectrolyt = c("Elektrolyt 1", "Elektrolyt 2"),
             recepiesMedicine = c("Medicine 1", "Medicine 2"))


treatmentTable <- 
  data.frame(
    date = as.Date(c("2017-06-20", "2017-06-25", "2017-06-30")),
    type = c("demoBefund", "demoBefund", "demoBefund"),
    feeder = as.character(c(121,56,121)),
    calf = c(2,10,4),
    eartag = c("DE0348770063", "DE0348770072", "DE0348770068"),
    findings = c("high temperature", "abnormal fece", "high breathing frequency"),
    diagnosis = c("disease 1", "disease 2", NA),
    temperature = c(40.3, 38.9, NA),
    drug = c("Medikament 1", NA, NA),
    nextTreatment = c(2, NA, NA),
    waitingTime = c(10, NA, NA),
    AuANr = c(12345, NA, NA),
    actions = c("Electrolyt 1, Medicine 2", NA, NA),
    user = c("Martin", "Martin", "Johanna"),
    notes = c(NA, "nur leichter Durchfall", NA)
  )

vaccinationTable <- 
  data.frame(
  calf = c(1,2,3),
  eartag = c("DE0348770063", "DE0348770072", "DE0348770068"),
  feeder = as.character(c(121,56,121)),
  feedingDay = c(10, 8, 2),
  date = as.Date(c("2017-06-20", "2017-06-20", "2017-06-20")),
  type = rep("demoImpfung",3),
  purpose = rep("BHV", 3),
  batchNr = rep(123, 3),
  veterinary = rep("Dr.Huber", 3),
  notesVaccination = rep("", 3),
  actions = rep("Erinnerung", 3)
)