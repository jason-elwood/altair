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
let map: Map                    = Map()

let appWidth                    = 158           // Terminal collumns
let appHeight                   = 40            // Terminal rows
let headerHeight                = 10            // Header rows
let bodyHeight                  = 20            // Body rows
let footerHeight                = 1             // Footer rows

let title: String               = "Altair"      // App title
var currentLocation: Int        = 101           // Array index.  Locations are contained in zones
var currentZone: Int            = 0             // Array index.  Zones contain locations
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

applescripts.initializeScripts()                // Initializes shell settings
print(bg.clear - "")                            // Clears background color

/******************************************************************************
 ***    ACTIONS THE PLAYER CAN TAKE
 ******************************************************************************/
let kRoll = "roll", kAttack = "attack", kPotion = "potion", kTravel = "travel",
    kQuit = "quit", kExit = "exit", kStats = "stats", kLook = "look", kHelp = "help",
    kYes = "y", kNo = "n", kCast = "cast", kTutorial = "tutorial", kTalk = "talk",
    kEnd = "end"

/******************************************************************************
 ***    PARSE JSON AND ASSIGN SAVED VALUES TO CURRENT SESSION
 ******************************************************************************/
func parseGameFile(data: String) {
    
    if let jsonData = data.dataUsingEncoding(NSUTF8StringEncoding) {
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: []) as! [[String:AnyObject]]
            if let name = json[0]["playername"] as? String { playerName = name }
            if let hp = json[0]["HP"] as? Int { playerHitPoints = hp }
            if let lev = json[0]["level"] as? Int { playerLevel = lev }
            if let exp = json[0]["experience"] as? Int { playerExperience = exp }
            if let pot = json[0]["potions"] as? Int { potions = pot }
            if let zon = json[0]["zone"] as? Int { currentZone = zon }
            if let loc = json[0]["location"] as? Int { currentLocation = loc }
            playerMaxHitPoints = playerLevel * 2 * 10
            newGame = false
        } catch let error as NSError {
            print(error)
        }
    }
    system("clear")
    refreshUI()
}

/******************************************************************************
 ***    GENERATE A SAVE FILE
 ******************************************************************************/
func createSaveFile() {
    
    let destinationPath = "gmsvadv1.json"
    let initGame:String = ""
    
    do {
        try initGame.writeToFile(destinationPath, atomically: true, encoding: NSUTF8StringEncoding)
        bodyRows.append("Save file created.")
    } catch let error as NSError {
        bodyRows.append("Error writing file: \(error)")
    }
    system("clear")
    refreshUI()
}

/******************************************************************************
 ***    GET THE SAVE FILE IF ONE EXISTS AND PASS IT TO PARSEGAMEFILE()
 ***    IF A SAVE FILE DOESN'T EXIST PASS CONTROL TO CREATESAVEFILE()
 ******************************************************************************/
func loadGame() {
    
    let destinationPath = "gmsvadv1.json"
    let filemgr = NSFileManager.defaultManager()
    
    if filemgr.fileExistsAtPath(destinationPath) {
        do {
            let readFile = try String(contentsOfFile: destinationPath, encoding: NSUTF8StringEncoding)
            parseGameFile(readFile)
        } catch let error as NSError {
            bodyRows.append("Error reading file: \(error)")
        }
    } else {
        bodyRows.append("Save file does not exist")
        createSaveFile()
    }
    system("clear")
    refreshUI()
    
    // Test server
//    dataRequest.loginUser(["name":"Adventure App", "password":"IsMyPassword"]) {
//        (result: String) in
//        
//        if result == "success" {
//            print("Result: \(result)")
//        } else {
//            print("Result: \(result)")
//        }
//    }
}

/******************************************************************************
 ***    SAVE CURRENT GAME STATE TO FILE
 ******************************************************************************/
