inputCheckerGroupTreatment <- function(input, output, session) {
  observeEvent(input$button_ConfirmGroupTreatment, {
    
    output$inputCheckerGroupTreatment <- renderText({
      validate(
        need(input$purposeGroupTreatment != "", "Please give a purpose"),
        need(input$drugGroupTreatment != "", "Please choose a drug"),
        need(input$dosisGroupTreatment != "", "Please provide a drug-dosis"),
        if (input$checkReminderGroupTreatment == TRUE) {
          need(input$nextGroupTreatment, "Please provide days until next treatment for reminder")
        }
      )
    }
    )
  })
}