var BrowserWindow, app, jade, locals, mainWindow;

app = require('app');

locals = {};

jade = require('electron-jade');

BrowserWindow = require('browser-window');

mainWindow = null;

jade({
  pretty: true
}, locals);

app.on('window-all-closed', function() {
  if (process.platform !== 'darwin') {
    app.quit();
  }
});

app.on('ready', function() {
  mainWindow = new BrowserWindow({
    'width': 1200,
    'minWidth': 1200,
    'height': 1000,
    'minHeight': 1000,
    'title': 'Report A Taxi'
  });
  mainWindow.loadURL('file://' + __dirname + '/index.jade');
  mainWindow.setMenu(null);
});
