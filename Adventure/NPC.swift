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
    func getNpcType() -> Int
    func getQuest() -> Int
}

var activeNpc:NpcProtocol?

struct Npc:NpcProtocol {
    let name: String?
    let npcId: Int?
    let npcType: Int?
    var spokenTo: Bool?
    let quest: Int?
    var questAccepted: Bool = false
    var questCompleted: Bool = false
    
    func getName() -> String {
        if let npcName = name {
            return npcName
        } else {
            return "Name"
        }
    }

    func getNpcType() -> Int {
        return npcType ?? NpcType.OTHER
    }

    func getQuest() -> Int {
        return 0
    }
    func speak() {
        // TODO: Add dialogue to npc instances and call speak.
    }
}

enum QuestStatus {
    static let ACTIVE       = 1
    static let COMPLETE     = 2
    static let NONE         = 3
}

enum NpcType {
    static let BARTENDER    = 1
    static let SHOPKEEPER   = 2
    static let OTHER        = 100
}

var samuel = Npc(
    name: "Samuel",
    npcId:  0,
    npcType: NpcType.BARTENDER,
    spokenTo: false,
    quest: QuestIDs.KILLSPIDERS_ID,
    questAccepted: false,
    questCompleted: false
)

var ned = Npc(
    name: "Ned",
    npcId: 1,
    npcType: NpcType.OTHER,
    spokenTo: false,
    quest: QuestIDs.TRAVELNORTH_ID,
    questAccepted: false,
    questCompleted: false
)

var studds = Npc(
    name: "Studds",
    npcId: 2,
    npcType: NpcType.SHOPKEEPER,
    spokenTo: false,
    quest: QuestIDs.QUESTLESS)

let npcs:[NpcProtocol] = [samuel, ned]

func checkQuestCompletion(forNPC npcID: Int) -> Bool {
    var occurancesOfKilledMonster = 0
    let killedMonsters = getKilledMonsters()
    let quest = getQuest(forNPC: npcID)
    for monsterID in killedMonsters {
        if monsterID == quest.reqID {
            occurancesOfKilledMonster += 1
        }
        if occurancesOfKilledMonster >= quest.number! {
            return true
        }
        //print("monsterID = \(monsterID) and quest.reqID = \(String(describing: quest.reqID))")
    }
    return false
}

func npcReply(recipient: String, player: inout PlayerData) -> (message: [String], quest: Quest?, questStatus: Int?, npcType: Int?) {
    var bodyRows:[String] = []
    let recipient = recipient.lowercased()
    var newQuest: Quest? = nil
    var questStatus: Int = 0
    if recipient.range(of: "samuel") != nil {
        if !samuel.spokenTo! {
            activeNpc = samuel
            let quest = getQuest(forNPC: samuel.npcId!)
            bodyRows.append("Samuel: Hi there, stranger. What's your name?")
            bodyRows.append("Samuel: \(player.name), huh? Haven't seen you around here.")
            bodyRows.append("Samuel: Why don't you make yourself useful and kill some of these giant spiders roaming the city.")
            bodyRows.append("Samuel: When you're done, come back and see me and I'll make it worth your while.")
            bodyRows.append("New Quest: \(String(describing: quest.name!))")
            newQuest = quest
            samuel.spokenTo = true
            samuel.questAccepted = true
            questStatus = QuestStatus.ACTIVE
        } else if samuel.questCompleted {
            activeNpc = samuel
            bodyRows.append("Samuel:Thanks for taking care of those spiders for me.")
        } else if checkQuestCompletion(forNPC: samuel.npcId!) {
            activeNpc = samuel
            bodyRows.append("Samuel:You did it! Nice work. I guess you're not completely useless afterall.")
            bodyRows.append("Samuel:Here's your reward.")
            samuel.questCompleted = true
            let quest = getQuest(forNPC: samuel.npcId!)
            newQuest = quest
            questStatus = QuestStatus.COMPLETE
        } else {
            activeNpc = samuel
            bodyRows.append("You need to kill more spiders before I can give you a reward.")
            bodyRows.append("Killed Spiders = \(getKilledMonsters().count)/\(String(describing: getQuest(forNPC: samuel.npcId!).number!))")
        }
        } else if recipient.range(of: "ned") != nil {
            if !ned.spokenTo! {
                activeNpc = ned
                let quest = getQuest(forNPC: ned.npcId!)
                bodyRows.append("Ned: What do you want?")
                bodyRows.append("Ned: Have you already killed those dang spiders for Samuel?")
                bodyRows.append("Ned: There's some gold in it for you if you do.")
                bodyRows.append("Ned: Why don't you head north to Valerion. There's more work up there. Althouh it's dangerous.")
                bodyRows.append("Ned: I wouldn't travel there with anything less than a long sword. You can pick one up from the blacksmith.")
                bodyRows.append("New Quest: \(String(describing: quest.name!))")
                newQuest = quest
                ned.spokenTo = true
                ned.questAccepted = true
                questStatus = QuestStatus.ACTIVE
            }
        } else if recipient.range(of: "studds") != nil {
            if !studds.spokenTo! {
                activeNpc = studds
                bodyRows.append("Studds: Another hero, huh?")
                bodyRows.append("Studds: Well, I guess old Studds has wutcha need.")
                studds.spokenTo = true
                questStatus = QuestStatus.NONE
            } else {
                activeNpc = studds
                bodyRows.append("Studds: You again?")
                bodyRows.append("Studds: Well, I guess old Studds has wutcha need.")
                studds.spokenTo = true
                questStatus = QuestStatus.NONE
        }

        } else {
            bodyRows.append("There's no one here by that name.")
    }
    return (bodyRows, newQuest ?? nil, questStatus, (activeNpc?.getNpcType() ?? nil)!)
}

