//
//  Quests.swift
//  Altair
//
//  Created by Jason Elwood on 8/9/16.
//  Copyright © 2016 Jason Elwood. All rights reserved.
//

import Foundation

enum QuestIDs {
    static let QUESTLESS            = -1
    static let KILLSPIDERS_ID       = 0
    static let KILLOOZES_ID         = 1
    static let TRAVELNORTH_ID       = 2
    static let KILLWOLFS_ID         = 3
    static let KILLLANDSHARKS_ID    = 4
    static let TRAVELEAST_ID        = 5
}

struct Quest: Decodable {
    let name: String?   // The name of the quest.
    let id: Int?
    let reqID: Int?     // The quest requirement id. Ex: monsterID
    var number: Int?    // Number of requirement id's needed to complete.
    let exp: Int?       // Experience earned once complete.
    let active: Bool?
    let completed: Bool?
}

let killSpiders     = Quest(name: "Kill 5 spiders", id: QuestIDs.KILLSPIDERS_ID, reqID: MonsterIDs.SPIDER_ID, number: 5, exp: 25, active: false, completed: false)
let killOozes       = Quest(name: "Kill 3 Oozes", id: QuestIDs.KILLOOZES_ID, reqID: MonsterIDs.OOZE_ID, number: 3, exp: 25, active: false, completed: false)
let travelNorth     = Quest(name: "Travel north", id: QuestIDs.TRAVELNORTH_ID, reqID: 0, number: 0, exp: 25, active: false, completed: false)

let killWolfs       = Quest(name: "Kill 5 wolves.", id: QuestIDs.KILLWOLFS_ID, reqID: MonsterIDs.WOLF_ID, number: 5, exp: 50, active: false, completed: false)
let killLandsharks = Quest(name: "Kill 3 land sharks", id: QuestIDs.KILLLANDSHARKS_ID, reqID: MonsterIDs.LANDSHARK_ID, number: 3, exp: 50, active: false, completed: false)
let travelEast      = Quest(name: "Travel east", id: QuestIDs.TRAVELEAST_ID, reqID: 0, number: 0, exp: 50, active: false, completed: false)

var zoneOneQuests = [killSpiders, travelNorth, killOozes]
var zoneTwoQuests = [killWolfs, killLandsharks, travelEast]

func getQuest(forNPC: Int) -> Quest {
    switch forNPC {
    case 0:
        return zoneOneQuests[0]
    case 1:
        return zoneOneQuests[1]
    default:
        return zoneOneQuests[Int(arc4random_uniform(UInt32(zoneOneQuests.count)))]
    }
}
