library(shiny)
library(shinydashboard)

data <- list(calves = data.frame(nr = c(1:30),
                                 eartags = paste0("DE03487700",
                                                  (62 + 1:30))),
             diseases = c("disease 1", "disease 2", "disease 3"),
             recepiesElectrolyt = c("Elektrolyt 1", "Elektrolyt 2"),
             recepiesMedicine = c("Medicine 1", "Medicine 2"))


shinyUI(
  dashboardPage(title = "Calf Health Manager",
                skin = "black",
                
                ###### Header           
                dashboardHeader(title = h4("Calf Health Manager"),
                                titleWidth = 200),
                
                ###### Sidebar
                dashboardSidebar(
                  sidebarMenu(
                    id = "tabs",
                    menuItem("Dashboard",
                             tabName = "dashboard",
                             icon = icon("dashboard")),
                    menuItem("Befund",
                             tabName = "treatment",
                             icon = icon("thermometer-full")),
                    menuItem("Impfung",
                             tabName = "vaccination",
                             icon = icon("medkit")),
                    menuItem("Optionen",
                             tabName = "settings",
                             icon = icon("gears"))
                  )
                ),
                ###### Body
                dashboardBody(
                  tabItems(
                    # Dasbhoard
                    tabItem(tabName = "dashboard",
                            fluidRow(
                              valueBoxOutput("goToTreatment", width = 6),
                              valueBoxOutput("goToVaccination", width = 6)
                              ),
                            fluidRow(
                              column(6,
                                     offset = 3,
                                     valueBoxOutput("goToSettings", width = 12)
                              )
                            )
                            
                    ),
                    
                    # Medikamentengabe
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
                      h4("Informationen zum Befund"),
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
                        h4("Informationen zur Medikamentengabe"),
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
                      br(),
                      h4("Maßnahmen"),
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
                    ),
                    
                    
                    
                    # Impfung
                    tabItem(tabName = "vaccination",
                            fluidRow(
                              "Impfung"
                            )
                    ),
                    
                    # Optionen
                    tabItem(tabName = "settings",
                            box(title = "Eingabefelder Befund",
                                status = "success",
                                solidHeader = TRUE,
                                "bla bla bla",
                                checkboxInput(inputId = "checkUserTreatment",
                                              label = "Benutzer",
                                              value = TRUE),
                                checkboxInput(inputId = "checkAuA",
                                              label = "AuA-Nr",
                                              value = TRUE)
                            ),
                            box(title = "Eingabefelder Impfung",
                                status = "success",
                                solidHeader = TRUE,
                                "bla bla bla",
                                checkboxInput(inputId = "checkUserVaccination",
                                              label = "Benutzer",
                                              value = TRUE)
                            )
                    )
                  )
                )
  )
)
