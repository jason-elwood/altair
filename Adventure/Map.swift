//
//  Map.swift
//  Adventure
//
//  Created by Jason Elwood on 7/27/16.
//  Copyright © 2016 Jason Elwood. All rights reserved.
//

import Foundation

class Map: NSObject {

    //var stoicTavern: MapProtocol = StoicTavern()
    //var moltenFields: MapProtocol = MoltenFields()

    var tryton: MapProtocol = Tryton()
    var valerion: MapProtocol = Valerion()

    var zones: [MapProtocol] = []
    var locations: [[MapProtocol]] = []

    var worldMap = [
        [-1, -1, -1, -1, -1, -1],
        [-1, 0, 1, 2, -1, -1],
        [-1, 3, 4, 5, -1, -1],
        [-1, 6, 7, 8, 9, -1],
        [-1, -1, -1, -1, -1, -1]
    ]
    
    override init() {
        super.init()
    }

    func initializeMap() {
        //stoicTavern.initializeLocation(playerName)
        
        zones.append(tryton)
        zones.append(valerion)
        locations.append(tryton.getLocations())
        locations.append(valerion.getLocations())
    }

    /**
     - parameter locationid: Takes any location id.  The method will
     get the zone from the main program.
     - returns: location - the current location.
     */
    func getLocation(locationid: Int) -> MapProtocol {
        for locs in 0..<locations[currentZone].count {
            let loc: MapProtocol = locations[currentZone][locs]
            if loc.getZoneId() == locationid {
                return loc
            }
        }
        return locations[0][0]
    }
    
    func areaCheck() {
        
        if currentZone == 0 {
            zones[0].areaCheck()
        } else if currentZone == 1 {
            zones[1].areaCheck()
        }
        
    }

    func travelToLocation(string: String) -> (canTravel: Bool, zone: Int, location: Int) {
        
        //let zone: MapProtocol = zones[currentZone]
        var zoneId: Int = -1
        //let locs = zone.getLocations()
        //let locs = zone.getConnectors()
        
        if string.rangeOfString("valerion") != nil {
            zoneId = valerion.getZoneId()
            
            for x in 0..<worldMap.count {
                for y in 0..<worldMap[x].count {
                    if worldMap[x][y] == zoneId {
                        if worldMap[x - 1][y] == currentZone ||
                           worldMap[x + 1][y] == currentZone ||
                           worldMap[x][y - 1] == currentZone ||
                           worldMap[x][y + 1] == currentZone {
                            return (true, zoneId, 111)
                        }
                    }
                }
            }
        } else if string.rangeOfString("tryton") != nil {
            zoneId = tryton.getZoneId()
            
            for x in 0..<worldMap.count {
                for y in 0..<worldMap[x].count {
                    if worldMap[x][y] == zoneId {
                        if worldMap[x - 1][y] == currentZone ||
                           worldMap[x + 1][y] == currentZone ||
                           worldMap[x][y - 1] == currentZone ||
                           worldMap[x][y + 1] == currentZone {
                            return (true, zoneId, 101)
                        }
                    }
                }
            }
        } 
        return (false, zoneId, -1)
    }
}









