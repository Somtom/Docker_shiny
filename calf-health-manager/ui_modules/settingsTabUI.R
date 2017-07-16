# This script defines the Settings Tab in the body of Calf Health Manager Dashboard

settingsTabUI <- 
  tabItem(tabName = "settings",
          # Treatment
          box(title = "Eingabefelder Befund",
              status = "primary",
              solidHeader = TRUE,
              "Personalisiere angezeigten Eingabefelder",
              checkboxInput(inputId = "checkUserTreatment",
                            label = "Beobachter",
                            value = TRUE),
              checkboxInput(inputId = "checkAuA",
                            label = "AuA-Nr",
                            value = TRUE)
          ),
          # Vaccination
          box(title = "Eingabefelder Impfung",
              status = "primary",
              solidHeader = TRUE,
              "Personalisiere angezeigten Eingabefelder"
          ),
          #History
          box(title = "History Tabelle",
              status = "primary",
              solidHeader = TRUE,
              tabBox(width = 12,
              tabPanel(title = "Befunde/Behandlungen",
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
                ),
              tabPanel(title = "Impfungen")
              ))
  )