//
//  Header.swift
//  Adventure
//
//  Created by Jason Elwood on 7/27/16.
//  Copyright © 2016 Jason Elwood. All rights reserved.
//

import Foundation

let textColor: ANSIColorsForeground = .cyan

func showHeader(box: Box, appWidth: Int, title: String, playerName: String, playerLevel: Int, playerHitPoints: Int, playerExperience: Int, toNextLevel: Int, currentWeapon: String, potions: Int, gold: Int) {
    print(box.createLidWithTitle(width: appWidth, title: title, strColor: .white, boxColor: .lightblue))
    print(box.leftText(width: appWidth, cols: 2, string: playerName, string2: String(currentZone?.getName() ?? ""), boxed: true, strColor: textColor, boxColor: .lightblue))
    print(box.leftText(width: appWidth, cols: 2, string: "Level: \(playerLevel)", string2: String(currentLocation?.getName() ?? ""), boxed: true, strColor: textColor, boxColor: .lightblue))
    print(box.leftText(width: appWidth, cols: 2, string: "Exp: \(playerExperience)/\(toNextLevel)", string2: "Gold: \(gold)", boxed: true, strColor: textColor, boxColor: .lightblue))
    print(box.leftText(width: appWidth, cols: 1, string: "HP: \(playerHitPoints)", string2: "", boxed: true, strColor: textColor, boxColor: .lightblue))
    print(box.leftText(width: appWidth, cols: 1, string: "Potions: \(potions)", string2: "", boxed: true, strColor: textColor, boxColor: .lightblue))
    print(box.leftText(width: appWidth, cols: 1, string: "Weapon: \(currentWeapon)", string2: "", boxed: true, strColor: textColor, boxColor: .lightblue))
    print(box.centeredText(width: appWidth, string: "COMMON COMMANDS", boxed: true, strColor: .white, boxColor: .lightblue))
    print(box.createLinksList(width: appWidth, links: ["help", "look", "enter", "exit", "talk", "travel", "quit", "quests"], strColor: .white, bgColor: .cyan, boxColor: .lightblue))
    //print(box.createLinksList(appWidth, links: ["attack", "potion", "rest", "run", "shop", "configure", "help", "quit"], strColor: fg.white, bgColor: bg.cyan, boxColor: fg.lightblue))
    //.clear - ""
    print(box.createBottom(width: appWidth, color: .lightblue))
    
}

func showBody(box: Box, bodyRows: Array<String>, bodyHeight: Int, appWidth: Int, footerRow: Array<String>) {
    
    let fillerRows = bodyHeight - bodyRows.count
    for _ in 0..<fillerRows {
        print(box.centeredText(width: appWidth, string: "", boxed: true, strColor: .white, boxColor: .lightblue))
    }
    for row in 0..<bodyRows.count {
        print(box.leftText(width: appWidth, cols: 1, string: bodyRows[row], string2: "", boxed: true, strColor: .white, boxColor: .lightblue))
    }
    print(box.createBottom(width: appWidth, color: .lightblue))
    
}

func showFooter(box: Box, footerRow: Array<String>, appWidth: Int) {
    
    if footerRow.count > 0 {
        print(box.leftText(width: appWidth, cols: 1, string: footerRow[0], string2: "", boxed: true, strColor: .green, boxColor: .lightblue))
    } else {
        print(box.centeredText(width: appWidth, string: "", boxed: true, strColor: .white, boxColor: .lightblue))
    }
    print(box.createBottom(width: appWidth, color: .lightblue))
    
}

func showTitle(box: Box, appWidth: Int) -> [String] {
    var rows:[String] = []

    rows.append(box.centeredText(width: appWidth, string: "     __    __ __      __  ___ __         ___      __", boxed: true, strColor: .red, boxColor: .lightblue))
    rows.append(box.centeredText(width: appWidth, string: "|  ||_ |  /  /  \\|\\/||_    | /  \\   /\\ |  |  /\\ ||__)", boxed: true, strColor: .red, boxColor: .lightblue))
    rows.append(box.centeredText(width: appWidth, string: "|/\\||__|__\\__\\__/|  ||__   | \\__/  /--\\|__| /--\\|| \\", boxed: true, strColor: .red, boxColor: .lightblue))

    return rows
}












