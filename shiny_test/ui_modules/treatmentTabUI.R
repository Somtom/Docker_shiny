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
                          label = "Körpertemperatur",
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
        column(4,
               selectInput(inputId = "drug",
                           label = "Medikament",
                           choices = data$diseases)
        ),
        column(4,
               selectInput(inputId = "temperature", 
                           label = "Körpertemperatur",
                           choices = data$calves$nr)
        ),
        column(4,
               numericInput(inputId = "nextTreatment", 
                            label = "Nächste Behandlung",
                            value = NA)
        )
      ),
      fluidRow(
        column(4,
               textInput(inputId = "waitingTime", 
                         label = "Wartezeit")
        ),
        column(4,
               conditionalPanel(
                 condition = "input.checkAuA == true",
                 textInput(inputId = "AuANr",
                           label = "AuA-Beleg Nr.")
               )
        )
      )
    ),
    hr(),
    h4(strong("Maßnahmen")),
    fluidRow(
      column(4,
             checkboxInput(
               inputId = "checkReminder",
               label = "Erinnerung",
               value = TRUE
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
                                          label = "Elektrolytrezept auswählen",
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
                           label = "Medizinrezept auswählen",
                           choices = data$recepiesMedicine))
      ) 
    ),
    fluidRow(
      column(2,
             offset = 10,
             actionButton(inputId = "confirmTreatment", label = "Fertig"))
    )
  )
  )