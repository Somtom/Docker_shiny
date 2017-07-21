viewFromCouchDB <- function(designDoc,
                            view,
                            serverName = "localhost",
                            port = 5984,
                            DBName = "foerster-health-documentation",
                            queryParam = NA,
                            handleID = "remove") {
  require(R4CouchDB)
  require(data.table)
  
  if (!(handleID %in% c("remove", "only", "keep"))) {return(print("Wrong handleID"))}
  
  #initial connection to couchDB
  db <- R4CouchDB:::cdbIni(serverName = serverName, port = port, DBName = DBName)
  
  db$design <- designDoc
  db$view <- view
  
  #filter for user
  if (!is.na(queryParam)) {
    db$queryParam <- queryParam 
  }
  
  out <- cdbGetView(db)
  
  if (handleID == "only") {
    out <- lapply(out$res$rows, function(x) x$id)
    res <- unlist(out)
    return(res)
  }
  
  out <- lapply(out$res$rows, function(x) x$value)
  if (length(out) == 0) {
    print("Debug: No Data found in CouchDB")
    return(NA)}
  
  else if (length(out) == 1 | length(out) == length(unlist(out))) { return(data.frame(unlist(out)))}
  
  else {
    res <- rbindlist(out, fill = T)
    if (handleID == "keep") {
      res <- res[,-c("_rev")]
      return(data.frame(res))
      }
    res <- res[,-c("_id", "_rev")]
    res <- data.frame(res)
    return(res)
  }
}
