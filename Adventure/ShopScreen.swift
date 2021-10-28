//
//  ShopScreen.swift
//  Altair
//
//  Created by Jason Elwood on 2/29/20.
//  Copyright © 2020 Jason Elwood. All rights reserved.
//

import Foundation

class ShopScreen {

    let shopItemsObj = ShopItems()
    var shopItemsArray: [ShopItems.ShopItem] = []

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

    func initializeShop() {
        shopItemsArray.append(shopItemsObj.longSword)
        shopItemsArray.append(shopItemsObj.woodenShield)
        shopItemsArray.append(shopItemsObj.potion)
        shopItemsArray.append(shopItemsObj.battleSword)
        shopItemsArray.append(shopItemsObj.coppershield)
    }

    func buySomething(gold: Int, command: String) -> (buyable: Bool, lessGold: Int, item: ShopItems.ShopItem?) {
        let index = Int(command)
        // You are here. Trying to get the correct item by the number the player entered.
        if index == 1 {
            return (true, shopItemsArray[0].cost, shopItemsArray[0])
        } else if index == 2 {
            return (true, shopItemsArray[1].cost, shopItemsArray[1])
        } else if index == 3 {
            return (true, shopItemsArray[2].cost, shopItemsArray[2])
        } else if index == 4 {
            return (true, shopItemsArray[3].cost, shopItemsArray[3])
        } else if index == 5 {
            return (true, shopItemsArray[4].cost, shopItemsArray[4])
        } else if index == 6 {
            return (true, -1, nil)
        } else {
            return (false, 0, nil)
        }
    }

    func showBody(box: Box, bodyRows: Array<String>, bodyHeight: Int, appWidth: Int) {

        let fillerRows = bodyHeight - bodyRows.count
        for _ in 0..<fillerRows {
            print(box.centeredText(width: appWidth, string: "", boxed: true, strColor: .white, boxColor: .lightblue))
        }
        for row in bodyRows {
            print(box.centeredText(width: appWidth, string: row, boxed: true, strColor: .white, boxColor: .lightblue))
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

    func storeContent(appWidth: Int)  -> [String] {
        var rows: [String] = []
        rows.append("╔╦╗╦╔═╗╦ ╦╔╦╗╦ ╦  ╦ ╦╔═╗╔═╗╔═╗╔═╗╔╗╔  ╔═╗╦ ╦╔═╗╔═╗")
        rows.append("║║║║║ ╦╠═╣ ║ ╚╦╝  ║║║║╣ ╠═╣╠═╝║ ║║║║  ╚═╗╠═╣║ ║╠═╝")
        rows.append("╩ ╩╩╚═╝╩ ╩ ╩  ╩   ╚╩╝╚═╝╩ ╩╩  ╚═╝╝╚╝  ╚═╝╩ ╩╚═╝╩  ")
        rows.append(createHorizLine(appWidth: appWidth))
        rows.append("")
        rows.append("Enter the number of the item you wish to buy and press enter.     ")
        rows.append("If you have enough gold, the item will be added to your inventory.")
        rows.append("")
        rows.append("1. LONG SWORD....................................50G          4. BATTLE SWORD....................................100G")
        rows.append("2. WOOD SHIELD...................................30G          5. COPPER SHIELD...................................50G ")
        rows.append("3. POTION........................................25G          6. Cancel                                              ")
        rows.append("")
        rows.append("")
        rows.append("")
        rows.append("")
        rows.append("")
        rows.append("")
        rows.append("")
        rows.append("")
        rows.append("")
        rows.append("")
        rows.append("")
        rows.append("")
        rows.append("")
        rows.append("")
        return rows
    }


}
