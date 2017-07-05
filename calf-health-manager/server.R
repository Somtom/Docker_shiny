shinyServer(function(input, output, session) {

  # Custom reactive Values
  rv <- reactiveValues()
  
  rv$treatmentTable <- treatmentTable
  
  inputCheckerTreatment(input, output, session)
  
  addNewTreatment(input, output, session, rv)
  
  # History Table
  # CustomTreatmentTable <- reactive({
  #   selectedColumns <- names(rv$treatmentTable) %in% c(input$checkHistoryTable,
  #                                                   "Datum", "Kalb", "Diagnose", "Art")
  #   rv$treatmentTable[selectedColumns]})
  
  output$historyTable <- 
    renderDataTable({rv$treatmentTable},
                    options = list(scrollX = TRUE)
                    )
  
  test <- "testname"
  output[[test]] <- renderText("Test output ok")
  
  
  # Dashboard Link Boxes ----------------------------------------------------    
  # Treatment Link Box
  output$goToTreatment <- renderValueBox({
    box1 <- valueBox(value = "Befund",
                   icon = icon("thermometer-full"),
                   width = NULL,
                   color = "red",
                   href = "#",
                   subtitle = "Befund oder Behandlung eintragen"
    )
    box1$children[[1]]$attribs$class<-"action-button"
    box1$children[[1]]$attribs$id<-"button_goToTreatment"
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
    box1<-valueBox(value = "Impfung",
                   icon = icon("medkit"),
                   width = NULL,
                   color = "yellow",
                   href = "#",
                   subtitle = "Impfung eintragen"
    )
    box1$children[[1]]$attribs$class<-"action-button"
    box1$children[[1]]$attribs$id<-"button_goToVaccination"
    return(box1)
  })
  
  # Switch: Dashboard to Vaccination
  observeEvent(input$button_goToVaccination, {
    newtab <- switch(input$menuTabs,
                     "dashboard" = "vaccination"
    )
    updateTabItems(session, "menuTabs", newtab)
  })
  
  # History Link Box
  output$goToHistory <- renderValueBox({
    box1<-valueBox(value = "History",
                   icon = icon("book"),
                   width = NULL,
                   color = "aqua",
                   href = "#",
                   subtitle = "Historie ansehen"
    )
    box1$children[[1]]$attribs$class<-"action-button"
    box1$children[[1]]$attribs$id<-"button_goToHistory"
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
    box1<-valueBox(value = "Optionen",
                   icon = icon("gear"),
                   width = NULL,
                   color = "light-blue",
                   href = "#",
                   subtitle = "Eingabemasken anpassen"
    )
    box1$children[[1]]$attribs$class<-"action-button"
    box1$children[[1]]$attribs$id<-"button_goToSettings"
    return(box1)
  })
  
  # Switch: Dashboard to Settings
  observeEvent(input$button_goToSettings, {
    newtab <- switch(input$menuTabs,
                     "dashboard" = "settings"
    )
    updateTabItems(session, "menuTabs", newtab)
  })





  

  

  
  
  # Debug -------------------------------------------------------------------

  
})


