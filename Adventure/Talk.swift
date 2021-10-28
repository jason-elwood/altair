//
//  Talk.swift
//  Altair
//
//  Created by Jason Elwood on 3/5/20.
//  Copyright © 2020 Jason Elwood. All rights reserved.
//

import Foundation

let box: Box = Box()
typealias fg                    = ANSIColorsForeground  // Text foreground
typealias bg                    = ANSIColorsBackground  // Text backround

func talkTo(command: String, player: inout PlayerData) -> [String] {
    var bodyRows: [String] = []
    if currentLocationId == IN_ZONE_NO_LOCATION {
        bodyRows.append("There is no one to talk to here.")
        return bodyRows
    }
    let loc: LocationProtocol = getLocation(locationid: currentLocation!.getZoneId())
    if loc.getCanTalk(recipient: command) {
        let response = npcReply(recipient: command, player: &player)
        for row in response.message {
            bodyRows.append(row)
        }
        if response.npcType == nil {
            return []
        }
        if let questStatus = response.questStatus {
            if questStatus == QuestStatus.COMPLETE {
                for (i, quest) in player.activeQuests.enumerated() {
                    if quest.id == response.quest?.id {
                        player.activeQuests.remove(at: i)
                    }
                }
            } else if questStatus == QuestStatus.ACTIVE {
                player.activeQuests.append(response.quest!)
            } else if questStatus == QuestStatus.NONE {
                if response.npcType == NpcType.SHOPKEEPER {
                    // TODO: Add this functionality to the Shop() class.
                    let shop = ShopScreen()
                    shop.showHeader(box: box, appWidth: AppData.APPWIDTH, title: AppData.TITLE, playerName: player.name, playerLevel: player.level, playerHitPoints: player.hp, playerExperience: player.exp, toNextLevel: player.levelupExp[player.level - 1], currentWeapon: player.activeWeapon?.name ?? "Short Sword", potions: player.potions, gold: player.gold)
                    shop.showBody(box: box, bodyRows: shop.storeContent(appWidth: AppData.APPWIDTH), bodyHeight: AppData.BODYHEIGHT, appWidth: AppData.APPWIDTH)
                    shop.showFooter(box: box, footerRow: [], appWidth: AppData.APPWIDTH)
                    shop.initializeShop()

                    print(fg.red + "\nWhat'll it be?")
//
                    var command: String! = String(data: FileHandle.standardInput.availableData, encoding:String.Encoding.utf8)
                    command = command?.trimmingCharacters(in: NSCharacterSet.newlines)

                    let (buyable, lessGold, item) = shop.buySomething(gold: player.gold, command: command)
                    if buyable {
                        if lessGold < 0 {
                            bodyRows.append("Okay, good bye.")
                        } else {
                            // Add itemNumber to player's inventory
                            player.gold -= lessGold
                            bodyRows.append("You purchased: \(item?.name ?? "Item Error")")
                        }

                    } else {
                        // Tell yhe player the item is not buyable and try again. talk(command: shopOwner.name)
                    }
                    return bodyRows
                }
            }
        }
    } else {
        bodyRows.append("There is no one here to talk to.")
    }
    return bodyRows
}
