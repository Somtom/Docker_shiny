shinyServer(function(input, output, session) {
  
  
  output$goToTreatment <- renderValueBox({
    box1<-valueBox(value = "Befund"
                   ,icon = icon("thermometer-full")
                   ,width = NULL
                   ,color = "red"
                   ,href = "#"
                   ,subtitle = "Befund oder Behandlung eintragen"
    )
    box1$children[[1]]$attribs$class<-"action-button"
    box1$children[[1]]$attribs$id<-"button_goToTreatment"
    return(box1)
  })
  
  output$goToVaccination <- renderValueBox({
    box1<-valueBox(value = "Impfung"
                   ,icon = icon("medkit")
                   ,width = NULL
                   ,color = "yellow"
                   ,href = "#"
                   ,subtitle = "Impfung eintragen"
    )
    box1$children[[1]]$attribs$class<-"action-button"
    box1$children[[1]]$attribs$id<-"button_goToVaccination"
    return(box1)
  })
  
  output$goToSettings <- renderValueBox({
    box1<-valueBox(value = "Optionen"
                   ,icon = icon("gear")
                   ,width = NULL
                   ,color = "light-blue"
                   ,href = "#"
                   ,subtitle = "Eingabemasken anpassen"
    )
    box1$children[[1]]$attribs$class<-"action-button"
    box1$children[[1]]$attribs$id<-"button_goToSettings"
    return(box1)
  })
  

  # Switch: Dashboard to Treatment
  observeEvent(input$button_goToTreatment, {
    newtab <- switch(input$tabs,
                     "dashboard" = "treatment"
    )
    updateTabItems(session, "tabs", newtab)
  })
  
  # Switch: Dashboard to Vaccination
  observeEvent(input$button_goToVaccination, {
    newtab <- switch(input$tabs,
                     "dashboard" = "vaccination"
    )
    updateTabItems(session, "tabs", newtab)
  })
  
  # Switch: Dashboard to Settings
  observeEvent(input$button_goToSettings, {
    newtab <- switch(input$tabs,
                     "dashboard" = "settings"
    )
    updateTabItems(session, "tabs", newtab)
  })
  
  # Debug -------------------------------------------------------------------
  observeEvent(input$drugtreatment,{print(input$drugtreatment)})
})


