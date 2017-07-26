# This script defines the Treatment Tab in the body of Calf Health Manager Dashboard

groupTreatmentTabUI <- function(input, output, session, rv) {
  tabItem(tabName = "groupTreatment",
          shinyjs::hidden(div(id = "dynamicGroupTreatmentUI",box(id = "boxGroupTreatment",
              width = 12,
              title = "Gruppenbehandlung",
              status = "danger",
              solidHeader = TRUE,
              fluidRow(
                column(4,
                       dateInput(inputId = "dateGroupTreatment",
                                 label = "Datum",
                                 value = as.Date(Sys.time()),
                                 max = as.Date(Sys.time()))
                ),
                column(4,
                       # selectInput(inputId = "purposeGroupTreatment",
                       #             label = "Grund der Behandlung",
                       #             choices = c("",rv$data$diseases))
                       selectizeInput(inputId = "purposeGroupTreatment",
                                      label = "Grund der Behandlung",
                                      multiple = FALSE,
                                      choices = c("",rv$data$diseases),
                                      options = list(create = TRUE,
                                                     plugins = list("remove_button")))
                ),
                column(4,
                       textInput(inputId = "notesGroupTreatment", 
                                 label = "Notizen")
                )
              ),
              hr(),
              h4(strong("Informationen zur Medikamentengabe")),
              br(),
              fluidRow(
                column(4,
                       # selectInput(inputId = "drugGroupTreatment",
                       #             label = "Medikament",
                       #             choices = c("",rv$data$drugs))
                       selectizeInput(inputId = "drugGroupTreatment",
                                      label = "Medikament",
                                      multiple = FALSE,
                                      choices = c("",rv$data$drugs),
                                      options = list(create = TRUE,
                                                     plugins = list("remove_button")))
                ),
                column(4,
                       numericInput(inputId = "dosisGroupTreatment",
                                    label = "Anwendungsmenge [ml/Tier]",
                                    value = NA)
                ),
                column(4,
                       conditionalPanel(
                         condition = "input.checkAuA == true",
                         numericInput(inputId = "AuANrGroupTreatment",
                                      label = "AuA-Beleg Nr.",
                                      value = NA)
                       )
                )
              ),
              fluidRow(
                column(4,
                       numericInput(inputId = "waitingTimeGroupTreatment", 
                                    label = "Wartezeit",
                                    value = NA)
                )
              ),
              hr(),
              h4(strong("Massnahmen")),
              fluidRow(
                column(4,
                       checkboxInput(
                         inputId = "checkReminderGroupTreatment",
                         label = "Erinnerung",
                         value = FALSE
                       ),
                       conditionalPanel(condition = "input.checkReminderGroupTreatment == true",
                                        numericInput(inputId = "nextGroupTreatment", 
                                                     label = "Naechste Beh.",
                                                     value = NA,
                                                     min = 1)
                       )
                ),
                column(4,
                       checkboxInput(
                         inputId = "checkGiveElectrolytGroup",
                         label = "Elektrolytrezept",
                         value = FALSE
                       ),
                       conditionalPanel(condition = "input.checkGiveElectrolytGroup == true",
                                        selectInput(inputId = "electrolytRecipieGroup",
                                                    label = "Rezept",
                                                    choices = rv$data$recepiesElectrolyt))
                ),
                column(4,
                       checkboxInput(
                         inputId = "checkGiveMedicineGroup",
                         label = "Medizinrezept",
                         value = FALSE
                       ),
                       conditionalPanel(
                         condition = "input.checkGiveMedicineGroup == true",
                         selectInput(inputId = "medicineRecipieGroup",
                                     label = "Rezept",
                                     choices = rv$data$recepiesMedicine))
                ) 
              ),
              fluidRow(
                column(12, 
                       span(textOutput("inputCheckerGroupTreatment"), style = "color:#ff3300"),
                       tags$head(tags$style("#inputCheckerGroupTreatment{color: red;}"))
                )
              ),
              fluidRow(
                column(12, align = "right", 
                       br(),
                       br(),actionButton(inputId = "button_backToCalfListGroupTreatment",
                                         label = "Zurueck zu Tierliste"),
                       tags$head(tags$style(
                         "#button_backToCalfListGroupTreatment{background-color: #EFEFEF; border-color: #A3A3A3}")),
                       
                       actionButton(inputId = "button_ConfirmGroupTreatment", label = "Fertig",
                                    styleclass = "danger"),
                       br()
                )
              ),
              
              # emergency warning if someone got to vaccination tab without filtering
              div(id = "selectCalvesInfoGroupTreatment", box(
                title = "Hinweis",
                width = 12,            
                status = "info",
                solidHeader = TRUE,
                fluidRow(column(12, align = "center",h3("Bitte zuerst Tiere in Liste filtern")))
              ))),
              fluidRow(shinysky::busyIndicator("saving Treatments")))))
}