//
//  Protocols.swift
//  Altair
//
//  Created by Jason Elwood on 7/29/16.
//  Copyright © 2016 Jason Elwood. All rights reserved.
//

import Foundation

protocol MapProtocol {
    func canTalk(recipient: String) -> (Bool, String)
    func getConnectors() -> [MapProtocol]
    func getLocations() -> [MapProtocol]
    func getName() -> String
    func getZoneId() -> Int
    func initializeLocation(name: String)
    func getNPCs() -> [Dictionary<String, AnyObject>]
    func areaCheck()
}