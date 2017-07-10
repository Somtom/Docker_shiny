# This script defines the Settings Tab in the body of Calf Health Manager Dashboard

settingsTabUI <- 
  tabItem(tabName = "settings",
          # Treatment
          box(title = "Eingabefelder Befund",
              status = "primary",
              solidHeader = TRUE,
              "Personalisiere angezeigten Eingabefelder",
              checkboxInput(inputId = "checkUserTreatment",
                            label = "Benutzer",
                            value = TRUE),
              checkboxInput(inputId = "checkAuA",
                            label = "AuA-Nr",
                            value = TRUE)
          ),
          # Vaccination
          box(title = "Eingabefelder Impfung",
              status = "primary",
              solidHeader = TRUE,
              "Personalisiere angezeigten Eingabefelder",
              checkboxInput(inputId = "checkUserVaccination",
                            label = "Benutzer",
                            value = TRUE)
          ),
          #History
          box(title = "History Tabelle",
              status = "primary",
              solidHeader = TRUE,
              "Waehle spalten der History Tabelle",
              checkboxGroupInput(inputId = "checkHistoryTable",
                                 label = "",
                                 choices = subset(names(treatmentTable),
                                                  !(names(treatmentTable) %in% 
                                                    c("date",
                                                      "type",
                                                      "calf",
                                                      "eartag",
                                                      "diagnosis"))),
                                 selected = subset(names(treatmentTable),
                                                   !(names(treatmentTable) %in% 
                                                       c("date",
                                                         "type",
                                                         "calf",
                                                         "eartag",
                                                         "diagnosis")))
                                 )
              )
  )