# This script defines the History Tab in the body of Calf Health Manager Dashboard

historyTabUI <- 
  tabItem(tabName = "history",
          fluidPage(
            div(dataTableOutput(outputId = "historyTable"),
                style = "font-size: 80%")
          ) 
  )