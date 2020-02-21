//
//  main.swift
//  Adventure
//
//  Created by Jason Elwood on 7/25/16.
//  Copyright © 2016 Jason Elwood. All rights reserved.
//

import Foundation

typealias fg                    = ANSIColorsForeground  // Text foreground
typealias bg                    = ANSIColorsBackground  // Text backround

let applescripts: AppleScripts  = AppleScripts()        // Terminal control
let dataRequest: DataRequest    = DataRequest()         // HTTP requests
let box: Box                    = Box()                 // Drawing 'engine'

let appWidth                    = 158           // Terminal collumns
let appHeight                   = 40            // Terminal rows
let headerHeight                = 10            // Header rows
let bodyHeight                  = 20            // Body rows
let footerHeight                = 1             // Footer rows

let title: String               = "Altair"      // App title
var gold: Int                   = 100           // Player's gold
var points: Int                 = 0             // Player's points
let maxPlayerLevel: Int         = 100           // Max player level
var playerName: String          = "Name"        // Player's name
var playerLevel: Int            = 1             // Player's current level
var playerHitPoints: Int        = 20            // Player's current hit points (health)
var playerMaxHitPoints: Int     = 20            // Player's max hit points (based on level)
var dragonHitPoints: Int        = 10000         // Enemie's current hit points (health)
var playerExperience: Int       = 0             // Player's current experience points
var gameOver: Bool              = false         // Will probably never be true for this game
var diceroll: Int               = 0             // Used for dice rolling
var attackMultiplier: Int       = 1             // Used to calculate attack damage
var weaponDamage: Double        = 5             // A weapon's base damage
var dragonDamage: Int           = 2             // An enemy's base damage
var playerChance: Double        = 0.9           // Player's chance to hit
var dragonChance: Double        = 0.7           // Enemy's cnance to hit
var potions: Int                = 3             // Number or potions in player's inventory
var playerQuit: Bool            = false         // Does player want to quit game
var newGame: Bool               = true          // Is this a new game
var newSession: Bool            = true          // Is this a new session
var inCombat: Bool              = false         // Is player in active combat
var inConversation: Bool        = false         // Is player in active conversation
var inTutorial: Bool            = false         // Is player in active tutorial
var areaHasMonsters: Bool       = false         // Does the current location contain enemies
var canShop: Bool               = false         // Does the current location contain a shop
var currentWeapon: String       = "Short Sword" // Player's currently equiped weapon
var bodyRows: [String]          = []            // Array containing lines of text in main UI
var footerRow: [String]         = []            // Array containing line of text in footer UI

var playerAttackDmg: Int        = 0             // The player's current total attack damage
var dragonAttackDmg: Int        = 0             // An ememy's current total attack damage
var showTheSplash: Bool            = true          // Show the splash or not

applescripts.initializeScripts()                // Initializes shell settings
print(bg.clear - "")                            // Clears background color

/******************************************************************************
 ***    ACTIONS THE PLAYER CAN TAKE
 ******************************************************************************/
let kRoll = "roll", kAttack = "attack", kPotion = "potion", kTravel = "travel",
    kQuit = "quit", kExit = "exit", kStats = "stats", kLook = "look", kHelp = "help",
    kYes = "y", kNo = "n", kCast = "cast", kTutorial = "tutorial", kTalk = "talk",
    kEnd = "end", kMap = "map"

/******************************************************************************
 ***    PARSE JSON AND ASSIGN SAVED VALUES TO CURRENT SESSION
 ******************************************************************************/
func parseGameFile(data: String) {
    
    if let jsonData = data.data(using: String.Encoding.utf8) {
        do {
            let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [[String:AnyObject]]
            if let name = json[0]["playername"] as? String { playerName = name }
            if let hp = json[0]["HP"] as? Int { playerHitPoints = hp }
            if let lev = json[0]["level"] as? Int { playerLevel = lev }
            if let exp = json[0]["experience"] as? Int { playerExperience = exp }
            if let pot = json[0]["potions"] as? Int { potions = pot }
            if let zon = json[0]["zone"] as? Int { setZone(zoneId: zon) }
            if let loc = json[0]["location"] as? Int { setLocation(locid: loc) }
            playerMaxHitPoints = playerLevel * 2 * 10
            newGame = false
        } catch let error as NSError {
            print(error)
        }
    }
    print("\u{001B}[2J")
    refreshUI()
}

/******************************************************************************
 ***    GENERATE A SAVE FILE
 ******************************************************************************/
func createSaveFile() {
    
    let destinationPath = "gmsvadv1.json"
    let initGame:String = ""
    
    do {
        try initGame.write(toFile: destinationPath, atomically: true, encoding: String.Encoding.utf8)
        bodyRows.append("Save file created.")
    } catch let error as NSError {
        bodyRows.append("Error writing file: \(error)")
    }
    print("\u{001B}[2J")
    refreshUI()
}

