//
//  ApplicationData.swift
//  Altair
//
//  Created by Jason Elwood on 2/22/20.
//  Copyright © 2020 Jason Elwood. All rights reserved.
//

import Foundation

struct ApplicationData: Decodable {
    let playerData: [Player]
}

struct Player: Decodable {
    let playerID: Double
    let playername: String
    let hitpoints: Double
    let outgoingMessages: [String]
    let incomingMessages: [String]
}
