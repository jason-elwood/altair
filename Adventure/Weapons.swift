//
//  Weapon.swift
//  Altair
//
//  Created by Jason Elwood on 3/3/20.
//  Copyright © 2020 Jason Elwood. All rights reserved.
//

import Foundation

class Weapons: ShopItems {

    struct Weapon: Decodable {
        let name: String?
        var hp: Int?
        let attack: Int?
        let exp: Int?
        let id: Int?
        let cost: Int
    }

}
