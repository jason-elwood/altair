//
//  Valerion.swift
//  Altair
//
//  Created by Jason Elwood on 7/29/16.
//  Copyright © 2016 Jason Elwood. All rights reserved.
//

import Foundation

class Valerion: NSObject, MapProtocol {
    
    let moltenFields: MapProtocol = MoltenFields()
    
    let name = "Valerion"
    var places: [MapProtocol] = []
    var connectors: [MapProtocol] = []
    
    let zoneId = 1
    
    override init() {
        places.append(moltenFields)
        moltenFields.initializeLocation(playerName)
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
        
        if currentLocation == 111 {
            places[0].areaCheck()
        } else if currentLocation == 112 {
            places[1].areaCheck()
        }
        
    }
    
}