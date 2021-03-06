
require(shiny)
require(shinydashboard)
require(shinysky)
require(shinyjs)
require(openssl)
require(data.table)
require(R4CouchDB)
require(V8)



#input Data
source("./data/inputData.R")


# Source functions
source("./server_functions/addNewTreatment.R")
source("./server_functions/addNewVaccination.R")
source("./server_functions/addNewGroupTreatment.R")
source("./server_functions/inputCheckerTreatment.R")
source("./server_functions/inputCheckerGroupTreatment.R")
source("./server_functions/inputCheckerVaccination.R")
source("./server_functions/saveToCouchDB.R")
source("./server_functions/viewFromCouchDB.R")
source("./server_functions/getHistoryData.R")
source("./server_functions/calfListFilter.R")
source("./server_functions/renderHistoryTables.R")
source("./server_functions/matchSelectedAnimalInfo.R")
source("./server_functions/verifyUser.R")
source("./couchLogin.R")


# Translation
# source("./translation/updateTranslation.R")
# source("./translation/translationFunction.R")
# load("./translation/translation.bin")

# Defining the UI
shinyUI(
  dashboardPage(
    title = "Calf Health Manager",
    dashboardHeader(title = tags$p("Calf Health Manager",
                                   style = "font-size:80%; font-weight:bold"),
                    #Reminder Dropdown
                    dropdownMenuOutput("reminderDropdown"),
                    
                    # User Information and Logout
                    dropdownMenuOutput(outputId = "userDropdown"),
                    
                    # home button
                    tags$li(class = "dropdown",
                            shiny::actionButton(
                              inputId = "button_home",
                              label = "",
                              icon = icon("home"),
                              style = "background-color: transparent;
                              color: white; border-color: transparent; padding:10px 15px"
                              ),
                            tags$style(".fa.fa-home {font-size: 180%}")
                            )
                    ),
    dashboardSidebar(collapsed = TRUE, uiOutput("sidebarUI")),
    dashboardBody(source("./www/customCSS.R")$value,
                  uiOutput("bodyUI"))
  )
)

