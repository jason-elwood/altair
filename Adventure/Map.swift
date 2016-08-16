//
//  Map.swift
//  Adventure
//
//  Created by Jason Elwood on 7/27/16.
//  Copyright © 2016 Jason Elwood. All rights reserved.
//

import Foundation

var tryton: Location        = Location()
var valerion: Location      = Location()
var stoicTavern: Location   = Location()
var moltenFields: Location  = Location()

var zones: [LocationProtocol]       = []
var locations: [LocationProtocol] = []

var currentZone:     LocationProtocol?
var currentLocation: LocationProtocol?

var currentZoneId: Int?
var currentLocationId: Int?

var worldMap = [
    [-1, -1, -1, -1, -1, -1],
    [-1,  0,  1,  2, -1, -1],
    [-1,  3,  4,  5, -1, -1],
    [-1,  6,  7,  8,  9, -1],
    [-1, -1, -1, -1, -1, -1]
]

func initializeMap() {
    tryton.initLoc("Tryton", zoneId: 0)
    stoicTavern.initLoc("Stoic Tavern", zoneId: 100)
    stoicTavern.setNpcs([tavernKeeper, ned])
    stoicTavern.canTalk = true
    stoicTavern.setDescription([
        "You are in a tavern.  There are various people scattered througout.",
        "The tavern keeper, \(tavernKeeper.getName()), is busy pouring a drink.",
        "There is a man of interest named \(ned.getName()), in a chair at the far end of the tavern."
        ])
    
    valerion.initLoc("Valerion", zoneId: 1)
    moltenFields.initLoc("Molten Fields", zoneId: 101)
    moltenFields.setNpcs([])
    moltenFields.canTalk = false
    moltenFields.setDescription([
        "You have reached the sumit of the Molten Mountains and are looking down at a pool.",
        "The pool is on fire and in the far distance is an active volcano.",
        "There is a cave opening several hundred meters to the east.",
        "Evidence that someone has recently broken camp here is evident.  Perhaps you could investigate?"
        ])
    
    zones.append(tryton)
    zones.append(valerion)
    locations.append(stoicTavern)
    locations.append(moltenFields)
    
    currentZone = tryton
    currentLocation = stoicTavern
    currentZoneId = 0
    currentLocationId = 100
}

func setZone(zoneId: Int) {
    currentZoneId = zoneId
    
    if zoneId == 0 {
        currentZone = tryton
    } else if zoneId == 1 {
        currentZone = valerion
    }
}

func setLocation(locid: Int) {
    currentLocationId = locid
    
    if locid == 100 {
        currentLocation = stoicTavern
    } else if locid == 101 {
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

func areaCheck() {
    
    bodyRows.append("")
    if currentLocationId == 100 {
        bodyRows.append(locations[0].getName())
        bodyRows.append(createHorizLine())
        for line in stoicTavern.getDescription() {
            bodyRows.append(line)
        }
    } else if currentLocationId == 101 {
        bodyRows.append(locations[1].getName())
        bodyRows.append(createHorizLine())
        for line in moltenFields.getDescription() {
            bodyRows.append(line)
        }
    }
    system("clear")
    refreshUI()
}

func travelToLocation(string: String) -> (canTravel: Bool, zone: Int, location: Int) {
    
    var zoneId: Int = -1
    
    let string = string.lowercaseString
    if string.rangeOfString("valerion") != nil {
        zoneId = valerion.getZoneId()
        
        for x in 0..<worldMap.count {
            for y in 0..<worldMap[x].count {
                if worldMap[x][y] == zoneId {
                    if worldMap[x - 1][y] == currentZone!.getZoneId() ||
                        worldMap[x + 1][y] == currentZone!.getZoneId() ||
                        worldMap[x][y - 1] == currentZone!.getZoneId() ||
                        worldMap[x][y + 1] == currentZone!.getZoneId() {
                        setZone(1)
                        setLocation(101)
                        return (true, zoneId, 101)
                    }
                }
            }
        }
    } else if string.rangeOfString("tryton") != nil {
        zoneId = tryton.getZoneId()
        
        for x in 0..<worldMap.count {
            for y in 0..<worldMap[x].count {
                if worldMap[x][y] == zoneId {
                    if worldMap[x - 1][y]  == currentZoneId ||
                        worldMap[x + 1][y] == currentZoneId ||
                        worldMap[x][y - 1] == currentZoneId ||
                        worldMap[x][y + 1] == currentZoneId {
                        setZone(0)
                        setLocation(100)
                        return (true, zoneId, 100)
                    }
                }
            }
        }
    } 
    return (false, zoneId, -1)
}

func talkTo(recipient: String) -> Bool {
    return currentLocation!.getCanTalk(recipient)
}




