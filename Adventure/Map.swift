//
//  Map.swift
//  Adventure
//
//  Created by Jason Elwood on 7/27/16.
//  Copyright © 2016 Jason Elwood. All rights reserved.
//

import Foundation

var tryton: Location            = Location()
var valerion: Location          = Location()

// Tryton locations
var stoicTavern: Location       = Location()
var mightyWeaponShop: Location  = Location()

// Valeriono locations
var moltenFields: Location      = Location()

var zones: [LocationProtocol]       = []
var locations: [LocationProtocol]   = []

var currentZone:     LocationProtocol?
var currentLocation: LocationProtocol?

var currentZoneId: Int?
var currentLocationId: Int?

let IN_ZONE_NO_LOCATION: Int = 0

enum ZoneIDs {
    static let TRYTON_ID            = 0
    static let VALERION_ID          = 1
}

enum LocationIDs {
    static let STOICTAVERN_ID       = 100
    static let MIGHTY_WEAPONSHOP_ID = 101

    static let MOLTENFIELDS_ID      = 201
}

var worldMap = [
    [-1, -1, -1, -1, -1, -1],
    [-1,  0,  1,  2, -1, -1],
    [-1,  3,  4,  5, -1, -1],
    [-1,  6,  7,  8,  9, -1],
    [-1, -1, -1, -1, -1, -1]
]

func initializeMap(bodyRowsObj: Array<String>) {
    tryton.initLoc(name: "Tryton", zoneId: ZoneIDs.TRYTON_ID, bodyRows: bodyRowsObj, subLoc: [stoicTavern], locType: LocationTypes.ZONE_TYPE)
    tryton.setDescription(descr: [
    "Places of interest: tavern, shop",
    "Tryton is a small town with a tavern, shop and other places of interest.",
    "Tryton's outlands are plagued by evil ooze, bats, wolves, and other scourge.",
    "Samuel runs the tavern and will often offer gold for work.",
    "Studds operates the store and, for a price, can offer you better weapons as you continue on your journey.",
    "Valerion is to the east. Travel there when you are ready, or at your peril.",
        ])
    stoicTavern.initLoc(name: "Stoic Tavern", zoneId: LocationIDs.STOICTAVERN_ID, bodyRows: bodyRowsObj, subLoc: [], locType: LocationTypes.TAVERN_TYPE)
    stoicTavern.setNpcs(npcs: [samuel, ned])
    stoicTavern.canTalk = true
    stoicTavern.setDescription(descr: [
        "You are in a tavern.  There are various people scattered througout.",
        "The tavern keeper, \(samuel.getName()), is busy pouring a drink.",
        "There is a man of interest named \(ned.getName()), in a chair at the far end of the tavern."
        ])

    mightyWeaponShop.initLoc(name: "Mighty Weapon Shop", zoneId: LocationIDs.MIGHTY_WEAPONSHOP_ID, bodyRows: bodyRowsObj, subLoc: [], locType: LocationTypes.STORE_TYPE)
    mightyWeaponShop.setNpcs(npcs: [studds])
    mightyWeaponShop.canTalk = true
    mightyWeaponShop.setDescription(descr: [
        "You are in the best (and only) weapon shop in Tryton!",
        "Hollar for old Studds if you need somethin' and spend your gold wisely!",
    ])
    
    valerion.initLoc(name: "Valerion", zoneId: ZoneIDs.VALERION_ID, bodyRows: bodyRowsObj, subLoc: [moltenFields], locType: LocationTypes.ZONE_TYPE)
    moltenFields.initLoc(name: "Molten Fields", zoneId: LocationIDs.MOLTENFIELDS_ID, bodyRows: bodyRowsObj, subLoc: [], locType: LocationTypes.STORE_TYPE)
    moltenFields.setNpcs(npcs: [])
    moltenFields.canTalk = false
    moltenFields.setDescription(descr: [
        "You have reached the summit of the Molten Mountains and are looking down at a pool.",
        "The pool is on fire and in the far distance is an active volcano.",
        "There is a cave opening several hundred meters to the east.",
        "Evidence that someone has recently broken camp here is evident.  Perhaps you could investigate?"
        ])
    
    zones.append(tryton)
    zones.append(valerion)
    locations.append(stoicTavern)
    locations.append(mightyWeaponShop)
    locations.append(moltenFields)
    tryton.subLocations.append(stoicTavern)
    tryton.subLocations.append(mightyWeaponShop)
    
    currentZone = tryton
    currentLocation = stoicTavern
    currentZoneId = ZoneIDs.TRYTON_ID
    currentLocationId = LocationIDs.STOICTAVERN_ID
}

func setZone(zoneId: Int) {
    currentZoneId = zoneId
    
    if zoneId == ZoneIDs.TRYTON_ID {
        currentZone = tryton
    } else if zoneId == ZoneIDs.VALERION_ID {
        currentZone = valerion
    }
}

