//
//  LargeText.swift
//  Adventure
//
//  Created by Jason Elwood on 7/28/16.
//  Copyright © 2016 Jason Elwood. All rights reserved.
//

import Foundation

let boxed: Box = Box()

func showTitle(for title: String, appWidth: Int, bodyHeight: Int, box: Box) {
    var rows: [String] = []

        if title.lowercased() == "tryton" {
        rows.append("MMP\"\"MM\"\"YMM `7MM\"\"\"Mq.`YMM'   `MM'MMP\"\"MM\"\"YMM   .g8\"\"8q. `7MN.   `7MF'")
        rows.append("P'   MM   `7   MM   `MM. VMA   ,V  P'   MM   `7 .dP'    `YM. MMN.    M  ")
        rows.append("     MM        MM   ,M9   VMA ,V        MM      dM'      `MM M YMb   M  ")
        rows.append("     MM        MMmmdM9     VMMP         MM      MM        MM M  `MN. M  ")
        rows.append("     MM        MM  YM.      MM          MM      MM.      ,MP M   `MM.M  ")
        rows.append("     MM        MM   `Mb.    MM          MM      `Mb.    ,dP' M     YMM  ")
        rows.append("  .JMML.    .JMML. .JMM. .JMML.      .JMML.      `\"bmmd\"' .JML.    YM")

        rows.append(createHorizLine(appWidth: appWidth))
        rows.append("")
        drawScreen(box: box, bodyRows: rows, bodyHeight: bodyHeight, appWidth: appWidth)
        } else {
            rows.append("Welcome to ALTAIR!")
            rows.append(createHorizLine(appWidth: appWidth))
            rows.append("More than five hundred years ago, clans of orks and gnomes made an agreement, by which they would share a rich mine in a wondrous cavern")
            rows.append("known as Wave Echo Cave. In addition to its mineral wealth, the mine contained great magical power. Human spellcasters allied themselves with the dwarves and gnomes to channel")
            rows.append("and bind that energy into a great forge (called the Forge of Spells), where magic items could be crafted. Times were good, and the nearby human town of Phandalin prospered as well.")
            rows.append("But then disaster struck when orcs swept through the North and laid waste to all in their path.")
            rows.append("")
            rows.append("A powerful force of orcs reinforced by evil mercenary wizards attacked Wave Echo Cave to seize its riches and magic treasures. Human wizards fought alongside their dwarf and")
            rows.append("gnome allies to defend the Forge of Spells, and the ensuing spell battle destroyed much of the cavern. Few survived the cave-ins and tremors, and the location of Wave EchoCave was lost.")
            rows.append("")
            rows.append("For centuries, rumors of buried riches have attracted treasure seekers and opportunists to the area around Phandalin, but no one has ever succeeded in locating the lost mine. In recent")
            rows.append("years, people have resettled the area. Phandalin is now a rough-and-tumble frontier town. More important, the Rockseeker brothers--a trio of dwarves--have discovered the entrance")
            rows.append("to Wave Echo Cave, and they intend to reopen the mines.")
            rows.append("")
            rows.append("Unfortunately for the Rockseekers, they are not the only ones interested in Wave Echo Cave. A mysterious villain known as the Black Spider controls a network of bandit gangs and")
            rows.append("goblin tribes in the area, and his agents have followed the Rockseekers to their prize. Now the Black Spider wants Wave Echo Cave for himself, and he is taking steps to make sure")
            rows.append("no one else knows where it is.")
            drawScreen(box: box, bodyRows: rows, bodyHeight: bodyHeight, appWidth: appWidth)
    }
}

func drawScreen(box: Box, bodyRows: Array<String>, bodyHeight: Int, appWidth: Int) {

    let fillerRows = bodyHeight - bodyRows.count
    for _ in 0..<fillerRows {
        print(box.centeredText(width: appWidth, string: "", boxed: true, strColor: .white, boxColor: .lightblue))
    }
    for row in bodyRows {
        //print(box.centeredText(width: appWidth, string: row, boxed: true, strColor: .white, boxColor: .lightblue))
        print(box.leftText(width: appWidth, cols: 1, string: row, string2: "", boxed: true, strColor: .white, boxColor: .lightblue))
    }
    print(box.createBottom(width: appWidth, color: .lightblue))

}

func createHorizLine(appWidth: Int) -> String {
    
    var word: String = ""
    for _ in 0..<appWidth - 4 {
        word += "="
    }
    return word
}




