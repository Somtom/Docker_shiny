calfListFilter <- function(input, output, session, rv, data) {
  observe({
    # show all if UI is not rendered yet----
    if (is.null(input$calfListFeedingDaysMin)) {
      rv$CalfListFilter <- list(feeder = data$calves$feeder,
                                calves = data$calves$nr,
                                eartags = data$calves$eartag,
                                feedingDays = data$calves$feedingDay
      )
      return()
    }
    
    # No choice made----
    if (is.null(input$calfListFeeder) 
        & is.null(input$calfListCalves) 
        & is.null(input$calfListEartags)
        & is.na(input$calfListFeedingDaysMin)
        & is.na(input$calfListFeedingDaysMax)) {
      rv$CalfListFilter <- list(feeder = data$calves$feeder,
                                calves = data$calves$nr,
                                eartags = data$calves$eartag,
                                feedingDays = data$calves$feedingDay
      )
      return()
    }
    
    # If at least one choice is made----
    
    #feeder
    if (is.null(input$calfListFeeder)) {feeder = NA}
    else {feeder = input$calfListFeeder}

    #calves
    if (is.null(input$calfListCalves)) {calves = NA}
    else {calves = input$calfListCalves}

    #eartag
    if (is.null(input$calfListEartags)) {eartags = NA}
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
    print(rv$CalfListFilter)
  })
  
  output$customCalfList <- renderDataTable(
    rv$customCalfList <- subset(data$calves,
                                (feeder %in% rv$CalfListFilter$feeder
                                | nr %in% rv$CalfListFilter$calves
                                | eartag %in% rv$CalfListFilter$eartags)
                                & feedingDay %in% rv$CalfListFilter$feedingDays
                                
    ),
    options = list(pageLength = 50,
                   dom = "bottomp")
  )
  
}