func setLocation(locid: Int) {
    currentLocationId = locid
    if locid == IN_ZONE_NO_LOCATION {
        currentLocation = nil
    }
    if locid == LocationIDs.STOICTAVERN_ID {
        currentLocation = stoicTavern
    } else if locid == LocationIDs.MIGHTY_WEAPONSHOP_ID {
        currentLocation = mightyWeaponShop
    } else if locid == LocationIDs.MOLTENFIELDS_ID {
        currentLocation = moltenFields
    }
}

/**
 - parameter locationid: Takes any location id.  
 - returns: location - the current location.
 */
func getLocation(locationid: Int) -> LocationProtocol {
    for locs in 0..<locations.count {
        let loc: LocationProtocol = locations[locs]
        if loc.getZoneId() == locationid {
            return loc
        }
    }
    return locations[0]
}

func areaCheck(appWidth: Int) -> [String] {
    var bodyRows:[String] = []
    bodyRows.append("")
    if currentLocationId == ZoneIDs.TRYTON_ID {
        bodyRows.append(zones[0].getName())
        bodyRows.append(createHorizLine(appWidth: appWidth))
        for line in tryton.getDescription() {
            bodyRows.append(line)
        }
    }
    if currentLocationId == ZoneIDs.VALERION_ID {
        bodyRows.append(zones[1].getName())
        bodyRows.append(createHorizLine(appWidth: appWidth))
        for line in valerion.getDescription() {
            bodyRows.append(line)
        }
    }
    if currentLocationId == LocationIDs.STOICTAVERN_ID {
        bodyRows.append(locations[0].getName())
        bodyRows.append(createHorizLine(appWidth: appWidth))
        for line in stoicTavern.getDescription() {
            bodyRows.append(line)
        }
    }
    if currentLocationId == LocationIDs.MIGHTY_WEAPONSHOP_ID {
        bodyRows.append(locations[1].getName())
        bodyRows.append(createHorizLine(appWidth: appWidth))
        for line in mightyWeaponShop.getDescription() {
            bodyRows.append(line)
        }
    } else if currentLocationId == LocationIDs.MOLTENFIELDS_ID {
        bodyRows.append(locations[2].getName())
        bodyRows.append(createHorizLine(appWidth: appWidth))
        for line in moltenFields.getDescription() {
            bodyRows.append(line)
        }
    }
    //print("\u{001B}[2J")
    return bodyRows
}

func enterToLocation(string: String) -> (canEnter: Bool, location: LocationProtocol, message: String) {
    let string = string.lowercased()
    if string.range(of: "tavern") != nil {
        for location in (currentZone?.getSubLocations())! {
            if location.getLocationType() == LocationTypes.TAVERN_TYPE {
                return (true, stoicTavern, "You enter Stoic Tavern.")
            }
        }
    }
    if string.range(of: "shop") != nil {
        for location in (currentZone?.getSubLocations())! {
            if location.getLocationType() == LocationTypes.STORE_TYPE {
                return (true, mightyWeaponShop, "You enter Mighty Weapon Shop.")
            }
        }
    }
    return (false, stoicTavern, "There was an error!")
}

func travelToLocation(string: String) -> (canTravel: Bool, zone: Int, location: Int, message: String) {
    
    var zoneId: Int = -1
    
    let string = string.lowercased()
    if string.range(of: "valerion") != nil {
        zoneId = valerion.getZoneId()
        if zoneId == currentZoneId {
            return (false, zoneId, -1, "You are already in Valerion.")
        }
        for x in 0..<worldMap.count {
            for y in 0..<worldMap[x].count {
                if worldMap[x][y] == zoneId {
                    if worldMap[x - 1][y] == currentZone!.getZoneId() ||
                        worldMap[x + 1][y] == currentZone!.getZoneId() ||
                        worldMap[x][y - 1] == currentZone!.getZoneId() ||
                        worldMap[x][y + 1] == currentZone!.getZoneId() {
                        setZone(zoneId: 1)
                        setLocation(locid: 101)
                        return (true, zoneId, 101, "Welcome to Valerion.")
                    }
                }
            }
        }
    } else if string.range(of: "tryton") != nil {
        zoneId = tryton.getZoneId()
        if zoneId == currentZoneId {
            return (false, zoneId, -1, "You are already in Tryton.")
        }
        for x in 0..<worldMap.count {
            for y in 0..<worldMap[x].count {
                if worldMap[x][y] == zoneId {
                    if worldMap[x - 1][y]  == currentZoneId ||
                        worldMap[x + 1][y] == currentZoneId ||
                        worldMap[x][y - 1] == currentZoneId ||
                        worldMap[x][y + 1] == currentZoneId {
                        setZone(zoneId: 0)
                        setLocation(locid: 100)
                        return (true, zoneId, 100, "Welcome to Tryton")
                    }
                }
            }
        }
    } 
    return (false, zoneId, -1, "You are not able to travel there.")
}

func talkTo(recipient: String) -> Bool {
    return currentLocation!.getCanTalk(recipient: recipient)
}




