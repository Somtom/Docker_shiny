viewFromCouchDB <- function(designDoc,
                            view,
                            serverName,
                            port = 5984,
                            DBName = "foerster-health-documentation",
                            queryParam = NA) {
  require(R4CouchDB)
  require(data.table)
  
  #initial connection to couchDB
  db <- R4CouchDB:::cdbIni(serverName = serverName, port = port, DBName = DBName)
  
  db$design <- designDoc
  db$view <- view
  
  #filter for user
  if (!is.na(queryParam)) {
    db$queryParam <- queryParam 
  }
  
  out <- cdbGetView(db)
  out <- lapply(out$res$rows, function(x) x$value)
  if (length(out) == 0) {
    print("Debug: No Data found in CouchDB")
    return(NA)}
  
  if (length(out) == 1 ) { return(unlist(out)) }
  
  else {
    res <- rbindlist(out, fill = T)
    res <- res[,-c("_id", "_rev")]
    res <- data.frame(res)
    return(res)
  }
}
