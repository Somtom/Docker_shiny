require(shiny)
require(shinydashboard)


# Get predefined input data
source("./data/inputData.R")



# Source UI-elements
source("./ui_modules/treatmentTabUI.R")$value
source("./ui_modules/vaccinationTabUI.R")$value
source("./ui_modules/settingsTabUI.R")$value
source("./ui_modules/historyTabUI.R")$value


# Defining the UI


shinyUI(
  dashboardPage(title = "Calf Health Manager",
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
                    menuItem("Befund",
                             tabName = "treatment",
                             icon = icon("thermometer-full")),
                    menuItem("Impfung",
                             tabName = "vaccination",
                             icon = icon("medkit")),
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
                  tabItems(
                    # Dasbhoard
                    tabItem(tabName = "dashboard",
                            fluidRow(
                              valueBoxOutput("goToTreatment", width = 6),
                              valueBoxOutput("goToVaccination", width = 6),
                              valueBoxOutput("goToHistory", width = 6),
                              valueBoxOutput("goToSettings", width = 6)
                              )
                    ),
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
