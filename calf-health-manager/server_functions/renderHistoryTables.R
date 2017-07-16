renderHistoryTables <- function(input, output, session, rv) {
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
}