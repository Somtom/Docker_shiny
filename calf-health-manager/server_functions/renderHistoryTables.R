renderHistoryTables <- function(input, output, session, rv) {
  ## Findings / Treatments
  output$historyTable <- 
    renderDataTable({
      table <- rv$treatmentTable[with(rv$treatmentTable, order(date, decreasing = T)),]
      table <- table[,-which(names(table) %in%
                               c("calfID","calf.feeder", "X_id", "users", "X_id.1"))]
      selectedColumns <- names(table) %in% c(input$checkHistoryTableTreatment,
                                                         "date", "type", "calf", "eartag", "diagnosis")
      table[selectedColumns]},
      options = list(scrollX = TRUE)
    )
  
  
  output$vaccinationTable <- 
    renderDataTable({
      table <- rv$vaccinationTable[with(rv$vaccinationTable, order(date, decreasing = T)),]
      table <- table[,-which(names(table) %in%
                               c("calfID","calf.feeder", "X_id", "users", "X_id.1"))]
      selectedColumns <- names(table) %in% c(input$checkHistoryTableVaccination,
                                                           "date",
                                                           "type",
                                                           "feeder",
                                                           "calf",
                                                           "eartag",
                                                           "purpose")
      table[selectedColumns]},
      options = list(scrollX = TRUE)
    )
}