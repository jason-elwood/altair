//
//  NPC.swift
//  Altair
//
//  Created by Jason Elwood on 8/5/16.
//  Copyright © 2016 Jason Elwood. All rights reserved.
//

import Foundation

protocol NpcProtocol {
    func speak()
    func getName() -> String
}

var activeNpc:NpcProtocol?

struct Npc:NpcProtocol {
    let name: String?
    let npcId: Int?
    var spokenTo: Bool?
    
    func getName() -> String {
        if let npcName = name {
            return npcName
        } else {
            return "Name"
        }
    }
    func speak() {
        // TODO: Add dialogue to npc instances and call speak.
    }
}

var tavernKeeper = Npc(
    name: "Scheeshc",
    npcId:  0,
    spokenTo: false
)

var ned = Npc(
    name: "Ned",
    npcId: 1,
    spokenTo: false
)

let npcs:[NpcProtocol] = [tavernKeeper, ned]

func npcReply(bodyRowsObj: Array<String>, recipient: String) {
    var bodyRows = bodyRowsObj
    let recipient = recipient.lowercased()
    if recipient.range(of: "scheeshc") != nil {
        activeNpc = tavernKeeper
        bodyRows.append("Scheeshc: Hi there, stranger.  What's your name?")
        bodyRows.append("Scheeshc: \(recipient), huh.  Haven't seen you around here.")
        bodyRows.append("Scheeshc: If you're looking for work, the guy to talk to is Ned over there.")
        bodyRows.append("Scheeshc: He's always got work for travelors.  See ya around.")
        tavernKeeper.spokenTo = true
    } else if recipient.range(of: "ned") != nil {
        bodyRows.append("Ned: What do you want?")
        bodyRows.append("Ned: Work? I always have work.  How do I know I can trust you?")
        bodyRows.append("Ned: Okay, you look harmless enough.")
        bodyRows.append("Ned: I'll give you 20 gold if you can figure out who or what's been killing my cattle.")
        bodyRows.append("Ned: Travel east to my farm and see what you can see.  Come back if you find anything.")
        bodyRows.append("Ned: New quest: Who's Killing Ned's Cows?")
    } else {
        bodyRows.append("There's no one here by that name.")
    }
}

