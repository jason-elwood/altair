//
//  Battle.swift
//  Altair
//
//  Created by Jason Elwood on 3/3/20.
//  Copyright © 2020 Jason Elwood. All rights reserved.
//

import Foundation

class Battle {

    var currentMonster: Monster = Monster(name: "Beetle", hp: 10, attack: 6, exp: 25, id: MonsterIDs.BEETLE_ID)

    func randomEncounterCheck() {
        
    }

    func getCurrentMonster() -> Monster {
        return currentMonster
    }

    func defend(player: inout PlayerData, currentMonster: inout Monster?) {

    }

    func attack(player: inout PlayerData, currentMonster: inout Monster?) -> [String] {
        var monstersAttack = 0
        var playersAttack = 0
        var bodyRows: [String] = []

        if currentMonster == nil {
            bodyRows.append("There's nothing to attack here.")
        }
        let monsterName = currentMonster?.name!
        let playerHits: Bool = Int(arc4random_uniform(UInt32(player.chanceToHitModifier))) != 0 ? true : false
        let monsterHits: Bool = Int(arc4random_uniform(10)) != 0 ? true : false

        if playerHits {
            playersAttack = player.attackDamage
            currentMonster?.hp! -= playersAttack
        }

        if monsterHits {
            monstersAttack = (currentMonster?.attack)! + Int(arc4random_uniform(UInt32(player.level) * 2))
            player.hp -= monstersAttack
        }

        if playerHits {
            bodyRows.append("You attack \(String(describing: monsterName!)) for \(playersAttack) damage.")

            if (currentMonster?.hp!)! <= 0 {
                bodyRows.append("You slayed \(String(describing: monsterName))!!!")
                bodyRows.append("You earned \(String(describing: currentMonster?.exp!)) experience!")
                player.exp += (currentMonster?.exp)!
                addKilledMonster(monster: (currentMonster?.id)!)
                currentMonster = nil
                let potionDrop = Int(arc4random_uniform(UInt32(2)))
                if potionDrop == 1 {
                    player.potions += 1
                    bodyRows.append("\(monsterName!) dropped a potion!")
                }
                let goldDrop = Int(arc4random_uniform(UInt32(10)))
                if goldDrop > 0 {
                    player.gold += goldDrop
                    bodyRows.append("\(monsterName!) dropped \(goldDrop) gold!")
                }
            }
            return bodyRows
        } else {
            bodyRows.append("\(monsterName!) dodged your attack!")
        }

        if (currentMonster?.hp!)! > 0 {
            if monsterHits {
                bodyRows.append("\(monsterName!) attacks you for \(monstersAttack) damage.")
                print()
            } else {
                bodyRows.append("You managed to dodge \(monsterName!)'s attack!")
            }
        }

        playersAttack = 0
        monstersAttack = 0
        return bodyRows
    }
}
