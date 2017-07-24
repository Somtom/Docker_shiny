# Function to pull Data for History Table for logged in User from couchDB

getHistoryData <- function(input, session, rv, USER, couchIP) {
  observeEvent(USER$Logged, {
    if (USER$Logged) {
      updateTabItems(session, "menuTabs", "dashboard")
      res <- 
        viewFromCouchDB(designDoc  = "typeFilter",
                        view = "findings.treatments",
                        serverName = couchIP,
                        queryParam = paste0('keys=[["finding", \"',
                                            USER$name,
                                            '\"],["treatment", \"',
                                            USER$name,
                                            '\"]]'))
      if (!is.vector(res)) {rv$treatmentTable <- res}
      
      res <- 
        viewFromCouchDB(designDoc  = "typeFilter",
                        view = "vaccinations",
                        serverName = couchIP,
                        queryParam = paste0('key=["vaccination", \"',
                                            USER$name,
                                            '\"]'))
      
      if (!is.vector(res)) {rv$vaccinationTable <- res}
    }
  })
}