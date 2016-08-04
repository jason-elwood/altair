//
//  StoicTavern.swift
//  Altair
//
//  Created by Jason Elwood on 7/28/16.
//  Copyright © 2016 Jason Elwood. All rights reserved.
//

import Foundation

class StoicTavern: NSObject, MapProtocol {
    
    //static let sharedInstance = StoicTavern()
    
    let name = "The Stoic Tavern"
    let city = "Tryton"
    let zoneId = 100
    var playerName = ""
    var tavernKeeperSaysArray: [String] = []
    var questGiverSaysArray: [String] = []
    
    // npcs
    var tavernKeeper: [String:AnyObject] = [:]
    var questGiver: [String:AnyObject] = [:]
    
    // array of npcs
    var npcs: [Dictionary<String, AnyObject>] = []
    
    // other vars
    let id: Int         = 0
    
    override init() {
        super.init()
    }
    
    func initializeLocation(name: String = "Altaira") {
        self.playerName = name
        tavernKeeper["name"] = "Scheeshc"
        tavernKeeper["about"] = ""
        tavernKeeper["questgiver"] = false
        tavernKeeperSaysArray.append("Hello, stranger.  What's your name?")
        tavernKeeperSaysArray.append("\(playerName),huh. You should talk to Ned over there.")
        tavernKeeperSaysArray.append("He always has work for out-of-towners like you.")
        tavernKeeperSaysArray.append("Things are tough around here these days.")
        tavernKeeperSaysArray.append("Things are looking up around here, thanks to your help.")
        tavernKeeper["says"] = tavernKeeperSaysArray
        questGiver["name"] = "Nez"
        questGiver["about"] = ""
        questGiver["questgiver"] = true
        questGiverSaysArray.append("Hello there. I'm guessing since you're new around here,")
        questGiverSaysArray.append("I have a farm east of here.  Something's been killing my cattle lately.")
        questGiverSaysArray.append("I'll give you 50 gold if you can do it take care of what's been doing it.")
        questGiverSaysArray.append("You gonna figure out what's killing my cows?")
        questGiverSaysArray.append("Thanks, friend.  Here's your gold.")
        questGiverSaysArray.append("If you want to get your hands on some real gold, head south to Valerion.")
        questGiver["says"] = questGiverSaysArray
        npcs.append(tavernKeeper)
        npcs.append(questGiver)
        
    }
    
    func getName() -> String {
        return name
    }
    
    func getLocations() -> [MapProtocol] {
        return [self]
    }
    
    func getConnectors() -> [MapProtocol] {
        return [self]
    }
    
    func getZoneId() -> Int {
        return zoneId
    }
    
    func getNPCs() -> [Dictionary<String, AnyObject>] {
        return npcs
    }
    
    func canTalk(recipient: String) -> (Bool, String) {
        for npc in 0..<npcs.count {
            if recipient.rangeOfString(npcs[npc]["name"]! as! String) != nil {
                let speech: String = npcs[npc]["says"]![1] as! String
                return (true, speech)
            }
        }
        
        return (false, "That person doesn't seem to be in your location. Type <look> to see who you can talk to.")
    }
    
    func areaCheck() {
        bodyRows.append("")
        bodyRows.append(name)
        bodyRows.append(createHorizLine())
        bodyRows.append("You are in a tavern.  There are various people scattered througout.")
        bodyRows.append("The tavern keeper, \(tavernKeeper["name"]!), is busy pouring a drink.")
        bodyRows.append("There is a man of interest named \(questGiver["name"]!), in a chair at the far end of the tavern.")
        system("clear")
        refreshUI()
        
    }
    
}