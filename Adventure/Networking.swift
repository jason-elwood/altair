//
//  Networking.swift
//  Altair
//
//  Created by Jason Elwood on 2/27/20.
//  Copyright © 2020 Jason Elwood. All rights reserved.
//

import Foundation

private let dataRequest: DataRequest = DataRequest()

func getData() {
    let url = URL(string: "\(ConstantStrings.FIREBASE_DATABASE_URL)\(playerEmail)")!
    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
//            guard let data = data else {
//                return
//            }
        //self.delegate?.didUpdateData(data: data)
    }
    task.resume()
}

func saveData(player: PlayerData) {
    // prepare json data
    let json: [String: Any] = ["title": "ABC",
                               "dict": ["1":"First", "2":"Second"]]

    let jsonData = try? JSONSerialization.data(withJSONObject: json)

    // create post request
    let url = URL(string: "http://httpbin.org/post")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"

    // insert json data to the request
    request.httpBody = jsonData

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            print(error?.localizedDescription ?? "No data")
            return
        }
        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
        if let responseJSON = responseJSON as? [String: Any] {
            print(responseJSON)
        }
    }

    task.resume()
}

/**
 Below this line are deprecated methods
 */

/******************************************************************************
 ***    GENERATE A SAVE FILE
 ******************************************************************************/
func createSaveFile() -> [String] {

    var bodyRows: [String] = []

    let destinationPath = "gmsvadv1.json"
    let initGame:String = ""

    do {
        try initGame.write(toFile: destinationPath, atomically: true, encoding: String.Encoding.utf8)
        bodyRows.append("Save file created.")
    } catch let error as NSError {
        bodyRows.append("Error writing file: \(error)")
    }
    return bodyRows
}

/******************************************************************************
 ***    GET THE SAVE FILE IF ONE EXISTS AND PASS IT TO PARSEGAMEFILE()
 ***    IF A SAVE FILE DOESN'T EXIST PASS CONTROL TO CREATESAVEFILE()
 ******************************************************************************/
func loadTheGame(player: inout PlayerData, state: inout State) -> [String] {

    var bodyRows: [String] = []

    let destinationPath = "gmsvadv1.json"
    let filemgr = FileManager.default

    if filemgr.fileExists(atPath: destinationPath) {
        do {
            let readFile = try String(contentsOfFile: destinationPath, encoding: String.Encoding.utf8)
            parseGameFile(data: readFile, player: &player, state: &state)
        } catch let error as NSError {
            bodyRows.append("Error reading file: \(error)")
        }
    } else {
        bodyRows.append("Save file does not exist")
        let response = createSaveFile()
        for row in response {
            bodyRows.append(row)
        }
    }
    return bodyRows
}

/******************************************************************************
 ***    SAVE CURRENT GAME STATE TO FILE
 ******************************************************************************/
func saveTheGame(player: PlayerData) -> [String] {

    var bodyRows: [String] = []

    let gameState: NSString = NSString(string: "[{\"playername\":\"\(player.name)\",\"HP\":\(player.hp), \"level\":\(player.level), \"experience\":\(player.exp), \"potions\":\(player.potions), \"zone\":\(currentZoneId!), \"location\":\(currentLocationId!), \"activequests\":\(player.activeQuests)}]")
    let destinationPath = "gmsvadv1.json"
    let filemgr = FileManager.default
    if filemgr.fileExists(atPath: destinationPath) {
        do {
            try gameState.write(toFile: destinationPath, atomically: true, encoding: String.Encoding.utf8.rawValue)
        } catch let error as NSError {
            bodyRows.append("Error Writing file: \(error)")
        }
    } else {
        bodyRows.append("File does not exist")
        do {
            try gameState.write(toFile: destinationPath, atomically: true, encoding: String.Encoding.utf8.rawValue)
        } catch let error as NSError {
            bodyRows.append("Error writing file: \(error)")
        }
    }
    return bodyRows
}

/******************************************************************************
 ***    TRY TO LOAD A SAVED GAME OR ASK PLAYER TO CREATE A CHARACTER
 ******************************************************************************/
