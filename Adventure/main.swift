//
//  main.swift
//  Adventure
//
//  Created by Jason Elwood on 7/25/16.
//  Copyright © 2016 Jason Elwood. All rights reserved.
//

import Foundation
//import Firebase

class Altair: NSObject, DataManagerDelegate {

    //MARK: - Properties
    typealias fg                     = ANSIColorsForeground  // Text foreground
    typealias bg                     = ANSIColorsBackground  // Text backround

    let applescripts: AppleScripts   = AppleScripts()        // Terminal control
    let appData: AppData             = AppData()
    let dataRequest: DataRequest     = DataRequest()         // HTTP requests
    let box: Box                     = Box()                 // Drawing 'engine'
    var player: PlayerData           = PlayerData()
    var state: State                 = State()               // The current state of the game data
    var battle: Battle               = Battle()
    var areaHasMonsters: Bool        = false                 // Does the current location contain enemies
    var canShop: Bool                = false                 // Does the current location contain a shop
    var currentMonster: Monster?
    var bodyRows: [String]           = []                    // Array containing lines of text in main UI
    var footerRow: [String]          = []                    // Array containing line of text in footer UI
    var monsterAttackDamage: Int     = 0                     // An ememy's current total attack damage
    var showTheSplash: Bool          = true                  // Show the splash or not
    var enterGameLoop: Bool          = false
    var randomEncounterTimer: Timer? = nil

    /******************************************************************************
     ***    ACTIONS THE PLAYER CAN TAKE
     ******************************************************************************/
    let kRoll = "roll", kAttack = "attack", kSpell = "spell", kPotion = "potion", kTravel = "travel",
        kQuit = "quit", kExit = "exit", kEnter = "enter", kStats = "stats", kLook = "look", kHelp = "help",
        kYes = "y", kNo = "n", kCast = "cast", kTutorial = "tutorial", kTalk = "talk",
        kEnd = "end", kMap = "map", kAbout = "about", kExplore = "explore", kQuests = "quests",
        kCommands = "commands"

    func Altair() {
        applescripts.initializeScripts(appHeight: AppData.APPHEIGHT, appWidth: AppData.APPWIDTH)
        print(bg.clear - "")                            // Clears background color
    }
    //MARK: - Data Methods
    func didUpdateData(data: Data) {
        let response = didUpdateTheData(data: data)
        for row in response {
            footerRow.append(row)
        }
    }

    func didFailWithError(error: Error) {

    }

