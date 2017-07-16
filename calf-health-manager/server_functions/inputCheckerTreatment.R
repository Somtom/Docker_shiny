inputCheckerTreatment <- function(input, output, session) {
  observeEvent(input$button_ConfirmTreatment, {
    
    output$inputCheckerTreatment <- renderText({
      validate(
        need(input$calfTreatment != "", "Please choose a calf"),
        need(input$eartagTreatment != "", "Please choose an eartag number"),
        need(input$findingsTreatment != "", "Please choose a finding"),
        if (input$checkReminderTreatment == TRUE) {
          need(input$nextTreatment, "Please provide days until next treatment for reminder")
        },
        if (input$choiceDrugtreatment == TRUE) {
          need(input$drugTreatment != "", "Please choose a drug")
        }
      )
    }
    )
  })
}