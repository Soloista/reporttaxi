app = require 'app'
locals = {}
jade = require 'electron-jade'

BrowserWindow = require 'browser-window'
mainWindow = null

jade {pretty: true}, locals

app.on 'window-all-closed', ()->
    if process.platform isnt 'darwin'
        app.quit()
        return

app.on 'ready', ()->
    mainWindow = new BrowserWindow {
        'width': 1200
        'minWidth': 1200
        'height': 1000
        'minHeight': 1000
        'title': 'Report A Taxi'
    }
    mainWindow.loadURL 'file://'+__dirname+'/index.jade'
    mainWindow.setMenu null
    mainWindow.openDevTools {detach: true}
    return