import {
    ReplicationClient
} from '@imverse/replication-client-js';


import {
    calculateEntityHash
} from '@imverse/replication-client-js';

import {
    ProtocolDefinition
} from './mech.js';

class Log {
    log(x) {
        console.log('log: ' + x);
    }
}

const host = 'ws://23.236.62.254:32001';
const log = new Log();

/**   A Cache for all entity types */
class DefinitionCache {
    constructor(protocolDefinition) {
        this.protocolDefinition = protocolDefinition;
        this._protocolDefinitionChanged();
    }

    _populateEntityTypeHash(typeHash) {
        for (let entityTypeName of Object.keys(
                this.protocolDefinition.definition.entities)) {
            const entityTypeDefinition =
                this.protocolDefinition.definition.entities[entityTypeName];
            const hash = calculateEntityHash(entityTypeName);
            this.entityTypeCache[hash] = {
                definition: entityTypeDefinition,
                name: entityTypeName
            };
        }
    }

    _protocolDefinitionChanged() {
        this.entityTypeCache = {};
        this._populateEntityTypeHash();
    }

    lookup(typeHash) {
        const entityTypeDefinition = this.entityTypeCache[typeHash];
        return entityTypeDefinition;
    }
}

class App {
    constructor(elmApp) {
        this.cache = new DefinitionCache(ProtocolDefinition);
        this.connection = new ReplicationClient(host, ProtocolDefinition,
            (entities) => this._callback(entities),
            log);

        this.elmApp = elmApp;
    }


    _isPrimitiveValue(name) {
        return name === 'int' || name === 'string';
    }

    _getBaseComplexTypeFields(componentFieldStructureDefinition, name) {
        switch (name) {
            case 'Piot.Basal.Vector3f':
                return [{
                        name: 'x',
                        type: 'float'
                    },
                    {
                        name: 'y',
                        type: 'float'
                    },
                    {
                        name: 'z',
                        type: 'float'
                    },
                ];
            case 'Piot.Basal.Quaternion':
                return [{
                        name: 'a',
                        type: 'int'
                    }, {
                        name: 'b',
                        type: 'int'
                    },
                    {
                        name: 'c',
                        type: 'int'
                    }, {
                        name: 'mode',
                        type: 'int'
                    }
                ];

            default:
                const fields = componentFieldStructureDefinition.fields;
                if (fields) {
                    return fields;
                } else {
                    console.log('missing for type:', name);
                }
        }
    }

    _callback(entities) {
        let entitiesDto = [];
        for (let entityId of Object.keys(entities)) {
            const entity = entities[entityId];
            const typeDefinition = this.cache.lookup(entity.type);
            let componentFieldsDto = [];
            let entityPosition = null;
            for (let componentFieldDefinition of typeDefinition.definition.fields) {
                let componentTypeDefinitionName = componentFieldDefinition.component;
                let componentTypeDefinition =
                    ProtocolDefinition.definition.components[componentTypeDefinitionName];
                let componentFieldDto = {
                    name: componentFieldDefinition.name,
                    typeName: componentTypeDefinitionName,
                    fields: []
                };
                for (let componentFieldStructure of componentTypeDefinition.fields) {
                    let componentData = entity.data[componentFieldDefinition.name];
                    let componentFieldStructureDefinitionName =
                        componentFieldStructure.type;
                    let fakeComponentFieldData = {
                        name: componentFieldStructure.name,
                        typeName: componentFieldStructureDefinitionName
                    };
                    let fieldDtos = [];
                    if (this._isPrimitiveValue(componentFieldStructureDefinitionName)) {
                        fieldDtos.push({
                            name: componentFieldStructure.name,
                            type: componentFieldStructureDefinitionName,
                            value: componentData[componentFieldStructure.name]
                        });
                    } else {
                        let componentFieldStructureDefinition =
                            ProtocolDefinition.definition
                            .components[componentFieldStructureDefinitionName];
                        let fields = this._getBaseComplexTypeFields(
                            componentFieldStructureDefinition,
                            componentFieldStructureDefinitionName);
                        let fieldsWithValues = [];
                        const structureData = componentData[componentFieldStructure.name];
                        if (componentFieldStructure.name === 'position') {
                            const position = {
                                x: structureData.x,
                                y: structureData.y,
                                z: structureData.z
                            };
                            entityPosition = position;
                        }
                        for (let field of fields) {
                            let fieldDto = {
                                name: field.name,
                                type: field.type,
                                value: structureData[field.name]
                            };
                            fieldsWithValues.push(fieldDto);
                        }
                        fieldDtos = fieldDtos.concat(fieldsWithValues);
                    }

                    fakeComponentFieldData.properties = fieldDtos;
                    componentFieldDto.fields.push(fakeComponentFieldData);
                }
                componentFieldsDto.push(componentFieldDto);
            }

            let entityDto = {
                id: parseInt(entityId),
                typeName: typeDefinition.name,
                components: componentFieldsDto,
                position: entityPosition
            };
            entitiesDto.push(entityDto);
        }
        const root = {
            entities: entitiesDto
        };
        this.elmApp.ports.replicationToElm.send(root);
    }

}

export {
    App
};
