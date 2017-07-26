# Function to pull Data for History Table for logged in User from couchDB

getHistoryData <- function(input, session, rv, USER, couchIP) {
  observeEvent(USER$Logged, {
    if (USER$Logged) {
      updateTabItems(session, "menuTabs", "dashboard")
      res <- 
        viewFromCouchDB(designDoc  = "typeFilter",
                        view = "findings.treatments",
                        serverName = couchIP,
                        queryParam = gsub('\"','%22',
                                          gsub("@", "%2540",
                                               paste0('keys=[["finding",\"',
                                                      gsub("@", "%2540",USER$name),
                                                      '\"],["treatment",\"',
                                                      gsub("@", "%2540",USER$name),
                                                      '\"]]'))))
      if (!is.vector(res)) {rv$treatmentTable <- res}
      
      res <- 
        viewFromCouchDB(designDoc  = "typeFilter",
                        view = "vaccinations",
                        serverName = couchIP,
                        queryParam = gsub('\"', '%22',
                                          gsub("@", "%2540",
                                               paste0('key=["vaccination",\"',
                                            USER$name,
                                            '\"]'))))
      
      if (!is.vector(res)) {rv$vaccinationTable <- res}
    }
  })
}