    func parseGameFile(data: String) {

        if let jsonData = data.data(using: String.Encoding.utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [[String:AnyObject]]
                if let name  = json[0]["playername"] as? String { player.name = name }
                if let hp    = json[0]["HP"] as? Int { player.hp = hp }
                if let lev   = json[0]["level"] as? Int { player.level = lev }
                if let exp   = json[0]["experience"] as? Int { player.exp = exp }
                if let pot   = json[0]["potions"] as? Int { player.potions = pot }
                if let zon   = json[0]["zone"] as? Int { setZone(zoneId: zon) }
                if let loc   = json[0]["location"] as? Int { setLocation(locid: loc) }
                if let act   = json[0]["activequests"] as? [Quest] {player.activeQuests = act}
                player.maxHp = player.level * 2 * 10
                state.newGame = false
            } catch let error as NSError {
                print(error)
            }
        }
    }

    func loadGame() {
        let response = loadTheGame(player: &player, state: &state)
        for row in response {
            bodyRows.append(row)
        }
    }

    func saveGame() {
        let response = saveTheGame(player: player)
        for row in response {
            bodyRows.append(row)
        }
        refreshUI()
    }

    func initNewSession() {
        lookCheck()
        footerRow.append("Save game found.  Data loaded.")
        dataRequest.getSomeData(mainClass: self)
        state.newSession = false
        refreshUI()
    }

    func initNewGame() {
        loadGame()

        if state.newGame {
            bodyRows.append("Welcome to \(AppData.TITLE)!")
            print("What will your name be?", separator: "")
            let name = readLine(strippingNewline: true)
            player.name = String(name!)
            bodyRows.append("Type help at any time for a list of commands.")
            bodyRows.append("Okay, \(player.name).  Good luck!")
            newGameContinued()
            refreshUI()
        }
    }

    func newGameContinued() {
        showHeader(box: box, appWidth: AppData.APPWIDTH,
                   title: AppData.TITLE,
                   playerName: player.name,
                   playerLevel: player.level,
                   playerHitPoints:player.hp,
                   playerExperience: player.exp,
                   toNextLevel: player.levelupExp[player.level - 1],
                   currentWeapon: player.activeWeapon?.name ?? "Short Sword",
                   potions: player.potions,
                   gold: player.gold)
        showTitle(for: "new game", appWidth: AppData.APPWIDTH, bodyHeight: AppData.BODYHEIGHT, box: box)
        showFooter(box: box, footerRow: footerRow, appWidth: AppData.APPWIDTH)
        footerRow = []
        print("\nReturn to continue: ")
        let _ = readLine(strippingNewline: true)
        state.newGame = false
        state.inTutorial = true
        saveGame()
    }

    //MARK: - Game Methods
    // TODO: Implement a Footer Rows so that the footer can expand.
    func refreshUI() {
        applescripts.clearScreen()
        let uiTimer = Timer.scheduledTimer(withTimeInterval: 1.0/30, repeats: false, block: {_ in
            self.uiRefresh()
        })
        let runLoop = RunLoop()
        runLoop.add(uiTimer, forMode: .default)
        RunLoop.current.run()
    }

    func uiRefresh() {
        if bodyRows.count > AppData.BODYHEIGHT {
            let rem = bodyRows.count - AppData.BODYHEIGHT
            for _ in 0..<rem {
                bodyRows.removeFirst()
            }
        }

        showHeader(box: box, appWidth: AppData.APPWIDTH, title: AppData.TITLE, playerName: player.name, playerLevel: player.level, playerHitPoints: player.hp, playerExperience: player.exp, toNextLevel: player.levelupExp[player.level - 1], currentWeapon: player.activeWeapon?.name ?? "Short Sword", potions: player.potions, gold: player.gold)
        showBody(box: box, bodyRows: bodyRows, bodyHeight: AppData.BODYHEIGHT, appWidth: AppData.APPWIDTH, footerRow: footerRow)
        showFooter(box: box, footerRow: footerRow, appWidth: AppData.APPWIDTH)
        footerRow = []
        if enterGameLoop {
            gameLoop()
        }
    }

    func initTutorial() {
        startTutorial(bodyRowsObj: bodyRows, appWidth: AppData.APPWIDTH)
        footerRow.append("Enter a command")
        footerRow = []
        state.inTutorial = false
        refreshUI()
    }

    func takePotion() {
        if player.potions > 0 {
            player.hp = player.maxHp
            player.potions -= 1
            bodyRows.append("You take a potion and restore your HP to \(player.maxHp)")
        } else {
            bodyRows.append("You are out of potions!")
        }
        refreshUI()
    }

    func travel(command: String) {
        let (cantraveltup, zoneTup, locationtup, message) = travelToLocation(string: command)
        if cantraveltup {
            bodyRows.append("You traveled to \(zones[zoneTup].getName())")
            bodyRows.append("You are at the foot of \(getLocation(locationid: locationtup).getName()).")
            randomEncounterTimer = Timer.scheduledTimer(withTimeInterval: 1.0/30, repeats: true, block: {_ in
                self.randomEncounterCheck()
                self.refreshUI()
            })
            let runLoop = RunLoop()
            runLoop.add(randomEncounterTimer!, forMode: .default)
            RunLoop.current.run()
        } else {
            bodyRows.append(message)
        }
        saveGame()
        refreshUI()
    }

    func attack(command: String) {
        let message = battle.attack(player: &player, currentMonster: &currentMonster)
        for row in message {
            bodyRows.append(row)
        }
        if player.hp < 1 {
           playerDied()
            return
        }
        leveledUp()
        saveGame()
        refreshUI()
    }


    func leveledUp() {
        for row in player.leveledUp() {
            bodyRows.append(row)
        }
        saveGame()
        refreshUI()
    }

    func talk(command: String) {
        let response = talkTo(command: command, player: &player)
        for row in response {
            bodyRows.append(row)
        }
        refreshUI()
    }

    func splash() {
        showSplash(box: box, appWidth: AppData.APPWIDTH, title: AppData.TITLE)
        print(fg.red + "\nCommand?")
        var command: String! = String(data: FileHandle.standardInput.availableData, encoding:String.Encoding.utf8)
        command = command?.trimmingCharacters(in: NSCharacterSet.newlines)
        if command.lowercased() == "start" {
            showTheSplash = false
            gameLoop()
        } else {
            splash()
        }
    }

    func startHelp() {
        for row in getHelp(appWidth: AppData.APPWIDTH) {
            bodyRows.append(row)
        }
    }

    func lookCheck() {
        for row in areaCheck(appWidth: AppData.APPWIDTH) {
            bodyRows.append(row)
        }
    }

    @objc func randomEncounterCheck() {
        let monsterHits: Bool = Int(arc4random_uniform(10)) != 0 ? true : false
        // TODO: Need to modify the especially argument so that we get the main monster for quest.
        currentMonster = getMonster(forLevel: player.level, emphasize: 2, byFactor: 6)
        if monsterHits {
            monsterAttackDamage = (currentMonster?.attack)! + Int(arc4random_uniform(UInt32(player.level) * 2))
            player.hp -= monsterAttackDamage
        }
        if monsterHits {
            bodyRows.append(createHorizLine(appWidth: AppData.APPWIDTH))
            bodyRows.append("You are in battle!")
            bodyRows.append("\(String(describing: currentMonster!.name!)) attacks you for \(monsterAttackDamage) damage!")
            print()
        } else {
            bodyRows.append("You managed to dodge the \(String(describing: currentMonster!.name!))'s attack!")
        }

    }

    func exploreArea() {
        bodyRows.append("You explore the area...") // Random encounters initiate here.
    }

    func exitLocation() {
        if !state.inCombat {
            if currentLocationId != IN_ZONE_NO_LOCATION {
                let currentLoc = getLocation(locationid: currentLocationId!)
                bodyRows.append("You exit \(currentLoc.getName())")
                setLocation(locid: IN_ZONE_NO_LOCATION)
            } else {
                bodyRows.append("You are already outside!")
            }
        } else {
            bodyRows.append("You can not exit right now! You are in combat! Try to run!")
        }
    }

    func enterLocation(command: String) {
        let returnData = enterToLocation(string: command)
        if returnData.canEnter {
            currentLocation = returnData.location
            currentLocationId = currentLocation?.getZoneId()
            bodyRows.append(returnData.message)
        }
    }

    func playerDied() {
        showEndScreen(box: box, appWidth: AppData.APPWIDTH, title: AppData.TITLE)
        state.gameOver = true
        // TODO: resetPlayerStats()
    }

    func resetPlayerStats() {
        player.resetPlayerStats(player: &player)
        saveGame()
        refreshUI()
    }

    func listQuests() {
        if player.activeQuests.count > 0 {
            bodyRows.append("Active Quests:")
            for quest in player.activeQuests {
                bodyRows.append(quest.name!)
            }
        } else {
            bodyRows.append("You have no active quests.")
        }
    }

    func showCommands() {
        bodyRows.append(createHorizLine(appWidth: AppData.APPWIDTH))
        bodyRows.append("COMMANDS:")
        bodyRows.append("attack, spell, potion, travel, quit, exit, enter, stats, look, help, y, n,")
        bodyRows.append("tutorial, talk, end, map, about, explore, quests, commands")
    }

    /******************************************************************************
     ***    THE MAIN GAME LOOP
     ******************************************************************************/
    func gameLoop() {        // Preliminary status checks
//        dataRequest.saveSomeData()
        if state.newGame {
            if showTheSplash {
                splash()
            }
            initializeMap(bodyRowsObj: bodyRows)
            initNewGame()
        }

        if state.newSession {
            initNewSession()
        }

        if state.inTutorial {
            initTutorial()
        }

        if state.gameOver {
            print(fg.red + "\nGame Over. Do you want to play again?")
            var command: String! = String(data: FileHandle.standardInput.availableData, encoding:String.Encoding.utf8)
            command = command?.trimmingCharacters(in: NSCharacterSet.newlines)
            if command == kYes {
                state.newGame = true
                showTheSplash = true
                state.gameOver = false
                bodyRows.append("")
                bodyRows.append("")
                bodyRows.append("")
                bodyRows.append("")
                bodyRows.append("")
                bodyRows.append("")
                startHelp()
                gameLoop()
            } else if command == kNo {
                print("Good Bye. Better luck next time.")
                exit(0)
            }
        }

        // Ready for normal user input
        print(fg.red + "\nCommand?")

        // 'command' contains the user input string
        var command: String! = String(data: FileHandle.standardInput.availableData, encoding:String.Encoding.utf8)
        command = command?.trimmingCharacters(in: NSCharacterSet.newlines)

        // process user input
        if command == kStats {

        } else if command == kLook {
            lookCheck()
            refreshUI()
        } else if command == kExit {
            exitLocation()
            refreshUI()
        } else if command.range(of: kEnter) != nil {
            enterLocation(command: command)
            refreshUI()
        } else if command == kHelp {
            startHelp()
            refreshUI()
        } else if command == kQuests {
            listQuests()
            refreshUI()
        } else if state.playerQuit == true && command == kYes {
            bodyRows.append("Good Bye")
            exit(0)
        } else if state.playerQuit == true && command == kNo {
            refreshUI()
            state.playerQuit = false
        } else if command == kQuit {
            refreshUI()
            footerRow.append("Are you sure? (y/n)")
            refreshUI()
            state.playerQuit = true
        } else if command == kPotion {
            takePotion()
            refreshUI()
        }  else if command == kCommands {
            showCommands()
            refreshUI()
        } else if command.range(of: kTalk) != nil {
            talk(command: command)
            refreshUI()
        } else if command.range(of: kTravel) != nil {
            travel(command: command)
            refreshUI()
        } else if kAttack.range(of: command) != nil {
            attack(command: command)
            refreshUI()
        } else if command == kTutorial {
            startTutorial(bodyRowsObj: bodyRows, appWidth: AppData.APPWIDTH)
            refreshUI()
        } else if command == kExplore {
            exploreArea()
            refreshUI()
        } else {
            applescripts.clearScreen()
            footerRow.append("I couldn't understand \(String(describing: command!)).  Type help for a list of commands.")
            refreshUI()
        }

        gameLoop()
    }
}

let altair = Altair()
altair.Altair()
altair.enterGameLoop = true
altair.gameLoop()








