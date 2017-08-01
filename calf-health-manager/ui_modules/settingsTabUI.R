# This script defines the Settings Tab in the body of Calf Health Manager Dashboard

settingsTabUI <- function(input, output, session, rv, tr) {
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
                checkboxGroupInput(inputId = "checkHistoryTableTreatment",
                                   label = "",
                                   choices = subset(names(rv$treatmentTable),
                                                    !(names(rv$treatmentTable) %in% 
                                                        c("date",
                                                          "type",
                                                          "feeder",
                                                          "calf",
                                                          "eartag",
                                                          "diagnosis",
                                                          "findings",
                                                          "X_id.1",
                                                          "calf.feeder",
                                                          "users"))),
                                   selected = subset(names(rv$treatmentTable),
                                                     !(names(rv$treatmentTable) %in% 
                                                         c("date",
                                                           "type",
                                                           "feeder",
                                                           "calf",
                                                           "eartag",
                                                           "diagnosis",
                                                           "findings",
                                                           "X_id.1",
                                                           "calf.feeder",
                                                           "users")))
                )
                ),
              tabPanel(title = "Impfungen",
                       checkboxGroupInput(inputId = "checkHistoryTableVaccination",
                                          label = "",
                                          choices = subset(names(rv$vaccinationTable),
                                                           !(names(rv$vaccinationTable) %in% 
                                                               c("date",
                                                                 "type",
                                                                 "feeder",
                                                                 "calf",
                                                                 "eartag",
                                                                 "purpose",
                                                                 "X_id.1",
                                                                 "calf.feeder",
                                                                 "users"))),
                                          selected = subset(names(rv$vaccinationTable),
                                                            !(names(rv$vaccinationTable) %in% 
                                                                c("date",
                                                                  "type",
                                                                  "feeder",
                                                                  "calf",
                                                                  "eartag",
                                                                  "purpose",
                                                                  "X_id.1",
                                                                  "calf.feeder",
                                                                  "users"))))
              ))
          ),
          
          fluidRow()
  )
}