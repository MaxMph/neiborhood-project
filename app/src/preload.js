// See the Electron documentation for details on how to use preload scripts:
// https://www.electronjs.org/docs/latest/tutorial/process-model#preload-scripts

// const { contextBridge, ipcRenderer } = require('electron');
//const Store = require('./electron-store');

// const store = new Store();

console.log("preload works")

// contextBridge.exposeInMainWorld('electronAPI', {
//   getMoney: () => store.get('money'),
//   setMoney: (value) => store.set('money', value),
//   getUserDataPath: () => ipcRenderer.invoke('get-user-data-path')
// });