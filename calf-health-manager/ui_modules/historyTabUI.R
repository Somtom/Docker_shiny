# This script defines the History Tab in the body of Calf Health Manager Dashboard

historyTabUI <- 
  tabItem(tabName = "history",
          fluidPage(
            tabBox(width = 400,
                title = tagList(shiny::icon("book"), "History"),
                tabPanel( "Befunde/Behandlungen",
                  div(dataTableOutput(outputId = "historyTable"),
                      style = "font-size: 80%")
                ),
                tabPanel( "Impfungen",
                          div(dataTableOutput(outputId = "vaccinationTable"),
                              style = "font-size: 80%")
                )
                )
          ) 
  )