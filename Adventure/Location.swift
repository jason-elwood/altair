//
//  Location.swift
//  Altair
//
//  Created by Jason Elwood on 8/5/16.
//  Copyright © 2016 Jason Elwood. All rights reserved.
//

import Foundation

protocol LocationProtocol {
    func setNpcs(npcs: [NpcProtocol])
    func setDescription(descr: [String])
    func setCanTalk(canTalk: Bool)
    func getDescription() -> [String]
    func getLocations() -> [LocationProtocol]
    func getName() -> String
    func getZoneId() -> Int
    func getNPCs() -> [NpcProtocol]
    func getCanTalk(recipient: String) -> Bool
    func setLocationType(locType: Int)
    func getLocationType() -> Int
    func getSubLocations() -> [LocationProtocol]
}

extension LocationProtocol {
    func getLocations() -> [LocationProtocol] {
        return []
    }
}

enum LocationTypes {
    static let ZONE_TYPE            = 0
    static let TAVERN_TYPE          = 1
    static let STORE_TYPE           = 2
}

class Location: NSObject, LocationProtocol {
    
    var name:       String?
    var zoneId:     Int?
    var npcs:       [NpcProtocol]?
    var descr:      [String]?
    var canTalk:    Bool?
    var bodyRows:   Array<String> = []
    var subLocations: [LocationProtocol] = []
    var locationType: Int?
    
    func initLoc(name: String, zoneId: Int, bodyRows: Array<String>, subLoc: [LocationProtocol], locType: Int) {
        self.name = name
        self.zoneId = zoneId
        self.bodyRows = bodyRows
        self.subLocations = subLoc
        self.locationType = locType
    }

    func setLocationType(locType: Int) {

    }

    func getLocationType() -> Int {
        return locationType!
    }
    
    func setDescription(descr: [String]) {
        self.descr = descr
    }
    
    func setNpcs(npcs: [NpcProtocol]) {
        self.npcs = npcs
    }
    
    func setCanTalk(canTalk: Bool) {
        self.canTalk = canTalk
    }
    
    func getName() -> String {
        return self.name!
    }
    
    func getZoneId() -> Int {
        return self.zoneId!
    }
    
    func getDescription() -> [String] {
        return self.descr!
    }
    
    func getNPCs() -> [NpcProtocol] {
        return npcs!
    }
    
    func getCanTalk(recipient: String) -> Bool {
        return canTalk!
    }

    func getSubLocations() -> [LocationProtocol] {
        return subLocations
    }
}




