'use strict';

const {app,BrowserWindow,ipcMain,Tray} = require('electron');

const path = require('path');
const url = require('url');
const AppTray = require('./src/scripts/Tray');


if (process.env.NODE_ENV === 'development') {
    require('electron-reload')(__dirname)
}

let mainWindow;
let tray;

function createWindow () {
    // Create the browser window.
    mainWindow = new BrowserWindow({frame: false,minWidth: 1024, minHeight: 670, width: 1024, height: 670, icon: path.join(__dirname,'src/assets', 'app.png')});

    // Create Tray
    tray = new AppTray(mainWindow);

    // and load the index.html of the app.
    if (process.env.NODE_ENV === 'development') {
        //mainWindow.loadURL(`http://localhost:3000`)
        mainWindow.loadURL(url.format({
          pathname: path.join(__dirname, 'index.html'),
          protocol: 'file:',
          slashes: true
        }));

        // Open the DevTools.
        if (process.env.NODE_ENV === 'development') {
          mainWindow.webContents.openDevTools()
        }

        const installExtension = require('electron-devtools-installer');
        installExtension.default(installExtension.VUEJS_DEVTOOLS)
          .then(name => console.log(`Added Extension:  ${name}`))
          .catch(err => console.log('An error occurred: ', err))

    } else {
        mainWindow.loadURL(url.format({
            pathname: path.join(__dirname, 'index.html'),
            protocol: 'file:',
            slashes: true
        }))
    }

    // Emitted when the window is closed.
    mainWindow.on('closed', function () {
        mainWindow = null
    });

    mainWindow.on('close', (e) => {
      if (!tray.isAppExit()) {
        e.preventDefault();
        tray.toggleWin(true)
      }else{

      }
    })
}

const shouldQuit = app.makeSingleInstance((commandLine, workingDirectory) => {
  // Someone tried to run a second instance, we should focus our window.
  if (mainWindow) {
    if (mainWindow.isMinimized()) mainWindow.restore();
    if (!mainWindow.isVisible()) mainWindow.show();
    mainWindow.focus()
  }
});

if (shouldQuit) {
  app.quit()
}

// This method will be called when Electron has finished
app.on('ready', createWindow);

// Quit when all windows are closed.
app.on('window-all-closed', function () {
    // On OS X it is common for applications and their menu bar
    if (process.platform !== 'darwin') {
      app.quit();
    }
});

app.on('activate', function () {
    if (mainWindow === null) {
        createWindow()
    }
});

