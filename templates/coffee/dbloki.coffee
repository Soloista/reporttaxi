# This will handle all the request for database interaction
loki = require 'lokijs'
db = new loki 'db.json'
records = {}
db.loadDatabase {}, ()->
    records = db.getCollection 'records'
    if records is null
        records = db.addCollection 'records'
    return

recordInterface = {
    insert: (obj)->
        records.insert obj
        return
    getRecords: ()->
        return records.find()
}