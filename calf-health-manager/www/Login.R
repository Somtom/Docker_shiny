#### Log in module ###

PASSWORD <- data.frame(
  Brukernavn = c("test"), 
  Passord = c("test")
)

# Header UI
output$headerUI <- renderUI({
  if (USER$Logged == FALSE) {
    dashboardHeader(title = h4("Calf Health Manager"),
                    titleWidth = 200)
  }
  
  else {
    dashboardHeader(title = h4("Calf Health Manager"),
                    titleWidth = 200)
  }
})

# SidebarUI
output$sidebarUI <- renderUI({
  if (USER$Logged == FALSE) {
    sidebarMenu()
  }
  
  else {
    sidebarMenu(
      id = "menuTabs",
      menuItem("Dashboard",
               tabName = "dashboard",
               icon = icon("dashboard")),
      menuItem("Einzelbefund",
               tabName = "treatment",
               icon = icon("medkit")),
      menuItem("Gruppenbehandlung",
               tabName = "calfList",
               icon = icon("ambulance")),
      shinyjs::hidden(menuItem("Impfung",
                               tabName = "vaccination",
                               icon = icon("ambulance"))),
      menuItem("History",
               tabName = "history",
               icon = icon("book")),
      menuItem("Optionen",
               tabName = "settings",
               icon = icon("gears"))
    )
  }
})


# Body UI
# SidebarUI
output$bodyUI <- renderUI({
  if (USER$Logged == FALSE) {list(
    box(
      title = "Login",
      solidHeader = TRUE,
      textInput("userName", "User Name:"),
      passwordInput("passwd", "Password:"),
      br(),
      actionButton("Login", "Log in")
    ),
    #source custom CSS
    source("./www/customCSS.R")$value
  )
  }
  
  else {list(
    list(
      useShinyjs(),
      tabItems(
        # Dasbhoard
        tabItem(tabName = "dashboard",
                fluidRow(
                  valueBoxOutput("goToTreatment", width = 6),
                  valueBoxOutput("goToVaccination", width = 6),
                  valueBoxOutput("goToHistory", width = 6),
                  valueBoxOutput("goToSettings", width = 6)
                ),
                fluidRow(column(4, offset = 4,
                                shinyalert("alertConfirmVaccination", auto.close.after = 2)
                                )
                         )
        ),
        #CalfList
        calfListTabUI,
        #Treatment
        treatmentTabUI,
        # Vaccination
        vaccinationTabUI,
        # History
        historyTabUI,
        # Settings
        settingsTabUI
      )
    ),
    # Add custom CSS
    source("./www/customCSS.R")$value
  )
  }
})


output$pass <- renderText({  
  if (USER$Logged == FALSE) {
    USER$pass
  }  
})

# Login info during session ----
output$userPanel <- renderUI({
  if (USER$Logged == TRUE) {
    fluidRow(
      column(2,
             "User: ", USER$name
      ),
      column(1, actionLink("logout", "Logout"))
    )
  }  
})

# control login
observeEvent(input$Login , {
  Username <- isolate(input$userName)
  Password <- isolate(input$passwd)
  Id.username <- which(PASSWORD$Brukernavn == Username)
  Id.password <- which(PASSWORD$Passord    == Password)
  if (length(Id.username) > 0 & length(Id.password) > 0) {
    if (Id.username == Id.password) {
      USER$Logged <- TRUE
      USER$name <- Username      
    } 
  } else {
    USER$pass <- "User name or password failed!"
  }
})

# control logout
observeEvent(input$logout , {
  USER$Logged <- FALSE
  USER$pass <- ""
})