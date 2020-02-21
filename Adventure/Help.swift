//
//  Help.swift
//  Altair
//
//  Created by Jason Elwood on 7/28/16.
//  Copyright © 2016 Jason Elwood. All rights reserved.
//

import Foundation

func startHelp() {
    
    bodyRows.append(" _   _      _")
    bodyRows.append("| | | | ___| |_ __")
    bodyRows.append("| |_| |/ _ \\ | '_ \\")
    bodyRows.append("|  _  |  __/ | |_) |")
    bodyRows.append("|_| |_|\\___|_| .__/")
    bodyRows.append("             |_|")
    bodyRows.append(createHorizLine())
    bodyRows.append("")
    bodyRows.append("In Altair you enter text commands in the command prompt. Some commands have a modifier.")
    bodyRows.append("For example, the command to talk is <talk> plus the person you want to talk to. Example: talk Ned")
    bodyRows.append("To travel to an adjacent zone type: travel <zone name>.")
    bodyRows.append("To get familiar with your surroundings including who you can talk to, type <look>.")
    bodyRows.append("Battle commands: <attack>, <potion>, <run>")
    bodyRows.append("Other commands are <tutorial>, <quit>")
    bodyRows.append("If you need any help along the way, just type <help>.")
    
    print("\u{001B}[2J")
    refreshUI()
}
