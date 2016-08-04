//
//  MoltenFields.swift
//  Altair
//
//  Created by Jason Elwood on 7/29/16.
//  Copyright © 2016 Jason Elwood. All rights reserved.
//

import Foundation

class MoltenFields: NSObject, MapProtocol {
    
    //static let sharedInstance = MoltenFields()
    
    override init() {
        super.init()
    }
    
    let name = "Molten Fields"
    let city = "Valerion"
    let zoneId = 111
    
    // npcs
    let tavernKeeper: [String:AnyObject] =
        ["name":"Scheeshc",
         "about":"",
         "questgiver":false,
         "says":["Hello, stranger.  What's your name?",
            "Greetings, there.  You should talk to Ned over there." +
            "He always has work for out-of-towners like you.",
            "Things are tough around here these days.",
            "Things are looking up around here, thanks to your help."]]
    let questGiver: [String:AnyObject]      = ["name":"Ned",
                                               "about":"",
                                               "questgiver":true,
                                               "says":["Who are you?",
                                                "Well now, I'm guessing since you're new around here, you're looking to earn some gold.  I have a farm just east of here.  Something's been killing my cattle lately.  Find out what it is and take care of it, and I'll give you 50 gold.",
                                                "You gonna take figure out what's killing my cows?",
                                                "Nice work, guy.  Here's your gold.  If you want to get your hands on some real gold, head south to Valerion.  You can travel there by typing 'travel valerion' in the console.  See ya around.",
                                                "I don't have any work for you."]]
    
    // array of npcs
    var npcs: [Dictionary<String, AnyObject>]                   = [ ]
    
    // other vars
    let id: Int         = 0
    
    func initializeLocation(name: String) {
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
            if recipient.rangeOfString(String(npcs[npc]["name"])) != nil {
                return (true, "You may talk to this person.")
            }
        }
        //        for npc in 0..<npcs.count {
        //            if (recipient.rangeOfString(String(npcs[npc]["name"])) != nil) {
        //                //let speach: String
        //                return (true, npcs[npc]["says"]![0])
        //            }
        //        }
        
        return (false, "That person is not near you.")
    }
    
    func areaCheck() {
        bodyRows.append("")
        bodyRows.append(name)
        bodyRows.append(createHorizLine())
        bodyRows.append("You are in a rocky field.  In the distance there is a massive active volcano.")
        bodyRows.append("The tavern keeper, \(tavernKeeper["name"]!), is busy pouring a drink.")
        bodyRows.append("There is a man of interest named \(questGiver["name"]!), in a chair at the far end of the tavern.")
        system("clear")
        refreshUI()
        
    }
    
}