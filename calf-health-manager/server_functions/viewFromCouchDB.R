viewFromCouchDB <- function(designDoc,
                            view,
                            serverName = "localhost",
                            port = 5984,
                            DBName = "foerster-health-documentation",
                            queryParam = NA,
                            handleID = "remove",
                            user = couchUser,
                            pass = couchPwd) {
  require(R4CouchDB)
  require(data.table)
  
  if (!(handleID %in% c("remove", "only", "keep"))) {return(print("Wrong handleID"))}
  
  #initial connection to couchDB
  db <- R4CouchDB:::cdbIni(serverName = serverName, port = port, DBName = DBName,
                           uname = user,pwd = pass)
  
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
  
  #else if (length(out) == 1 | length(out) == length(unlist(out))) { return(data.frame(unlist(out)))}
  
  else {
    #check if variable "users" in out and add it to data.frame
    if (TRUE %in% unlist(lapply(out, function(x) length(x[which(names(x) == "users")]) > 0))) {
      users <- lapply(out, function(x) x$users)
      res <- data.frame(rbindlist(lapply(out, function(x) x[-which(names(x) == "users")]), fill = T))
      res$users <- users
    }
    else {res <- rbindlist(out, fill = T)}
    
    if (handleID == "keep") {
      res <- subset(res, select = -X_rev)
      return(data.frame(res))
      }
    res <- subset(res, select = -c(X_id, X_rev))
    res <- data.frame(res)
    return(res)
  }
}
