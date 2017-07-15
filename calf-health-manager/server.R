shinyServer(function(input, output, session) {
  couchIP <- "172.18.0.23"
  
  # Custom reactive Values
  rv <- reactiveValues()

  # Login --------------
  USER <- reactiveValues(Logged = FALSE , session = session$user) 
  source("www/Login.R", local = TRUE)
  
  
  
  observeEvent(USER$Logged, {
    if(USER$Logged) {
      updateTabItems(session, "menuTabs", "dashboard")
      rv$treatmentTable <- 
        viewFromCouchDB(designDoc  = "typeFilter",
                        view = "findings",
                        serverName = couchIP,
                        queryParam = paste0('key=["finding", \"',
                                            USER$name,
                                            '\"]'))
      
      rv$vaccinationTable <- 
        viewFromCouchDB(designDoc  = "typeFilter",
                        view = "vaccinations",
                        serverName = couchIP,
                        queryParam = paste0('key=["vaccination", \"',
                                            USER$name,
                                            '\"]'))
      }
    })
  
  
  # Check and add Treatment / Vaccination
  inputCheckerTreatment(input, output, session)
  inputCheckerVaccination(input, output, session)
  addNewTreatment(input, output, session, rv, USER, couchIP)
  addNewVaccination(input, output, session, rv, USER, couchIP)
  
  
  
  
  #Calf List ----
  
  observe({
    if (is.null(input$calfListFeedingDaysMin)) {
      rv$CalfListFilter <- list(feeder = data$calves$feeder,
                                calves = data$calves$nr,
                                eartags = data$calves$eartag,
                                feedingDays = data$calves$feedingDay
      )
      return()
    }
    
    #feeder
    if (is.null(input$calfListFeeder)) {feeder = data$calves$feeder}
    else {feeder = input$calfListFeeder}
    
    #calves
    if (is.null(input$calfListCalves)) {calves = data$calves$nr}
    else {calves = input$calfListCalves}
    
    #eartag
    if (is.null(input$calfListEartags)) {eartags = data$calves$eartag}
    else {eartags = input$calfListEartags}
    
    #feeding days
    if (is.na(input$calfListFeedingDaysMin) & is.na(input$calfListFeedingDaysMax)) {
      feedingDays <- data$calves$feedingDay
    }
    else if (is.na(input$calfListFeedingDaysMin)) {
      feedingDays <- 0:input$calfListFeedingDaysMax
    }
    else if (is.na(input$calfListFeedingDaysMax)) {
      feedingDays <- input$calfListFeedingDaysMin:max(data$calves$feedingDay, na.rm = T)
    }
    else {feedingDays <- input$calfListFeedingDaysMin:input$calfListFeedingDaysMax}
    
    
    
    rv$CalfListFilter <-    list(feeder = feeder,
                                 calves = calves,
                                 eartags = eartags,
                                 feedingDays = feedingDays
    )
    
  })
  
  
  
  output$customCalfList <- renderDataTable(
    rv$customCalfList <- subset(data$calves,
                                feeder %in% rv$CalfListFilter$feeder
                                & nr %in% rv$CalfListFilter$calves
                                & eartag %in% rv$CalfListFilter$eartags
                                & feedingDay %in% rv$CalfListFilter$feedingDays
    ),
    options = list(pageLength = 50,
                   dom = "bottomp")
  )
  
  
  # History Tables -----
  
  ## Findings / Treatments
  
  output$historyTable <- 
    renderDataTable({
      selectedColumns <- names(rv$treatmentTable) %in% c(input$checkHistoryTable,
                                                         "date", "type", "calf", "eartag", "diagnosis")
      rv$treatmentTable[selectedColumns]},
      options = list(scrollX = TRUE)
    )
  
  ## Vaccinations
  # CustomVaccinationTable <- reactive({
  #   selectedColumns <- names(rv$vaccinationTable) %in% c(input$checkHistoryTable,
  #                                                      "Datum", "Kalb", "Diagnose", "Art")
  #   rv$treatmentTable[selectedColumns]
  #   
  #   print(rv$treatmentTable)})
  
  output$vaccinationTable <- 
    renderDataTable({
      # selectedColumns <- names(rv$treatmentTable) %in% c(input$checkHistoryTable,
      #                                                    "date", "type", "calf", "eartag", "diagnosis")
      # rv$treatmentTable[selectedColumns]},
      rv$vaccinationTable},
      options = list(scrollX = TRUE)
    )
  
  
  
  
  
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
  
  ## Back to Dashboard
  observeEvent(input$button_backToDashboardCalfList, {
    newtab <- switch(input$menuTabs,
                     "calfList" = "dashboard"
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
  
  
  
  
  # Debug -------------------------------------------------------------------
  
})