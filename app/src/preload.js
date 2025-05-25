// See the Electron documentation for details on how to use preload scripts:
// https://www.electronjs.org/docs/latest/tutorial/process-model#preload-scripts

// const { contextBridge, ipcRenderer } = require('electron');
//const Store = require('./electron-store');

// const store = new Store();

//console.log("preload works")

// contextBridge.exposeInMainWorld('electronAPI', {
//   getMoney: () => store.get('money'),
//   setMoney: (value) => store.set('money', value),
//   getUserDataPath: () => ipcRenderer.invoke('get-user-data-path')
// });


//const { ipcRenderer } = require("electron");



const { contextBridge, ipcRenderer } = require("electron");
//const storage = new store()
// const API = {
//     get_money: () => ipcRenderer.invoke('get_storage'),
//     set_money: (value) => ipcRenderer.invoke('set_storage', value),
// }


contextBridge.exposeInMainWorld("api", {
    get_money: () => ipcRenderer.invoke('get_storage'),
    set_money: (value) => ipcRenderer.invoke('set_storage', value),
});

// const { contextBridge, ipcRenderer } = require('electron');
// const Store = require('./electron-store');

// const store = new Store();

console.log("preload works")

// contextBridge.exposeInMainWorld('electronAPI', {
//   getMoney: () => store.get('money'),
//   setMoney: (value) => store.set('money', value),
//   getUserDataPath: () => ipcRenderer.invoke('get-user-data-path')
// });
