#### Log in module ###

# control login
observeEvent(input$Login , {
  Username <- isolate(input$userName)
  Password <- isolate(input$passwd)
  verify <- verifyUser(Username, Password, serverName = couchIP)
  if (verify) {
    USER$Logged <- TRUE
    USER$name <- Username
    print(paste("User",USER$name, "logged in"))
    
    userCalves <- viewFromCouchDB(designDoc = "healthDoc",
                                  view = "calfInfo",
                                  serverName = couchIP,
                                  DBName = "foerster-cc",
                                  queryParam = paste0('key=\"',
                                                      gsub("@", "%2540", USER$name),
                                                      '\"'), 
                                  handleID = "keep")
    if (!is.vector(userCalves)) {
      names(userCalves)[3] <- "nr"
      userCalves$eartag <- rep("", length(userCalves$'X_id'))
      userCalves$calf.feeder <- c(paste(userCalves$nr, "|", userCalves$feeder))
      userCalves$calfID <- unname(sapply(userCalves$'X_id', function(x) unlist(strsplit(x,":"))[2]))
      rv$data$calves <- userCalves[with(userCalves, order(feeder, nr)),]
      }
    
  } else {
    showshinyalert(session, "loginFailed", "Username or password failed",
                   styleclass = "blank")
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
      shinyjs::hidden(menuItem("Gruppenbehandlung",
                                tabName = "groupTreatment",
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
    column(4, offset = 4,
           wellPanel(
             title = "Login",
             solidHeader = TRUE,
             textInput("userName", "User Name:"),
             passwordInput("passwd", "Password:"),
             br(),
             actionButton("Login", "Log in")),
           shinysky::busyIndicator(text = "loggin in and loading data...", wait = 0),
           fluidRow(div(shinyalert("loginFailed", auto.close.after = 1),
                                    style = "color:red"))
             )
    )
  }
  
  else { 
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
                fluidRow(column(12, align = "center",
                                div(shinyalert("alertConfirm", auto.close.after = 2),
                                    style = "color:white; font-weight:bold")
                                )
                ),
                fluidRow()
        ),
        #CalfList
        calfListTabUI(input, output, session, rv),
        #Treatment
        treatmentTabUI(input, output, session, rv),
        # Vaccination
        vaccinationTabUI(input, output, session, rv),
        # Group Treatment
        groupTreatmentTabUI(input, output, session, rv),
        # History
        historyTabUI,
        # Settings
        settingsTabUI(input, output, session, rv)
      )
    )

  }
})


# control logout
# Logout
observeEvent(input$button_logout, {
  USER$Logged = FALSE
  print(paste("Debug: Logout User:", USER$name))
  USER$name <- NULL
})
