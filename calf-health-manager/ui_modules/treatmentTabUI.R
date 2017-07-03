# This script defines the Treatment Tab in the body of Calf Health Manager Dashboard

treatmentTabUI <- 
  tabItem(tabName = "treatment", box(
    width = 400,
    title = "Befundsdokumentation",
    status = "danger",
    solidHeader = TRUE,
    fluidRow(
      column(4,
             selectInput(inputId = "calf", 
                         label = "Kalbnummer",
                         choices = data$calves$nr)
      ),
      column(4,
             selectInput(inputId = "eartag", 
                         label = "Ohrmarken-Nr.",
                         choices = data$calves$eartags)
      ),
      column(4,
             conditionalPanel(
               condition = "input.checkUserTreatment == true",
               textInput(inputId = "user",
                         label = "Benutzer")
             )
      )
    ),
    hr(),
    h4(strong("Informationen zum Befund")),
    br(),
    fluidRow(
      column(4,
             selectInput(inputId = "diagnosis",
                         label = "Diagnose",
                         choices = data$diseases)
      ),
      column(4,
             numericInput(inputId = "temperature", 
                          label = "Koerpertemperatur",
                          value = "")
      ),
      column(4,
             textInput(inputId = "notes", 
                       label = "Notizen")
      )
    ),
    br(),
    fluidRow(
      column(12,
             radioButtons(inputId = "drugtreatment",
                          label = "Wurden Medikamente verabreicht?",
                          choices = c("ja" = TRUE, "nein" = FALSE),
                          selected = FALSE,
                          inline = TRUE)
      )
      
    ),
    conditionalPanel(
      condition = "input.drugtreatment == 'TRUE'",
      hr(),
      h4(strong("Informationen zur Medikamentengabe")),
      br(),
      fluidRow(
        column(3,
               selectInput(inputId = "drug",
                           label = "Medikament",
                           choices = data$drugs)
        ),
        column(3,
               numericInput(inputId = "waitingTime", 
                         label = "Wartezeit",
                         value = NA)
        ),
        column(3,
               conditionalPanel(
                 condition = "input.checkAuA == true",
                 numericInput(inputId = "AuANr",
                           label = "AuA-Beleg Nr.",
                           value = NA)
               )
        )
      )
    ),
    hr(),
    h4(strong("Massnahmen")),
    fluidRow(
      column(4,
             checkboxInput(
               inputId = "checkReminder",
               label = "Erinnerung",
               value = FALSE
             ),
             conditionalPanel(condition = "input.checkReminder == true",
                              numericInput(inputId = "nextTreatment", 
                                           label = "Naechste Beh.",
                                           value = NA)
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
      column(2,
             offset = 10,
             actionButton(inputId = "buttonConfirmTreatment", label = "Fertig"))
    ),
    fluidRow(
      br(),
      column(10, offset = 1,
             textOutput("textConfirmTreatment")
             )
      )
  )
  )