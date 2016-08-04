//
//  Tryton.swift
//  Altair
//
//  Created by Jason Elwood on 7/29/16.
//  Copyright © 2016 Jason Elwood. All rights reserved.
//

import Foundation

class Tryton: NSObject, MapProtocol {
    
    let stoicTavern: MapProtocol = StoicTavern()
    
    let name = "Tryton"
    var places: [MapProtocol] = []
    var connectors: [MapProtocol] = []
    
    let zoneId = 0
    
    override init() {
        places.append(stoicTavern)
        stoicTavern.initializeLocation(playerName)
    }
    
    func initializeLocation(name: String) {
        //
    }
    
    func getName() -> String {
        return name
    }
    
    func getLocations() -> [MapProtocol] {
        return places
    }
    
    func getConnectors() -> [MapProtocol] {
        return connectors
    }
    
    func getZoneId() -> Int {
        return zoneId
    }
    
    func getNPCs() -> [Dictionary<String, AnyObject>] {
        return []
    }
    
    func canTalk(recipient: String) -> (Bool, String) {
        return (false, "")
    }
    
    func areaCheck() {
        
        if currentLocation == 101 {
            places[0].areaCheck()
        } else if currentLocation == 102 {
            places[1].areaCheck()
        }
        
    }
    
}