func saveGame() {
    
    let gameState: NSString = NSString(string: "[{\"playername\":\"\(playerName)\",\"HP\":\(playerHitPoints), \"level\":\(playerLevel), \"experience\":\(playerExperience), \"potions\":\(potions), \"zone\":\(currentZone), \"location\":\(currentLocation)}]")
    let destinationPath = "gmsvadv1.json"
    let filemgr = NSFileManager.defaultManager()
    if filemgr.fileExistsAtPath(destinationPath) {
        do {
            try gameState.writeToFile(destinationPath, atomically: true, encoding: NSUTF8StringEncoding)
        } catch let error as NSError {
            bodyRows.append("Error Writing file: \(error)")
        }
    } else {
        bodyRows.append("File does not exist")
        do {
            try gameState.writeToFile(destinationPath, atomically: true, encoding: NSUTF8StringEncoding)
        } catch let error as NSError {
            bodyRows.append("Error writing file: \(error)")
        }
    }
    system("clear")
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
    map.areaCheck()
    footerRow.append("Save game found.  Data loaded.")
    system("clear")
    refreshUI()
    newSession = false
}

/******************************************************************************
 ***    TRY TO LOAD A SAVED GAME OR ASK PLAYER TO CREATE A CHARACTER
 ******************************************************************************/
func initNewGame() {
    currentZone = 0
    currentLocation = 101
    loadGame()
    
    if newGame {
        bodyRows.append("Welcome to \(title)!")
        footerRow.append("What will your name be?")
        system("clear")
        refreshUI()
        print("Name", separator: "")
        // readLine reads user input
        let name = readLine(stripNewline: true)
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
    system("clear")
    refreshUI()
}

/******************************************************************************
 ***    ATTEMPT TO TRAVEL TO AN ADJACENT ZONE
 ******************************************************************************/
func travel(command: String) {
    footerRow.append("\(command)")
    let (cantraveltup, zoneTup, locationtup) = map.travelToLocation(command)
    if cantraveltup {
        currentZone = zoneTup
        currentLocation = locationtup
        bodyRows.append("You traveled to \(map.zones[zoneTup].getName())")
        bodyRows.append("You are at the foot of \(map.getLocation(locationtup).getName()).")
    } else {
        bodyRows.append("Sorry, you're not able to travel to that destination from here.")
    }
    saveGame()
    system("clear")
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
    
    system("clear")
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
            bodyRows.append("You are now level \(playerLevel)!")
        }
        bodyRows.append("You earned a potion.")
        saveGame()
        system("clear")
        refreshUI()
        
    }
}

func talk(command: String) {
    let loc: MapProtocol = map.getLocation(currentLocation)
    let (status, message) = loc.canTalk(command)
    if status {
        bodyRows.append(message)
    } else {
        footerRow.append("Response to talk request: status: \(status), message: \(message)")
    }
    system("clear")
    refreshUI()
}

/******************************************************************************
 ***    THE MAIN GAME LOOP
 ******************************************************************************/
func gameLoop() {
    
    // Preliminary status checks
    if newGame {
        map.initializeMap()
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
    var command: String! = String(data: NSFileHandle.fileHandleWithStandardInput().availableData, encoding:NSUTF8StringEncoding)
    command = command?.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
    
    // process user input
    if command == kStats {
        
    } else if command == kLook {
        map.areaCheck()
        gameLoop()
    } else if command == kHelp {
        startHelp()
        gameLoop()
    } else if playerQuit == true && command == kYes {
        bodyRows.append("Good Bye")
        exit(0)
    } else if playerQuit == true && command == kNo {
        system("clear")
        refreshUI()
        playerQuit = false
    } else if command == kQuit || command == kExit {
        system("clear")
        refreshUI()
        footerRow.append("Are you sure? (y/n)")
        system("clear")
        refreshUI()
        playerQuit = true
    } else if command == kPotion {
        takePotion()
        gameLoop()
    } else if command.rangeOfString(kTalk) != nil {
        talk(command)
        gameLoop()
    } else if command.rangeOfString(kTravel) != nil {
        travel(command)
        gameLoop()
    } else if kAttack.rangeOfString(command) != nil {
        attack(command)
    } else if command == kTutorial {
        startTutorial()
    } else {
        footerRow.append("I couldn't understand \(command).  Type help for a list of commands.")
        system("clear")
        refreshUI()
        gameLoop()
    }
    
    gameLoop()
}

gameLoop()  // Called once when the app first starts