/******************************************************************************
 ***    GET THE SAVE FILE IF ONE EXISTS AND PASS IT TO PARSEGAMEFILE()
 ***    IF A SAVE FILE DOESN'T EXIST PASS CONTROL TO CREATESAVEFILE()
 ******************************************************************************/
func loadGame() {
    
    let destinationPath = "gmsvadv1.json"
    let filemgr = FileManager.default
    
    if filemgr.fileExists(atPath: destinationPath) {
        do {
            let readFile = try String(contentsOfFile: destinationPath, encoding: String.Encoding.utf8)
            parseGameFile(data: readFile)
        } catch let error as NSError {
            bodyRows.append("Error reading file: \(error)")
        }
    } else {
        bodyRows.append("Save file does not exist")
        createSaveFile()
    }
    print("\u{001B}[2J")
    refreshUI()
}

/******************************************************************************
 ***    SAVE CURRENT GAME STATE TO FILE
 ******************************************************************************/
func saveGame() {
    
    let gameState: NSString = NSString(string: "[{\"playername\":\"\(playerName)\",\"HP\":\(playerHitPoints), \"level\":\(playerLevel), \"experience\":\(playerExperience), \"potions\":\(potions), \"zone\":\(currentZoneId!), \"location\":\(currentLocationId!)}]")
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
    print("\u{001B}[2J")
    refreshUI()
    
}

/******************************************************************************
 ***    REFRESH THE TERMINAL SCREEN BY CLEARING AND REDRAWING TO IT
 ******************************************************************************/
func refreshUI() {
    // Strip of oldest lines if neccessary
    if bodyRows.count > bodyHeight {
        let rem = bodyRows.count - bodyHeight
        for _ in 0..<rem {
            bodyRows.removeFirst()
        }
    }
    
    showHeader()
    showBody()
    showFooter()
    footerRow = []
}

/******************************************************************************
 ******************************************************************************
 ***    THE FUNCTIONS BELOW (NOT INCLUDING GAMELOOP() ARE HANDLERS
 ***    FOR THE VARIOUS USER INPUTS.
 ***    EVERYTHING ABOVE THIS COMMENT IS SYSTEM FUNCTIONALITY;
 ***    EVERTHING BELOW IS GAME FUNCTIONALITY.
 ******************************************************************************
 ******************************************************************************/

/******************************************************************************
 ***    DISPLAY HELP FILE IN BODY OF APP
 ******************************************************************************/
func showHelp() {
    
}

/******************************************************************************
 ***    ANY NEW SESSION RUNS THIS ROUTINE
 ******************************************************************************/
func initNewSession() {
    showTitle()
    // 'areaCheck()' displays information about the new location
    areaCheck()
    footerRow.append("Save game found.  Data loaded.")
    print("\u{001B}[2J")
    refreshUI()
    newSession = false
}

/******************************************************************************
 ***    TRY TO LOAD A SAVED GAME OR ASK PLAYER TO CREATE A CHARACTER
 ******************************************************************************/
func initNewGame() {
    loadGame()
    
    if newGame {
        bodyRows.append("Welcome to \(title)!")
        footerRow.append("What will your name be?")
        print("\u{001B}[2J")
        refreshUI()
        print("Name", separator: "")
        // readLine reads user input
        let name = readLine(strippingNewline: true)
        playerName = String(name!)
        bodyRows.append("Okay, \(playerName).  Good luck!")
        saveGame()
        newGame = false
        inTutorial = true
    }
}

/******************************************************************************
 ***    SHOW THE TUTORIAL
 ******************************************************************************/
func initTutorial() {
    startTutorial()
    footerRow.append("Enter a command")
    footerRow = []
    inTutorial = false
}

/******************************************************************************
 ***    CONSUME A POTION IF AVAILABLE
 ******************************************************************************/
func takePotion() {
    if potions > 0 {
        playerHitPoints = playerMaxHitPoints
        potions -= 1
        bodyRows.append("You take a potion and restore your HP to \(playerMaxHitPoints)")
    } else {
        bodyRows.append("You are out of potions!")
    }
    print("\u{001B}[2J")
    refreshUI()
}

/******************************************************************************
 ***    ATTEMPT TO TRAVEL TO AN ADJACENT ZONE
 ******************************************************************************/
func travel(command: String) {
    footerRow.append("\(command)")
    let (cantraveltup, zoneTup, locationtup) = travelToLocation(string: command)
    if cantraveltup {
        bodyRows.append("You traveled to \(zones[zoneTup].getName())")
        bodyRows.append("You are at the foot of \(getLocation(locationid: locationtup).getName()).")
    } else {
        bodyRows.append("Sorry, you're not able to travel to that destination from here.")
    }
    saveGame()
    print("\u{001B}[2J")
    refreshUI()
}

/******************************************************************************
 ***    ATTACK ROUTINE
 ******************************************************************************/
