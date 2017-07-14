#### Log in module ###

PASSWORD <- data.frame(
  user = c("test"), 
  password = c("9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08")
)



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
    column(4, offset = 4,
           wellPanel(
             title = "Login",
             solidHeader = TRUE,
             textInput("userName", "User Name:"),
             passwordInput("passwd", "Password:"),
             br(),
             actionButton("Login", "Log in")),
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
                                div(shinyalert("alertConfirmVaccination", auto.close.after = 2),
                                    style = "color:white; font-weight:bold")
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
  Id.username <- which(PASSWORD$user == Username)
  Id.password <- which(PASSWORD$password    == sha2(Password))
  if (length(Id.username) > 0 & length(Id.password) > 0) {
    if (Id.username == Id.password) {
      USER$Logged <- TRUE
      USER$name <- Username      
    } 
  } else {
    showshinyalert(session, "loginFailed", "Username or password failed",
                   styleclass = "blank")
  }
})

# control logout
observeEvent(input$logout , {
  USER$Logged <- FALSE
  USER$pass <- ""
})