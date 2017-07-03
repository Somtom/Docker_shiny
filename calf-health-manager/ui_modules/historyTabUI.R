# This script defines the History Tab in the body of Calf Health Manager Dashboard

historyTabUI <- 
  tabItem(tabName = "history",
          fluidPage(
            box(width = 400,
                title = "History",
                status = "info",
                solidHeader = TRUE,
                div(dataTableOutput(outputId = "historyTable"),
                                    style = "font-size: 80%")
                )
          ) 
  )