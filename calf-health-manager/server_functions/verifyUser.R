
verifyUser <- function(userName,
                       pwd,
                       serverName = "localhost",
                       port = 5984,
                       DBName = "foerster-cloud") {
  require(V8)
  require(R4CouchDB)
  require(data.table)
  
  # test user 
  if (userName == "test") {
    pin <- list(salt = '200.rYwLQeU6ly+LOmffc0Rw9GiPs+ltZWS6x8p5sGwz/cc=',
                hash = 'FFUS9VXra3IIbZ4cXtv7y/Z8HX4BaHvkgv3Y24ghJW1i6v9TZm/3qmzgxhMZFDORqibkRH7ZTNmFfoelhIbdH6dbUA42llyfNPpVFlHcUjWUfzY4c1+SXNvervfZRLFhnq9lIfUV+nBQjvpFp5QyydbfI5rTffrq8h1gQvHsuz+yE9OYUTSHQhDOHBKp6EKuSr/IwsSmNL6jyNO+NbuUkHFCRiZurbqIj0sp3MUHErzwfWiFERi2nvUXX414bAbqFLBlDGBTMqHOt2qbmSHh+PXUaor4hVRJgjyGUHp8AJbiuycWcZesYCO9sD/eOrRHB9twNM7QLKvMXskw/N+bfA==')
    pwd <- "blablub"
  }
  
  # normal user
  else {
    #initial connection to couchDB
    db <- R4CouchDB:::cdbIni(serverName = serverName, port = port, DBName = DBName)
    
    user <- gsub("@", "%2540", userName)
    db$id <- gsub(":", "%3A", paste0("employee:", user))
    
    out <- tryCatch(cdbGetDoc(db), error = function(e) {return(NULL)})
    
    # if user not found: return 
    if (is.null(out)) {return(FALSE)}
    
    pin <- out$res$pin_crypted
  }
  
  
  
  # verifying 
  ct <- v8()
  ct$source("./server_functions/verify.js")
  
  salt <- paste0("'",pin$salt,"'")
  hash <- paste0("'",pin$hash,"'")
  pwd <- paste0("'",pwd,"'")
  
  verify <- ct$eval(paste0("verify(",salt,",",hash,",",pwd,")"))
  
  return(ifelse(verify == "true", TRUE, FALSE))
  }



