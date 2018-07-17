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
        const dtoEntities = [{
            id: 2,
            typeName: "AttackMech",
            components: [{
                typeName: "Vector3f",
                fields: [{
                        name: "body",
                        structure: {
                            typeName: "Position",
                            fields: [{
                                    name: "x",
                                    value: 1.2
                                },
                                {
                                    name: "y",
                                    value: 4.2
                                }
                            ]
                        }
                    },
                    {
                        name: "rotation",
                        structure: {
                            typeName: "Oritentation",
                            fields: [{
                                    name: "x",
                                    value: 1.2
                                },
                                {
                                    name: "y",
                                    value: 4.2
                                }
                            ]
                        }
                    }
                ]
            }]
        }, {
            id: 41,
            typeName: "Ground",
            components: [{
                typeName: "GroundBaseComponent",
                fields: [{
                    name: "TileInfo",
                    structure: {
                        typeName: "TileGfx",
                        fields: [{
                            name: "tileIndex",
                            value: 99
                        }]
                    }
                }]
            }]
        }];

        const root = {
            entities: dtoEntities
        }
        app.ports.replicationToElm.send(root);
    },
    log);

console.log('c', c);
