//
//  Monsters.swift
//  Adventure
//
//  Created by Jason Elwood on 7/27/16.
//  Copyright © 2016 Jason Elwood. All rights reserved.
//

import Foundation

enum MonsterIDs {
    static let BEETLE_ID     = 0
    static let OOZE_ID       = 1
    static let SPIDER_ID     = 2
    static let BLACKBAT_ID   = 3
    static let WEREDOG_ID    = 4
    static let HOUND_ID      = 5
    static let WEREBEAR_ID   = 6
    static let WOLF_ID       = 7
    static let LANDSHARK_ID  = 8
    static let UNDEADSTAG_ID = 9
}

struct Monster {
    let name: String?
    var hp: Int?
    let attack: Int?
    let exp: Int?
    let id: Int?
}

let beetle      = Monster(name: "Beetle", hp: 10, attack: 6, exp: 25, id: MonsterIDs.BEETLE_ID)
let ooze        = Monster(name: "Ooze", hp: 10, attack: 7, exp: 25, id: MonsterIDs.OOZE_ID)
let spider      = Monster(name: "Vampire Spider", hp: 12, attack: 8, exp: 25, id: MonsterIDs.SPIDER_ID)
let blackBat    = Monster(name: "Black Bat", hp: 12, attack: 9, exp: 25, id: MonsterIDs.BLACKBAT_ID)
let wereDog     = Monster(name: "Weredog", hp: 15, attack: 10, exp: 25, id: MonsterIDs.WEREDOG_ID)

var hound       = Monster(name: "Hound", hp: 50, attack: 26, exp: 50, id: MonsterIDs.HOUND_ID)
var wereBear    = Monster(name: "Werebear", hp: 50, attack: 27, exp: 50, id: MonsterIDs.WEREBEAR_ID)
var wolf        = Monster(name: "Wolf", hp: 60, attack: 28, exp: 50, id: MonsterIDs.WOLF_ID)
var landShark   = Monster(name: "Land Shark", hp: 75, attack: 29, exp: 50, id: MonsterIDs.LANDSHARK_ID)
var undeadStag  = Monster(name: "Undead Stag", hp: 75, attack: 30, exp: 50, id: MonsterIDs.UNDEADSTAG_ID)

var zoneOneMonsters = [beetle, ooze, spider, blackBat, wereDog]
var zoneTwoMonsters = [hound, wereDog, wolf, landShark, undeadStag]

var killedMonsters = [Int]()

var debug = true

func initializeMonsters() {
    
}

func addKilledMonster(monster: Int) {
    killedMonsters.append(monster)
    killedMonsters.sort()
}

func getKilledMonsters() -> [Int] {
    return killedMonsters
}

func getMonster(forLevel: Int, emphasize: Int, byFactor: Int) -> Monster {
    switch forLevel {
    case 1, 2, 3, 4, 5, 6, 7, 8, 9:
        if debug {
            let monsterIndex = Int.random(in: 0...zoneOneMonsters.count + byFactor)
            if monsterIndex >= zoneOneMonsters.count {
                return zoneOneMonsters[emphasize]
            } else {
                return zoneOneMonsters[monsterIndex]
            }
            //return zoneOneMonsters[2]
        }
        return zoneOneMonsters[Int(arc4random_uniform(UInt32(zoneOneMonsters.count)))]
    case 10, 11, 12, 13, 14, 15, 16, 17, 18, 19:
        return zoneTwoMonsters[Int(arc4random_uniform(UInt32(zoneTwoMonsters.count)))]
    default:
        return zoneOneMonsters[Int(arc4random_uniform(UInt32(zoneOneMonsters.count)))]
    }
}
