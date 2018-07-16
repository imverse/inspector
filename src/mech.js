/*

Copyright (C) 2018 Imverse. All rights reserved.

*/
export let ProtocolDefinition = {
    "definition": {
        "components": {
            "GroundBase": {
                "fields": [{
                    "name": "tile",
                    "type": "int",
                    "meta": {
                        "method": "IntegerRange",
                        "parameters": [
                            "5",
                            "0",
                        ]
                    }
                }, ]
            },
            "PositionOnly": {
                "fields": [{
                    "name": "position",
                    "type": "Piot.Basal.Vector3f",
                    "meta": {
                        "method": "Vector3f",
                        "parameters": [
                            "24",
                            "2400",
                        ]
                    }
                }, ]
            },
            "Body": {
                "fields": [{
                        "name": "position",
                        "type": "Piot.Basal.Vector3f",
                        "meta": {
                            "method": "Vector3f",
                            "parameters": [
                                "24",
                                "2400",
                            ]
                        }
                    },
                    {
                        "name": "rotation",
                        "type": "Piot.Basal.Quaternion",
                        "meta": {
                            "method": "UnitRotation",
                            "parameters": []
                        }
                    },
                ]
            },
        },
        "entities": {
            "Ground": {
                "fields": [{
                        "name": "body",
                        "component": "PositionOnly",
                    },
                    {
                        "name": "gfx",
                        "component": "GroundBase",
                    },
                ]
            },
            "AttackMech": {
                "fields": [{
                    "name": "body",
                    "component": "Body",
                }, ]
            },
            "SpaceGlider": {
                "fields": [{
                    "name": "body",
                    "component": "Body",
                }, ]
            },
        }
    }
};
