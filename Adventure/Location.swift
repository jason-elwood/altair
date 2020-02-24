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
}

extension LocationProtocol {
    func getLocations() -> [LocationProtocol] {
        return []
    }
}

class Location: NSObject, LocationProtocol {
    
    var name:       String?
    var zoneId:     Int?
    var npcs:       [NpcProtocol]?
    var descr:      [String]?
    var canTalk:    Bool?
    var bodyRows:   Array<String> = []
    
    func initLoc(name: String, zoneId: Int, bodyRows: Array<String>) {
        self.name = name
        self.zoneId = zoneId
        self.bodyRows = bodyRows
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
        if canTalk! {
            npcReply(bodyRowsObj: bodyRows, recipient: recipient)
        }
        return canTalk!
    }
}




