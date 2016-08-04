//
//  Monsters.swift
//  Adventure
//
//  Created by Jason Elwood on 7/27/16.
//  Copyright © 2016 Jason Elwood. All rights reserved.
//

import Foundation

struct monster {
    let name: String?
    let hp: Int?
    let attack: Int?
}

let beetle      = monster(name: "Beetle", hp: 25, attack: 3)
let ooze        = monster(name: "Ooze", hp: 35, attack: 4)

var hound       = monster(name: "Hound", hp: 105, attack: 25)
var vampireBat  = monster(name: "Vampire Bat", hp: 85, attack: 35)

var lvlOneMonsters = [beetle, ooze]
var lvlTenMonsters = [hound, vampireBat]

func initializeMonsters() {
    
}

func getMonster(forLevel: Int) -> monster {
    switch forLevel {
    case 1, 2, 3, 4, 5, 6, 7, 8, 9:
        return lvlOneMonsters[Int(arc4random_uniform(UInt32(lvlOneMonsters.count)))]
    case 10, 11, 12, 13, 14, 15, 16, 17, 18, 19:
        return lvlTenMonsters[Int(arc4random_uniform(UInt32(lvlTenMonsters.count)))]
    default:
        return lvlOneMonsters[Int(arc4random_uniform(UInt32(lvlOneMonsters.count)))]
    }
}
