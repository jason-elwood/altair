//
//  GameState.swift
//  Adventure
//
//  Created by Jason Elwood on 7/27/16.
//  Copyright © 2016 Jason Elwood. All rights reserved.
//

import Foundation

struct AppData: Decodable {
    static let TITLE: String        = "Altair"
    static let APPWIDTH: Int        = 188
    static let APPHEIGHT: Int       = 45
    static let HEADERHEIGHT: Int    = 10
    static let BODYHEIGHT: Int      = 25
    static let FOOTERHEIGHT: Int    = 5
}

struct State: Decodable {
    var gameOver: Bool              = false         // Will probably never be true for this game
    var playerQuit: Bool            = false         // Does player want to quit game
    var newGame: Bool               = true          // Is this a new game
    var newSession: Bool            = true          // Is this a new session
    var inCombat: Bool              = false         // Is player in active combat
    var inConversation: Bool        = false         // Is player in active conversation
    var inTutorial: Bool            = false         // Is player in active tutorial
}

struct PlayerData: Decodable {
    var id: Double                          = 0
    var hp: Int                             = 20
    var exp: Int                            = 0
    var outgoingMessages: [String]          = []
    var incomingMessages: [String]          = []
    var activeQuests: [Quest]               = []
    var name: String                        = "Test Name"
    var lastIncomingMessage: String         = ""
    var lastOutgoingMessage: String         = ""
    var email: String                       = ""
    var gold: Int                           = 100
    var points: Int                         = 0
    var level: Int                          = 1
    var maxHp: Int                          = 20
    var activeWeapon: ShopItems.ShopItem?   = nil
    var potions: Int                        = 3
    var inventory: Inventory?               = nil
    var chanceToHitModifier: Int            = 10
    private var attack: Int                 = 10

    let levelupExp = [50, 100, 200, 400, 800, 1600, 3200, 6400, 12800]

    var attackDamage: Int {
        get {
            return attack
        }
        set(modifier) {
            attack = modifier * (activeWeapon?.attack ?? 10)
        }
    }

    func resetPlayerStats(player: inout PlayerData) {
        player.hp = 20
        player.level = 1
        player.exp = 0
        player.potions = 3
    }

    mutating func leveledUp() -> [String] {
        var bodyRows: [String] = []
        if level < ConstantInts.MAX_PLAYER_LEVEL.rawValue
            && exp >= levelupExp[0] && level < 2
            || exp >= levelupExp[1] && level < 3
            || exp >= levelupExp[2] && level < 4
            || exp >= levelupExp[3] && level < 5
            || exp >= levelupExp[4] && level < 6
            || exp >= levelupExp[5] && level < 7
            || exp >= levelupExp[6] && level < 8
            || exp >= levelupExp[7] && level < 9
            || exp >= levelupExp[8] && level < 10 {
            level += 1
            hp = level * 2 * 10
            maxHp = hp
            potions += 1
            attack = Int(Double(attack) * 1.1)
            if level == ConstantInts.MAX_PLAYER_LEVEL.rawValue {
                bodyRows.append("You are now level \(level)! You reached max level!")
            } else {
                for row in showLevelUp(level: level, appWidth: AppData.APPWIDTH) {
                    bodyRows.append(row)
                }
            }
            bodyRows.append("You earned a potion.")
            return bodyRows
        } else {
            return []
        }
    }
}

struct Inventory: Decodable {
    var weapons: [ShopItems.ShopItem] = []
}

var playerEmail = "jasontest@test.com"
