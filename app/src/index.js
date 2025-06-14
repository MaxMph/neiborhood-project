const { app, BrowserWindow, ipcMain } = require('electron');
const path = require('node:path');

const Store = require('electron-store');
//const { useRef } = require('react');
const store = new Store();
//import Store from 'electron-store';

//import music from "./First Project!!!!!!!.wav"
var sound_player = require('play-sound')(opts = {});
const music = "./First Project!!!!!!!.wav";

// Handle creating/removing shortcuts on Windows when installing/uninstalling.
if (require('electron-squirrel-startup')) {
  app.quit();
}

const createWindow = () => {
  // Create the browser window.
  const mainWindow = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      preload: path.join(__dirname,'preload.js'),
    },
  });

  // const store = new Store();
  // store.set('example', 'hello world');
  // console.log(store.get('example'));

  // and load the index.html of the app.
  mainWindow.loadFile(path.join(__dirname, 'grid_test.html'));

  // Open the DevTools.
  //mainWindow.webContents.openDevTools();

  //background_music();
};


// Provide value to renderer

ipcMain.handle('get_storage', () => {
  //console.log("get");
  return store.get('money', 0); // default to 0
});

// Receive new number from renderer and store it
ipcMain.handle('set_storage', (event, value) => {
  //console.log("set");
  store.set('money', value);
  //console.log(store.get('money', 0));
});

ipcMain.handle('set_notes', (event, value) => {
  //console.log("notes set");
  store.set('notes', value);
})

ipcMain.handle('get_notes', () => {
  //console.log("get notes");
  return store.get('notes', "");
});

ipcMain.handle('set_used_ids', (event, value) => {
  console.log("set id");
  store.set('ids', value);
})

ipcMain.handle('get_used_ids', () => {
  console.log("get ids");
  return store.get('ids', 0); // default to 0
});

ipcMain.handle('set_sell_ids', (event, value) => {
  //console.log("set id");
  store.set('sell_ids', value);
})

ipcMain.handle('get_sell_ids', () => {
  //console.log("get ids");
  return store.get('sell_ids', []); // default to 0
});



//function background_music() {
  //music = new Audio("./First Project!!!!!!! cut 1.mp3");
  //music = new Audio(music);
  //music.play();

//   sound_player.play('./First Project!!!!!!! cut 1.mp3', function(err){
//   if (err) throw err
//   })
//   console.log("music");
// }


// This method will be called when Electron has finished
// initialization and is ready to create browser windows.
// Some APIs can only be used after this event occurs.
app.whenReady().then(() => {
  createWindow();

  // On OS X it's common to re-create a window in the app when the
  // dock icon is clicked and there are no other windows open.
  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) {
      createWindow();
    }
  });
});

// Quit when all windows are closed, except on macOS. There, it's common
// for applications and their menu bar to stay active until the user quits
// explicitly with Cmd + Q.
app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit();
  }
});

// In this file you can include the rest of your app's specific main process
// code. You can also put them in separate files and import them here.

