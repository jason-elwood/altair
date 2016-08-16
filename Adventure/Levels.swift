//
//  Levels.swift
//  Altair
//
//  Created by Jason Elwood on 8/10/16.
//  Copyright © 2016 Jason Elwood. All rights reserved.
//

import Foundation

func showLevelUp(level: Int) {
    bodyRows.append(createHorizLine())
    if level == 2 {
        bodyRows.append("You've Reached")
        bodyRows.append("oooo                                  oooo         .oooo.")
        bodyRows.append("`888                                  `888       .dP\"\"Y88b")
        bodyRows.append(" 888   .ooooo.  oooo    ooo  .ooooo.   888             ]8P'")
        bodyRows.append(" 888  d88' `88b  `88.  .8'  d88' `88b  888           .d8P'")
        bodyRows.append(" 888  888ooo888   `88..8'   888ooo888  888         .dP'")
        bodyRows.append(" 888  888    .o    `888'    888    .o  888       .oP     .o")
        bodyRows.append("o888o `Y8bod8P'     `8'     `Y8bod8P' o888o      8888888888")
    }
    bodyRows.append(createHorizLine())
}