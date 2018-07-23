import {
    Elm
} from './main.js';
import {
    App
}
from './replication.js'

var node = document.getElementById('main');
var elmApp = Elm.Main.embed(node);

var app = new App(elmApp);
