//
//  Help.swift
//  Altair
//
//  Created by Jason Elwood on 7/28/16.
//  Copyright © 2016 Jason Elwood. All rights reserved.
//

import Foundation

func getHelp(appWidth: Int) -> [String] {
    var rows:[String] = []

    rows.append(createHorizLine(appWidth: appWidth))
    rows.append("ooooo   ooooo           oooo")
    rows.append("`888'   `888'           `888")
    rows.append(" 888     888   .ooooo.   888  oo.ooooo.")
    rows.append(" 888ooooo888  d88' `88b  888   888' `88b")
    rows.append(" 888     888  888ooo888  888   888   888")
    rows.append(" 888     888  888    .o  888   888   888")
    rows.append("o888o   o888o `Y8bod8P' o888o  888bod8P'")
    rows.append("                               888")
    rows.append("                              o888o")
    rows.append(createHorizLine(appWidth: appWidth))
    rows.append("")
    rows.append("In Altair you enter text commands in the command prompt. Some commands have a modifier.")
    rows.append("For example, the command to talk is 'talk' (without quotes) plus the person you want to talk to. Example: talk Ned")
    rows.append("To travel to an adjacent zone type: 'travel' <zone name>. Example: travel Valerion")
    rows.append("To get familiar with your surroundings including who you can talk to, type 'look'.")
    rows.append("To enter a location type: 'enter' <location>. Example: enter tavern.")
    rows.append("To exit a location type: 'exit'.")
    rows.append("Battle commands: <attack>, <cast>, <potion>, and <run>")
    rows.append("Other commands are <tutorial>, <quests>, <quit>.")
    rows.append("If you need any help along the way, just type <help>.")
    rows.append("A list of the most common commands is always present above.")
    rows.append("For a complete list of commands type 'commands'.")
    
    //print("\u{001B}[2J")
    return rows
}
