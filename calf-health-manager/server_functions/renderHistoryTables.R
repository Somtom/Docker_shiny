renderHistoryTables <- function(input, output, session, rv) {
  ## Findings / Treatments
  output$historyTable <- 
    renderDataTable({
      table <- rv$treatmentTable[with(rv$treatmentTable, order(date, decreasing = T)),]
      table <- table[,-which(names(table) %in%
                               c("calfID","calf.feeder", "X_id"))]
      selectedColumns <- names(table) %in% c(input$checkHistoryTable,
                                                         "date", "type", "calf", "eartag", "diagnosis")
      table[selectedColumns]},
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
      table <- rv$vaccinationTable[with(rv$vaccinationTable, order(date, decreasing = T)),]
      rv$vaccinationTable},
      options = list(scrollX = TRUE)
    )
}