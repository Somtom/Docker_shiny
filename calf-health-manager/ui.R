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
source("./functions/saveToCouchDB.R")

# Defining the UI
shinyUI(
  dashboardPage(
    title = "Calf Health Manager",
    dashboardHeader(),
    dashboardSidebar(uiOutput("sidebarUI")),
    dashboardBody(uiOutput("bodyUI"))
  )
)

