# This script defines the Treatment Tab in the body of Calf Health Manager Dashboard

treatmentTabUI <- function(input, output, session, rv) {
  tabItem(tabName = "treatment", box(id = "boxTreatment",
    width = 12,
    title = "Befundsdokumentation",
    status = "danger",
    solidHeader = TRUE,
    fluidRow(
      column(4,
             dateInput(inputId = "dateTreatment",
                       label = "Datum",
                       value = as.Date(Sys.time()),
                       max = as.Date(Sys.time()))
      ),
      column(4,
             conditionalPanel(
               condition = "input.checkUserTreatment == true",
               textInput(inputId = "observerTreatment",
                         label = "Beobachter")
             )
      )
    ),
    fluidRow(
      column(4,
             selectInput(inputId = "feederTreatment", 
                         label = "Automat",
                         choices = c("",rv$data$calves$feeder)
                         )
      ),
      column(4,
             selectInput(inputId = "calfTreatment",
                         label = "Kalbnummer",
                         choices = c("",rv$data$calves$calf.feeder)
                           )
      ),
      column(4,
             selectInput(inputId = "eartagTreatment", 
                         label = "Ohrmarken-Nr.",
                         choices = c("",rv$data$calves$eartag)
                           )
                             
      )
    ),
    hr(),
    h4(strong("Informationen zum Befund")),
    br(),
    fluidRow(
      column(4,
             selectizeInput(inputId = "findingsTreatment",
                              label = "Befund",
                              multiple = TRUE,
                              choices = c("",rv$data$findings),
                              options = list(create = TRUE,
                                             plugins = list("remove_button"))
                              )
             
      ),
      column(4,
             numericInput(inputId = "temperatureTreatment", 
                          label = "Koerpertemperatur",
                          value = "")
      ),
      column(4,
             selectInput(inputId = "diagnosisTreatment",
                         label = "Aerztliche Diagnose",
                         choices = c("",rv$data$diseases))
      )
    ),
    fluidRow(
      column(4,
             textInput(inputId = "notesTreatment", 
                       label = "Notizen")
      )
    ),
    br(),
    fluidRow(
      column(12,
             radioButtons(inputId = "choiceDrugtreatment",
                          label = "Wurden Medikamente verabreicht?",
                          choices = c("ja" = TRUE, "nein" = FALSE),
                          selected = FALSE,
                          inline = TRUE)
      )
      
    ),
    conditionalPanel(
      condition = "input.choiceDrugtreatment == 'TRUE'",
      hr(),
      h4(strong("Informationen zur Medikamentengabe")),
      br(),
      fluidRow(
        column(4,
               selectInput(inputId = "drugTreatment",
                           label = "Medikament",
                           choices = rv$data$drugs)
        ),
        column(4,
               numericInput(inputId = "dosisTreatment",
                            label = "Anwendungsmenge [ml]",
                            value = NA)
               ),
        column(4,
               conditionalPanel(
                 condition = "input.checkAuA == true",
                 numericInput(inputId = "AuANrTreatment",
                              label = "AuA-Beleg Nr.",
                              value = NA)
               )
        )
      ),
      fluidRow(
        column(4,
               numericInput(inputId = "waitingTimeTreatment", 
                            label = "Wartezeit",
                            value = NA)
               )
      )
    ),
    hr(),
    h4(strong("Massnahmen")),
    fluidRow(
      column(4,
             checkboxInput(
               inputId = "checkReminderTreatment",
               label = "Erinnerung",
               value = FALSE
             ),
             conditionalPanel(condition = "input.checkReminderTreatment == true",
                              numericInput(inputId = "nextTreatment", 
                                           label = "Naechste Beh.",
                                           value = NA,
                                           min = 1)
             )
      ),
      column(4,
             checkboxInput(
               inputId = "checkGiveElectrolyt",
               label = "Elektrolytrezept",
               value = FALSE
             ),
             conditionalPanel(condition = "input.checkGiveElectrolyt == true",
                              selectInput(inputId = "electrolytRecipie",
                                          label = "Rezept",
                                          choices = rv$data$recepiesElectrolyt))
      ),
      column(4,
             checkboxInput(
               inputId = "checkGiveMedicine",
               label = "Medizinrezept",
               value = FALSE
             ),
             conditionalPanel(
               condition = "input.checkGiveMedicine == true",
               selectInput(inputId = "medicineRecipie",
                           label = "Rezept",
                           choices = rv$data$recepiesMedicine))
      ) 
    ),
    fluidRow(
      column(12, 
             span(textOutput("inputCheckerTreatment"), style = "color:#ff3300"),
             tags$head(tags$style("#inputCheckerTreatment{color: red;}")),
             shinyalert("alertConfirmTreatment", auto.close.after = 2)
      )
    ),
    fluidRow(
      column(12, align = "right", 
             br(),
             br(),
             actionButton(inputId = "button_ConfirmTreatment", label = "Fertig",
                          styleclass = "danger"),
             br()
      )
    )
  ),
  fluidRow())
}