//
//  Weapons.swift
//  Adventure
//
//  Created by Jason Elwood on 7/27/16.
//  Copyright © 2016 Jason Elwood. All rights reserved.
//

import Foundation

class ShopItems {

    var items:[ShopItem] = []

    enum ItemIDs {
        static let LONGSWORD_ID     = 0
        static let BATTLESWORD_ID   = 1
        static let WOODENSHIELD_ID  = 2
        static let COPPERSHIELD_ID  = 3
        static let POTION_ID        = 4
    }

    struct ShopItem: Decodable {
        let name: String?
        var hp: Int?
        let attack: Int?
        let exp: Int?
        let id: Int?
        let cost: Int
    }

    var longSword   = ShopItem(name: "Long Sword", hp: 10, attack: 6, exp: 25, id: ItemIDs.LONGSWORD_ID, cost: 50)
    var battleSword = ShopItem(name: "Battle Sword", hp: 20, attack: 12, exp: 45, id: ItemIDs.BATTLESWORD_ID, cost: 100)
    var woodenShield = ShopItem(name: "Wooden Shield", hp: 10, attack: 6, exp: 25, id: ItemIDs.WOODENSHIELD_ID, cost: 30)
    var coppershield = ShopItem(name: "Copper Shield", hp: 10, attack: 6, exp: 25, id: ItemIDs.WOODENSHIELD_ID, cost: 50)
    var potion = ShopItem(name: "Potion", hp: 10, attack: 6, exp: 25, id: ItemIDs.WOODENSHIELD_ID, cost: 25)

    func initItems() {
        items.append(longSword)
        items.append(battleSword)
        items.append(woodenShield)
        items.append(coppershield)
        items.append(potion)
    }

    func getWeapon(weaponId: Int) -> ShopItem {
        return items[weaponId]
    }

}
