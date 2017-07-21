# This script defines the Vaccination Tab in the body of Calf Health Manager Dashboard

vaccinationTabUI <- function(input, output, session, rv) {
  tabItem(tabName = "vaccination",
          shinyjs::hidden(div(id = "dynamicVaccinationUI",box(
            id = "boxVaccination",
            width = 12,
            title = "Impfung - Tierliste",
            status = "warning",
            solidHeader = TRUE,
            fluidRow(
              column(4,
                     dateInput(inputId = "dateVaccination",
                               label = "Datum",
                               value = as.Date(Sys.time()),
                               max = as.Date(Sys.time()))
              ),
              column(4,
                     selectInput(inputId = "vaccinationPurpose",
                                 label = "Zweck der Impfung",
                                 choices = c("",rv$data$vaccinationPurpose))
              ),
              column(4,
                     textInput(inputId = "notesVaccination",
                               label = "Notizen")
              )
            ),
            fluidRow(
              column(4,
                     selectInput(inputId = "vaccine",
                                 label = "Impfstoff",
                                 choices = c("",rv$data$vaccines))
              ),
              column(4,
                     textInput(inputId = "batchNumberVaccination",
                               label = "Chargennr.")
              ),
              column(4,
                     textInput(inputId = "vetVaccination",
                               label = "Tierarzt")
              )
            ),
            hr(),
            h4(strong("Massnahmen")),
            fluidRow(
              column(4,
                     checkboxInput(
                       inputId = "checkReminderVaccination",
                       label = "Erinnerung",
                       value = FALSE
                     ),
                     conditionalPanel(condition = "input.checkReminderVaccination == true",
                                      numericInput(inputId = "repeatVaccination",
                                                   label = "Wiederholungsimpfung",
                                                   value = NA,
                                                   min = 1)
                     )
              )
            ),
            fluidRow(
              column(12,
                     span(textOutput("inputCheckerVaccination"), style = "color:#ff3300"),
                     tags$head(tags$style("#inputCheckerVaccination{color: red;}"))
              )
            ),
              fluidRow(
              column(12, align = "right", 
                     br(),
                     br(),
                     actionButton(inputId = "button_backToCalfListVaccination",
                                  label = "Zurueck zu Tierliste"),
                     tags$head(tags$style(
                       "#button_backToCalfListVaccination{background-color: #EFEFEF; border-color: #A3A3A3}")),
                     actionButton(inputId = "button_ConfirmVaccination", label = "Fertig",
                                  styleclass = "warning"),
                     br()
              )
            )
          ))),
          # emergency warning if someone got to vaccination tab without filtering
          div(id = "selectCalvesInfoVaccination", box(
            title = "Hinweis",
            width = 12,            
            status = "info",
            solidHeader = TRUE,
            fluidRow(column(12, align = "center",h3("Bitte zuerst Tiere in Liste filtern")))
          ))
  )
}