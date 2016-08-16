//
//  Header.swift
//  Adventure
//
//  Created by Jason Elwood on 7/27/16.
//  Copyright © 2016 Jason Elwood. All rights reserved.
//

import Foundation

let textColor: ANSIColorsForeground = fg.cyan

func showHeader() {
    
    print(box.createLidWithTitle(appWidth, title: title, strColor: fg.white, boxColor: fg.lightblue))
    print(box.leftText(appWidth, cols: 2, string: playerName, string2: String(currentLocation!.getName()), boxed: true, strColor: textColor, boxColor: fg.lightblue))
    print(box.leftText(appWidth, cols: 2, string: "Level: \(playerLevel)", string2: String(currentZone!.getName()), boxed: true, strColor: textColor, boxColor: fg.lightblue))
    print(box.leftText(appWidth, cols: 1, string: "Exp: \(playerExperience)", string2: "", boxed: true, strColor: textColor, boxColor: fg.lightblue))
    print(box.leftText(appWidth, cols: 1, string: "HP: \(playerHitPoints)", string2: "", boxed: true, strColor: textColor, boxColor: fg.lightblue))
    print(box.leftText(appWidth, cols: 1, string: "Potions: \(potions)", string2: "", boxed: true, strColor: textColor, boxColor: fg.lightblue))
    print(box.leftText(appWidth, cols: 1, string: "Weapon: \(currentWeapon)", string2: "", boxed: true, strColor: textColor, boxColor: fg.lightblue))
    print(box.centeredText(appWidth, string: "COMMANDS", boxed: true, strColor: fg.white, boxColor: fg.lightblue))
    print(box.createLinksList(appWidth, links: ["configure", "help", "look", "shop", "talk", "travel", "quit"], strColor: fg.white, bgColor: bg.cyan, boxColor: fg.lightblue))
    //print(box.createLinksList(appWidth, links: ["attack", "potion", "rest", "run", "shop", "configure", "help", "quit"], strColor: fg.white, bgColor: bg.cyan, boxColor: fg.lightblue))
    bg.clear - ""
    print(box.createBottom(appWidth, color: fg.lightblue))
    
}

func showBody() {
    
    let fillerRows = bodyHeight - bodyRows.count
    for _ in 0..<fillerRows {
        print(box.centeredText(appWidth, string: "", boxed: true, strColor: fg.white, boxColor: fg.lightblue))
    }
    for row in 0..<bodyRows.count {
        print(box.leftText(appWidth, cols: 1, string: bodyRows[row], string2: "", boxed: true, strColor: fg.white, boxColor: fg.lightblue))
    }
    print(box.createBottom(appWidth, color: fg.lightblue))
    
}

func showFooter() {
    
    if footerRow.count > 0 {
        print(box.leftText(appWidth, cols: 1, string: footerRow[0], string2: "", boxed: true, strColor: fg.green, boxColor: fg.lightblue))
    } else {
        print(box.centeredText(appWidth, string: "", boxed: true, strColor: fg.white, boxColor: fg.lightblue))
    }
    print(box.createBottom(appWidth, color: fg.lightblue))
    
}












