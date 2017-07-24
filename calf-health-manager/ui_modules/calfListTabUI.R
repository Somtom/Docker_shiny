# CalfList Ui

calfListTabUI <- function(input, output, session, rv) {
  tabItem(tabName = "calfList", box(
    id = "boxCalfList",
    width = 12,
    title = "Tierliste",
    status = "warning",
    solidHeader = TRUE,
    fluidRow(
      column(3, align = "center", offset = 4,
             actionButton(inputId = "button_newVaccination",
                          label = "Tierliste impfen",
                          styleclass = "warning")
      ),
      column(1,br()),
      column(3, align = "center",
             actionButton(inputId = "button_newGroupTreatment",
                          label = "Tierliste behandeln",
                          styleclass = "danger")
      )
    ),
    hr(),
    fluidRow(
      column(3,
             selectInput(inputId = "calfListFeeder",
                         label = "Automat",
                         multiple = TRUE,
                         choices = unique(rv$data$calves$feeder)), 
             selectInput(inputId = "calfListCalves",
                         label = "Kalb",
                         multiple = TRUE,
                         choices = rv$data$calves$calf.feeder),
             selectInput(inputId = "calfListEartags",
                         label = "Ohrmarken-Nr",
                         multiple = TRUE,
                         choices = rv$data$calves$eartag),
             numericInput(inputId = "calfListFeedingDaysMin",
                          label = "Ab Futtertag",
                          value = NA),
             numericInput(inputId = "calfListFeedingDaysMax",
                          label = "Bis Futtertag",
                          value = NA)
      ),
      column(9,
             fluidRow(
               column(12,
                      dataTableOutput("customCalfList")
               )
             )
      )
    )
  ),
  fluidRow())
}