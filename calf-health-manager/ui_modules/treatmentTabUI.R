# This script defines the Treatment Tab in the body of Calf Health Manager Dashboard

treatmentTabUI <- 
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
      )
    ),
    fluidRow(
      column(4,
             selectInput(inputId = "calfTreatment", 
                         label = "Kalbnummer",
                         choices = data$calves$nr)
      ),
      column(4,
             selectInput(inputId = "eartagTreatment", 
                         label = "Ohrmarken-Nr.",
                         choices = data$calves$eartag)
      ),
      column(4,
             conditionalPanel(
               condition = "input.checkUserTreatment == true",
               textInput(inputId = "userTreatment",
                         label = "Benutzer"))
      )
    ),
    hr(),
    h4(strong("Informationen zum Befund")),
    br(),
    fluidRow(
      column(4,
             selectInput(inputId = "findingsTreatment",
                         label = "Befund",
                         choices = data$findings)
      ),
      column(4,
             numericInput(inputId = "temperatureTreatment", 
                          label = "Koerpertemperatur",
                          value = "")
      ),
      column(4,
             selectInput(inputId = "diagnosisTreatment",
                         label = "Aerztliche Diagnose",
                         choices = data$diseases)
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
                           choices = data$drugs)
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
                                          choices = data$recepiesElectrolyt))
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
                           choices = data$recepiesMedicine))
      ) 
    ),
    fluidRow(
      column(10, 
             span(textOutput("inputCheckerTreatment"), style = "color:#ff3300"),
             tags$head(tags$style("#inputCheckerTreatment{color: red;}")),
             shinyalert("alertConfirmTreatment", auto.close.after = 2)
      ),
      column(2,
             br(),
             br(),
             actionButton(inputId = "button_ConfirmTreatment", label = "Fertig",
                          styleclass = "danger"),
             br()
      )
    )
  ),
  fluidRow())
  