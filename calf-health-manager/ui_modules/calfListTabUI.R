# CalfList Ui

calfListTabUI <-
  tabItem(tabName = "calfList", box(
    id = "boxCalfList",
    width = 12,
    title = "Tierliste",
    status = "warning",
    solidHeader = TRUE,
      fluidRow(
        column(3,
               selectInput(inputId = "calfListFeeder",
                           label = "Automat",
                           multiple = TRUE,
                           choices = unique(data$calves$feeder)), 
               selectInput(inputId = "calfListCalves",
                           label = "Kalb",
                           multiple = TRUE,
                           choices = data$calves$nr),
               selectInput(inputId = "calfListEartags",
                           label = "Ohrmarken-Nr",
                           multiple = TRUE,
                           choices = data$calves$eartag),
               textInput(inputId = "calfListFeedingDays",
                           label = "Futtertag")
        ),
        column(9,
              dataTableOutput("customCalfList")
               )
      )
  ))