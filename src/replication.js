import {
    ReplicationClient
} from 'replication-client-js';

import {
    ProtocolDefinition
} from './mech.js';

class Log {
    log(x) {
        console.log('log: ' + x);
    }
}

const host = 'ws://127.0.0.1:32001';
const log = new Log();

let c = new ReplicationClient(host, ProtocolDefinition, (entities) => {
    app.ports.replicationToElm.send("Updated");
}, log);

console.log('c', c);
