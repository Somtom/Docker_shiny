inputCheckerVaccination <- function(input, output, session) {
  observeEvent(input$button_ConfirmVaccination,{
    
    output$inputCheckerVaccination <- renderText({
      validate(
        need(input$vaccinationPurpose != "", "Please choose an vaccination purpose"),
        need(input$vaccine != "", "Please choose a vaccine"),
        if (input$checkReminderVaccination == TRUE) {
          need(input$repeatVaccination, "Please provide days until next vaccination for reminder")
        }
      )
    }
    )
  })
}