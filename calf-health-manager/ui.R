require(shiny)
require(shinydashboard)
require(shinysky)
require(shinyjs)


# Get predefined input data
source("./data/inputData.R")



# Source UI-elements
source("./ui_modules/calfListTabUI.R")$value
source("./ui_modules/treatmentTabUI.R")$value
source("./ui_modules/vaccinationTabUI.R")$value
source("./ui_modules/settingsTabUI.R")$value
source("./ui_modules/historyTabUI.R")$value


# Source functions
source("./functions/addNewTreatment.R")
source("./functions/addNewVaccination.R")
source("./functions/inputCheckerTreatment.R")


# Defining the UI
shinyUI(
  dashboardPage(
    title = "Calf Health Manager",
                #skin = "black",
                
                ###### Header           
                dashboardHeader(title = h4("Calf Health Manager"),
                                titleWidth = 200),
                
                ###### Sidebar
                dashboardSidebar(
                  sidebarMenu(
                    id = "menuTabs",
                    menuItem("Dashboard",
                             tabName = "dashboard",
                             icon = icon("dashboard")),
                    menuItem("Einzelbefund",
                             tabName = "treatment",
                             icon = icon("medkit")),
                    menuItem("Gruppenbehandlung",
                             tabName = "calfList",
                             icon = icon("ambulance")),
                    shinyjs::hidden(menuItem("Impfung",
                             tabName = "vaccination",
                             icon = icon("ambulance"))),
                    menuItem("History",
                             tabName = "history",
                             icon = icon("book")),
                    menuItem("Optionen",
                             tabName = "settings",
                             icon = icon("gears"))
                  )
                ),
                ###### Body
                dashboardBody(
                  useShinyjs(),
                  tabItems(
                    # Dasbhoard
                    tabItem(tabName = "dashboard",
                            fluidRow(
                              valueBoxOutput("goToTreatment", width = 6),
                              valueBoxOutput("goToVaccination", width = 6),
                              valueBoxOutput("goToHistory", width = 6),
                              valueBoxOutput("goToSettings", width = 6)
                              ),
                            fluidRow(column(4, offset = 4,shinyalert("alertConfirmVaccination", auto.close.after = 2)))
                    ),
                    #CalfList
                    calfListTabUI,
                    #Treatment
                    treatmentTabUI,
                    # Vaccination
                    vaccinationTabUI,
                    # History
                    historyTabUI,
                    # Settings
                    settingsTabUI
                  ),
                  # Add custom CSS
                  source("./www/customCSS.R")$value
                )
  )
)
