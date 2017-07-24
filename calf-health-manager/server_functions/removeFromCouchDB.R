removeFromCouchDB <- function(designDoc,
                            view,
                            serverName = "localhost",
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
  
  out <- lapply(out$res$rows, function(x) x$id)
  res <- unlist(out)
  
  for (i in res) {
    db$id <- i
    cdbDeleteDoc(db)
  }
  

  

}
