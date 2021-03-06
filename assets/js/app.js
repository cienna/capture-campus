// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

import socket from "./socket"

import Vue from 'vue'
import MyApp from "../components/my-app.vue"

// Create the main component
Vue.component('my-app', MyApp)

// And create the top-level view model:
new Vue({
  el: '#app',
  render(createElement) {
    return createElement(MyApp, {})
  }
});

var info = document.getElementById("info");
var ulat;
var ulong;

function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.watchPosition(showPosition);
    } else {
        info.innerHTML = "Geolocation is not supported by this browser.";}
    }

function showPosition(position) {
    ulat = position.coords.latitude;
    ulong = position.coords.longitude;
    info.innerHTML = "tracking location";
}

// function getLocattion() {
//   if (navigator.geolocation) {
//     navigator.geolocation.watchPosition(setuserloc);
//   } else {
//     info.innerHTML = "Geolocation is not supported by this browser";
//   }
// }
//
// function setuserloc(position) {
//   ulat = position.coords.latitude;
//   ulong = position.coords.longitude;
//   info.innerHTML = "tracking location"
// }

$(getLocattion);
