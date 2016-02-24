# This will handle all the request for database interaction
loki = require 'lokijs'
db = new loki 'db.json', {
    autosave: true
}
gRecords = null
db.loadDatabase {}, ()->
    gRecords = db.getCollection 'records'
    if gRecords is null
        gRecords = db.addCollection 'records'
    return