//func initNewGame() {
//    loadGame()
//
//    if state.newGame {
//        bodyRows.append("Welcome to \(AppData.TITLE)!")
//        footerRow.append("What will your name be?")
//        //print("\u{001B}[2J")
//        //refreshUI()
//        print("Name", separator: "")
//        // readLine reads user input
//        let name = readLine(strippingNewline: true)
//        player.name = String(name!)
//        bodyRows.append("Type help at any time for a list of commands.")
//        bodyRows.append("Okay, \(player.name).  Good luck!")
//        newGameContinued()
//        refreshUI()
//    }
//}

//func newGameContinued() {
//    showHeader(box: box, appWidth: AppData.APPWIDTH, title: AppData.TITLE, playerName: player.name, playerLevel: player.level, playerHitPoints: player.hp, playerExperience: player.exp, toNextLevel: levelupExp[player.level - 1], currentWeapon: player.activeWeapon?.name ?? "Short Sword", potions: player.potions, gold: player.gold)
//    showTitle(for: "tryton", appWidth: AppData.APPWIDTH, bodyHeight: AppData.BODYHEIGHT, box: box)
//    showFooter(box: box, footerRow: footerRow, appWidth: AppData.APPWIDTH)
//    footerRow = []
//    print("Return to continue: ")
//    let _ = readLine(strippingNewline: true)
//    state.newGame = false
//    state.inTutorial = true
//    saveGame()
//    refreshUI()
//}

func didUpdateTheData(data: Data) -> [String] {
    var footerRow: [String] = []
    let json = try? JSONSerialization.jsonObject(with: data, options: [])
    if let playerData = json as? [String: Any] {
        let fields = playerData["fields"] as? [String: Any]
        if let playerEmail = fields?["playerName"] as? [String: Any] {
            if let pe = playerEmail["stringValue"] {
                if let outgoingMessages = fields?["outgoingMessages"] as? [String: Any] {
                    if let arrayValue = outgoingMessages["arrayValue"] as? [String: Any] {
                        if let values = arrayValue["values"] as? [Any] {
                            let message = values[0] as? [String: Any]
                            let stringValue = message?["stringValue"]
                            footerRow.append("\(pe as! String): \(String(describing: stringValue!))")
                            return footerRow
                        }
                    }
                }
            }
        }
    }

    let decoder = JSONDecoder()
    do {
        let decodedData = try decoder.decode(ApplicationData.self, from: data)
        let playerID = decodedData.playerData[0].playerID
        let playerName = decodedData.playerData[0].playername
        let playerHitpoints = decodedData.playerData[0].hitpoints

        let dataModel = DataBaseModel(playerID: playerID, playername: playerName, playerHitpoints: playerHitpoints, outgoingMessages: [], incomingMessages: [])
        //print("Data from handler: \(dataModel.playername)")
    } catch {
        //print("There was an error handling the data.")
    }
    return footerRow
}

func didFailWithError(error: Error) {

}

/******************************************************************************
 ***    PARSE JSON AND ASSIGN SAVED VALUES TO CURRENT SESSION
 ******************************************************************************/
func parseGameFile(data: String, player: inout PlayerData, state: inout State) {

    if let jsonData = data.data(using: String.Encoding.utf8) {
        do {
            let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [[String:AnyObject]]
            if let name = json[0]["playername"] as? String { player.name = name }
            if let hp = json[0]["HP"] as? Int { player.hp = hp }
            if let lev = json[0]["level"] as? Int { player.level = lev }
            if let exp = json[0]["experience"] as? Int { player.exp = exp }
            if let pot = json[0]["potions"] as? Int { player.potions = pot }
            if let zon = json[0]["zone"] as? Int { setZone(zoneId: zon) }
            if let loc = json[0]["location"] as? Int { setLocation(locid: loc) }
            player.maxHp = player.level * 2 * 10
            state.newGame = false
        } catch let error as NSError {
            print(error)
        }
    }
    //print("\u{001B}[2J")
    //refreshUI()
}
