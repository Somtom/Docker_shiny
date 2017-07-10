# This script defines the Vaccination Tab in the body of Calf Health Manager Dashboard

vaccinationTabUI <-
  tabItem(tabName = "vaccination", box(
    id = "boxVaccination",
    width = 12,
    title = "Impfung - Tierliste",
    status = "warning",
    solidHeader = TRUE,
    sidebarLayout(
      sidebarPanel(
      ),
      mainPanel(fluidRow(
        column(12,
               dataTableOutput("calfList"),
               tags$head(tags$style("tfoot {display: table-header-group;}"))
        )
      ))
    )
    
   ),
   fluidRow()
  )
