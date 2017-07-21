shinyServer(function(input, output, session) {
  couchIP <- "10.38.2.127"
  
  # Custom reactive Values
  rv <- reactiveValues()

  #input Data
  initializeInputData(session, rv)

  # Login --------------
  USER <- reactiveValues(Logged = FALSE , session = session$user) 
  source("www/Login.R", local = TRUE)
  
  # Match Animal Information (Nr and Eartag) on Treatment Table
  matchSelectedAnimalInfo(input, session, rv)
  
  # Get history table information for logged in User----
  getHistoryData(input, session, rv, USER, couchIP)

  # Check and add Treatment / Vaccination----
  inputCheckerTreatment(input, output, session)
  inputCheckerVaccination(input, output, session)
  addNewTreatment(input, output, session, rv, USER, couchIP)
  addNewVaccination(input, output, session, rv, USER, couchIP)
  addNewGroupTreatment(input, output, session, rv, USER, couchIP)
  
  # DropDown Menus----
  observe(
    if (USER$Logged) {
      output$userDropdown <- renderMenu(
        tags$li(class = "dropdown messages-menu",
                a(href = "#", class = "dropdown-toggle", id = "dropdownUser", 
                  `data-toggle` = "dropdown", icon("user-o")
                ),
               tags$style( "#dropdownUser {font-size:130%; padding-right: 10px}"),
                tags$ul(class = "dropdown-menu",
                        tags$li(class = "header", paste("Logged in as", USER$name)),
                        tags$li(
                          tags$ul(class = "menu",
                                  tags$li(
                                    tags$a(href = "#dashboard", icon("sign-out"), class = "action-button", id = "button_logout",
                                           h4(USER$name),
                                           p("Logout"))))
                        )
                )
        )
      )
      output$reminderDropdown <- renderMenu(
        dropdownMenu(type = "notifications",
                     badgeStatus = "warning",
                     icon = icon("bell-o"),
                     headerText = "Erinnerungen")
      )
    }
  )
  
  
  # Calf List Filter and filtered output----
  calfListFilter(input, output, session, rv)
  
  # Render history tables -----
  renderHistoryTables(input, output, session, rv)
  
  
  # Dashboard Link Boxes ---------------------------------------------------- 
  # Treatment Link Box
  output$goToTreatment <- renderValueBox({
    box1 <- valueBox(value = "Einzelbefund",
                     icon = icon("medkit"),
                     width = NULL,
                     color = "red",
                     href = "#",
                     subtitle = "Befund oder Behandlung eintragen"
    )
    box1$children[[1]]$attribs$class <- "action-button"
    box1$children[[1]]$attribs$id <- "button_goToTreatment"
    return(box1)
  })
  
  # Switch: Dashboard to Treatment
  observeEvent(input$button_goToTreatment, {
    newtab <- switch(input$menuTabs,
                     "dashboard" = "treatment"
    )
    updateTabItems(session, "menuTabs", newtab)
  })
  
  # Vaccination Link Box
  output$goToVaccination <- renderValueBox({
    box1 <- valueBox(value = "Gruppe",
                     icon = icon("ambulance"),
                     width = NULL,
                     color = "yellow",
                     href = "#",
                     subtitle = "Behandlung einer Tiergruppe eintragen"
    )
    box1$children[[1]]$attribs$class <- "action-button"
    box1$children[[1]]$attribs$id <- "button_goToCalfList"
    return(box1)
  })
  
  # Switch: Dashboard to Vaccination
  observeEvent(input$button_goToCalfList, {
    newtab <- switch(input$menuTabs,
                     "dashboard" = "calfList"
    )
    updateTabItems(session, "menuTabs", newtab)
  })
  
  # History Link Box
  output$goToHistory <- renderValueBox({
    box1 <- valueBox(value = "History",
                     icon = icon("book"),
                     width = NULL,
                     color = "aqua",
                     href = "#",
                     subtitle = "Historie ansehen"
    )
    box1$children[[1]]$attribs$class <- "action-button"
    box1$children[[1]]$attribs$id <- "button_goToHistory"
    return(box1)
  })
  
  # Switch: Dashboard to History
  observeEvent(input$button_goToHistory, {
    newtab <- switch(input$menuTabs,
                     "dashboard" = "history"
    )
    updateTabItems(session, "menuTabs", newtab)
  })
  
  # Settings Link Box
  output$goToSettings <- renderValueBox({
    box1 <- valueBox(value = "Optionen",
                     icon = icon("gear"),
                     width = NULL,
                     color = "light-blue",
                     href = "#",
                     subtitle = "Eingabemasken anpassen"
    )
    box1$children[[1]]$attribs$class <- "action-button"
    box1$children[[1]]$attribs$id <- "button_goToSettings"
    return(box1)
  })
  
  # Switch: Dashboard to Settings
  observeEvent(input$button_goToSettings, {
    newtab <- switch(input$menuTabs,
                     "dashboard" = "settings"
    )
    updateTabItems(session, "menuTabs", newtab)
  })
  
  
  
  # Other links ----
  # HOME button
  observeEvent(input$button_home, {
    newtab <- "dashboard"
    updateTabItems(session, "menuTabs", newtab)
  })
  
  
  
  # Calf List links
  ## New Vaccination 
  observeEvent(input$button_newVaccination, {
    print("Button neue Gruppenimpfung")
    
    #show dynamic UI
    shinyjs::show(id = "dynamicVaccinationUI")
    shinyjs::hide(id = "selectCalvesInfoVaccination")
    
    # Switch Tabs
    newtab <- switch(input$menuTabs,
                     "calfList" = "vaccination"
    )
    updateTabItems(session, "menuTabs", newtab)
  })
  
  ## New GroupTreatment
  observeEvent(input$button_newGroupTreatment, {
    print("Button neue Gruppen Behandlung")
    
    #show dynamic UI
    shinyjs::show(id = "dynamicGroupTreatmentUI")
    shinyjs::hide(id = "selectCalvesInfoGroupTreatment")
    
    newtab <- switch(input$menuTabs,
                     "calfList" = "groupTreatment"
    )
    updateTabItems(session, "menuTabs", newtab)
  })
  
  # Vaccination Links
  ## Back to CalfList
  observeEvent(input$button_backToCalfListVaccination, {
    newtab <- switch(input$menuTabs,
                     "vaccination" = "calfList"
    )
    updateTabItems(session, "menuTabs", newtab)
  })
  
  # Treatment Links
  ## Back to Dashboard
  observeEvent(input$button_backToDashboardTreatment, {
    newtab <- switch(input$menuTabs,
                     "treatment" = "dashboard"
    )
    updateTabItems(session, "menuTabs", newtab)
  })
  
  # Group Treatment links
  ## Back to CalfList
  observeEvent(input$button_backToCalfListGroupTreatment, {
    newtab <- switch(input$menuTabs,
                     "groupTreatment" = "calfList"
    )
    updateTabItems(session, "menuTabs", newtab)
  })
  
  
  

  # Debug -------------------------------------------------------------------
  
})