saveToCouchDB <- function(dt,
                          serverName = "192.168.158.129",
                          port = 5984,
                          DBName = "foerster-health-documentation") {
  require(R4CouchDB)

  
  #convert dt to list for couchDB upload
  push.data <- apply(dt,1,as.list)
  
  #initial connection to couchDB
  db <- R4CouchDB:::cdbIni(serverName = serverName, port = port, DBName = DBName)
  
  #loop for pushing every single row as new document to couchDB
  for (i in 1:length(push.data)) {
    db$dataList   <- push.data[[i]]
    db$id <- paste0("health-documentation:",
                    push.data[[i]]$type,
                    ".",
                    push.data[[i]]$eartag,
                    ":",as.integer(as.POSIXct(push.data[[i]]$date)))
    db <- cdbUpdateDoc(db)
  }
  
  
  if (db$res$ok) {print("Data succesfully saved to CouchDB")}
  else {print("Error: Data not saved to CouchDB")}
  
}

