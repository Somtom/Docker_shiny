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
             numericInput(inputId = "calfListFeedingDaysMin",
                          label = "Ab Futtertag",
                          value = NA),
             numericInput(inputId = "calfListFeedingDaysMax",
                          label = "Bis Futtertag",
                          value = NA)
      ),
      column(9,
             fluidRow(
               column(4,
                      actionButton(inputId = "button_newVaccination",
                                   label = "Tierliste impfen",
                                   styleclass = "warning")
               ),
               column(3, br()),
               column(4,
                      actionButton(inputId = "button_newGroupTreatment",
                                   label = "Tierliste behandeln",
                                   styleclass = "danger")
               )
             ),
             br(),
             fluidRow(
               column(12,
               dataTableOutput("customCalfList")
               )
             )
      )
    )
  ),
  fluidRow())