//
//  Levels.swift
//  Altair
//
//  Created by Jason Elwood on 8/10/16.
//  Copyright © 2016 Jason Elwood. All rights reserved.
//

import Foundation

func showLevelUp(level: Int, appWidth: Int) -> [String] {
    var rows: [String] = []
    rows.append(createHorizLine(appWidth: appWidth))
    if level == 2 {
        rows.append("You've Reached")
        rows.append("oooo                                         oooo         .oooo.")
        rows.append("`888                                         `888       .dP\"\"Y88b")
        rows.append(" 888          .ooooo.  oooo    ooo  .ooooo.   888             ]8P'")
        rows.append(" 888         d88' `88b  `88.  .8'  d88' `88b  888           .d8P'")
        rows.append(" 888         888ooo888   `88..8'   888ooo888  888         .dP'")
        rows.append(" 888       o 888    .o    `888'    888    .o  888       .oP     .o")
        rows.append("o888ooooood8 `Y8bod8P'     `8'     `Y8bod8P' o888o      8888888888")
    } else if level == 3 {
        rows.append("You've Reached")
        rows.append("oooo                                         oooo         .oooo.")
        rows.append("`888                                         `888       .dP\"\"Y88b")
        rows.append(" 888          .ooooo.  oooo    ooo  .ooooo.   888             ]8P'")
        rows.append(" 888         d88' `88b  `88.  .8'  d88' `88b  888           <88b.")
        rows.append(" 888         888ooo888   `88..8'   888ooo888  888            `88b.")
        rows.append(" 888       o 888    .o    `888'    888    .o  888       o.   .88P")
        rows.append("o888ooooood8 `Y8bod8P'     `8'     `Y8bod8P' o888o      `8bd88P'")
    } else if level == 4 {
        rows.append("ooooo                                        oooo             .o")
        rows.append("`888'                                        `888           .d88")
        rows.append(" 888          .ooooo.  oooo    ooo  .ooooo.   888         .d'888")
        rows.append(" 888         d88' `88b  `88.  .8'  d88' `88b  888       .d'  888")
        rows.append(" 888         888ooo888   `88..8'   888ooo888  888       88ooo888oo")
        rows.append(" 888       o 888    .o    `888'    888    .o  888            888")
        rows.append("o888ooooood8 `Y8bod8P'     `8'     `Y8bod8P' o888o          o888o")
    } else if level == 5 {

        rows.append("ooooo                                        oooo         oooooooo")
        rows.append("`888'                                        `888        dP\"\"\"\"\"\"\"")
        rows.append(" 888          .ooooo.  oooo    ooo  .ooooo.   888       d88888b.")
        rows.append(" 888         d88' `88b  `88.  .8'  d88' `88b  888           `Y88b")
        rows.append(" 888         888ooo888   `88..8'   888ooo888  888             ]88")
        rows.append(" 888       o 888    .o    `888'    888    .o  888       o.   .88P")
        rows.append("o888ooooood8 `Y8bod8P'     `8'     `Y8bod8P' o888o      `8bd88P'")
    } else if level == 6 {

        rows.append("ooooo                                        oooo           .ooo")
        rows.append("`888'                                        `888         .88'")
        rows.append(" 888          .ooooo.  oooo    ooo  .ooooo.   888        d88'")
        rows.append(" 888         d88' `88b  `88.  .8'  d88' `88b  888       d888P\"Ybo.")
        rows.append(" 888         888ooo888   `88..8'   888ooo888  888       Y88[   ]88")
        rows.append(" 888       o 888    .o    `888'    888    .o  888       `Y88   88P")
        rows.append("o888ooooood8 `Y8bod8P'     `8'     `Y8bod8P' o888o       `88bod8'")
    }
    rows.append(createHorizLine(appWidth: appWidth))
    return rows
}
