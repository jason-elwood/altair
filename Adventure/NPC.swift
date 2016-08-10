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

let tavernKeeper = Npc(
    name: "Scheeshc",
    npcId:  0
)

let ned = Npc(
    name: "Ned",
    npcId: 1
)

let npcs:[NpcProtocol] = [tavernKeeper, ned]

func npcReply( recipient: String) {
    let recipient = recipient.lowercaseString
    if recipient.rangeOfString("scheeshc") != nil {
        activeNpc = tavernKeeper
        bodyRows.append("You should talk to Ned over there.  He's always got work for travelors.")
    } else if recipient.rangeOfString("ned") != nil {
        bodyRows.append("I got some work for ya.")
    } else {
        bodyRows.append("There's no one here by that name.")
    }
}