func attack(command: String) {
    let playerHits: Bool = Int(arc4random_uniform(10)) != 0 ? true : false
    let dragonHits: Bool = Int(arc4random_uniform(10)) != 0 ? true : false
    
    if playerHits {
        
        playerAttackDmg = Int(weaponDamage) * playerLevel + Int(arc4random_uniform(UInt32(playerLevel) * 2))
        dragonHitPoints -= playerAttackDmg
        playerExperience += playerAttackDmg - Int(arc4random_uniform(UInt32(playerLevel) * 2))
        
    }
    
    if dragonHits {
        
        dragonAttackDmg = dragonDamage + Int(arc4random_uniform(UInt32(playerLevel) * 2))
        playerHitPoints -= dragonAttackDmg
        
    }
    
    if playerHits {
        bodyRows.append("You attack the dragon for \(playerAttackDmg) damage.")
        
        if dragonHitPoints <= 0 {
            bodyRows.append("You slayed the dragon!!!")
            bodyRows.append("Game Over")
            exit(0)
        }
    } else {
        bodyRows.append("The dragon dodged your attack!")
    }
    
    if dragonHits {
        bodyRows.append("The dragon attacks you for \(dragonAttackDmg) damage.")
        print()
    } else {
        bodyRows.append("You managed to dodge the dragon's attack!")
    }
    
    leveledUp()
    saveGame()
    
    print("\u{001B}[2J")
    refreshUI()
    
    playerAttackDmg = 0
    dragonAttackDmg = 0
}

/******************************************************************************
 ***    IF CHARACTER CAN LEVL UP, DO SO
 ******************************************************************************/
func leveledUp() {
    if playerLevel < 100 &&
        playerExperience > 50    && playerLevel < 2
        || playerExperience > 100   && playerLevel < 3
        || playerExperience > 200   && playerLevel < 4
        || playerExperience > 400   && playerLevel < 5
        || playerExperience > 800   && playerLevel < 6
        || playerExperience > 1600  && playerLevel < 7
        || playerExperience > 3200  && playerLevel < 8
        || playerExperience > 6400  && playerLevel < 9
        || playerExperience > 12800 && playerLevel < 10 {
        playerLevel += 1
        playerHitPoints = playerLevel * 2 * 10
        playerMaxHitPoints = playerHitPoints
        potions += 1
        weaponDamage *= 1.1
        if playerLevel == maxPlayerLevel {
            bodyRows.append("You are now level \(playerLevel)! You reached max level!")
        } else {
            showLevelUp(level: playerLevel)
        }
        bodyRows.append("You earned a potion.")
        saveGame()
        print("\u{001B}[2J")
        refreshUI()
        
    }
}

func talk(command: String) {
    let loc: LocationProtocol = getLocation(locationid: currentLocation!.getZoneId())
    if loc.getCanTalk(recipient: command) {
        // Maybe do something here.
    } else {
        bodyRows.append("There is no one here to talk to.")
    }
    print("\u{001B}[2J")
    refreshUI()
}

func splash() {
    showSplash()

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

/******************************************************************************
 ***    THE MAIN GAME LOOP
 ******************************************************************************/
func gameLoop() {
    
    // Preliminary status checks
    if newGame {
        if showTheSplash {
            splash()
        }
        initializeMap()
        initNewGame()
    }
    
    if newSession {
        initNewSession()
    }
    
    if inTutorial {
        initTutorial()
    }
    
    // Ready for normal user input
    print(fg.red + "\nCommand?")
    
    // 'command' contains the user input string
    var command: String! = String(data: FileHandle.standardInput.availableData, encoding:String.Encoding.utf8)
    command = command?.trimmingCharacters(in: NSCharacterSet.newlines)
    
    // process user input
    if command == kStats {
        
    } else if command == kLook {
        areaCheck()
        gameLoop()
    } else if command == kHelp {
        startHelp()
        gameLoop()
    } else if playerQuit == true && command == kYes {
        bodyRows.append("Good Bye")
        exit(0)
    } else if playerQuit == true && command == kNo {
        print("\u{001B}[2J")
        refreshUI()
        playerQuit = false
    } else if command == kQuit || command == kExit {
        print("\u{001B}[2J")
        refreshUI()
        footerRow.append("Are you sure? (y/n)")
        print("\u{001B}[2J")
        refreshUI()
        playerQuit = true
    } else if command == kPotion {
        takePotion()
        gameLoop()
    } else if command.range(of: kTalk) != nil {
        talk(command: command)
        gameLoop()
    } else if command.range(of: kTravel) != nil {
        travel(command: command)
        gameLoop()
    } else if kAttack.range(of: command) != nil {
        attack(command: command)
    } else if command == kTutorial {
        startTutorial()
    } else {
        footerRow.append("I couldn't understand \(String(describing: command)).  Type help for a list of commands.")
        print("\u{001B}[2J")
        refreshUI()
        gameLoop()
    }
    
    gameLoop()
}

gameLoop()  // Called once when the app first starts








