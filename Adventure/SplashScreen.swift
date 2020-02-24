//
//  SplashScreen.swift
//  Altair
//
//  Created by Jason Elwood on 8/9/16.
//  Copyright © 2016 Jason Elwood. All rights reserved.
//

import Foundation

func showSplash(box: Box, appWidth: Int, title: String) {
    print("\u{001B}[2J")
    print(box.createLidWithTitle(width: appWidth, title: title, strColor: .white, boxColor: .lightblue))
    print(box.leftText(width: appWidth, cols: 1, string: "", string2: "", boxed: true, strColor: .white, boxColor: .lightblue))
    
    
    print(box.centeredText(width: appWidth, string: "     _                         _____ _                         _", boxed: true, strColor: .cyan, boxColor: .lightblue))
    print(box.centeredText(width: appWidth, string: "    | | __ _ ___  ___  _ __   | ____| |_      _____   ___   __| |", boxed: true, strColor: .cyan, boxColor: .lightblue))
    print(box.centeredText(width: appWidth, string: " _  | |/ _` / __|/ _ \\| '_ \\  |  _| | \\ \\ /\\ / / _ \\ / _ \\ / _` |", boxed: true, strColor: .cyan, boxColor: .lightblue))
    print(box.centeredText(width: appWidth, string: "| |_| | (_| \\__ \\ (_) | | | | | |___| |\\ V  V / (_) | (_) | (_| |", boxed: true, strColor: .cyan, boxColor: .lightblue))
    print(box.centeredText(width: appWidth, string: " \\___/ \\__,_|___/\\___/|_| |_| |_____|_| \\_/\\_/ \\___/ \\___/ \\__,_|", boxed: true, strColor: .cyan, boxColor: .lightblue))
    
    print(box.leftText(width: appWidth, cols: 1, string: "", string2: "", boxed: true, strColor: .white, boxColor: .lightblue))
    print(box.centeredText(width: appWidth, string: "PRESENTS", boxed: true, strColor: .cyan, boxColor: .lightblue))
    /*
      _                         ______ _                         _
     | |                       |  ____| |                       | |
     | | __ _ ___  ___  _ __   | |__  | |_      _____   ___   __| |
     | |/ _` / __|/ _ \| '_ \  |  __| | \ \ /\ / / _ \ / _ \ / _` |
| |__| | (_| \__ \ (_) | | | | | |____| |\ V  V / (_) | (_) | (_| |
 \____/ \__,_|___/\___/|_| |_| |______|_| \_/\_/ \___/ \___/ \__,_|
     
     _                         _____ _                         _
    | | __ _ ___  ___  _ __   | ____| |_      _____   ___   __| |
 _  | |/ _` / __|/ _ \| '_ \  |  _| | \ \ /\ / / _ \ / _ \ / _` |
| |_| | (_| \__ \ (_) | | | | | |___| |\ V  V / (_) | (_) | (_| |
 \___/ \__,_|___/\___/|_| |_| |_____|_| \_/\_/ \___/ \___/ \__,_|
 */
    
    print(box.leftText(width: appWidth, cols: 1, string: "", string2: "", boxed: true, strColor: .white, boxColor: .lightblue))
    
    print(box.centeredText(width: appWidth, string: "      .o.       ooooo        ooooooooooooo       .o.       ooooo ooooooooo. ", boxed: true, strColor: .red, boxColor: .lightblue))
    print(box.centeredText(width: appWidth, string: "     .888.      `888'        8'   888   `8      .888.      `888' `888   `Y88.", boxed: true, strColor: .red, boxColor: .lightblue))
    print(box.centeredText(width: appWidth, string: "    .8\"888.      888              888          .8\"888.      888   888   .d88'", boxed: true, strColor: .red, boxColor: .lightblue))
    print(box.centeredText(width: appWidth, string: "   .8' `888.     888              888         .8' `888.     888   888ooo88P'", boxed: true, strColor: .red, boxColor: .lightblue))
    print(box.centeredText(width: appWidth, string: " .88ooo8888.    888              888        .88ooo8888.    888   888`88b. ", boxed: true, strColor: .red, boxColor: .lightblue))
    print(box.centeredText(width: appWidth, string: " .8'     `888.   888       o      888       .8'     `888.   888   888  `88b.", boxed: true, strColor: .red, boxColor: .lightblue))
    print(box.centeredText(width: appWidth, string: "o88o     o8888o o888ooooood8     o888o     o88o     o8888o o888o o888o  o888o", boxed: true, strColor: .red, boxColor: .lightblue))
    
    print(box.leftText(width: appWidth, cols: 1, string: "", string2: "", boxed: true, strColor: .white, boxColor: .lightblue))
    print(box.centeredText(width: appWidth, string: "A   F A N T A S Y   R O L E   P L A Y I N G   A D V E N T U R E   F O R   Y O U R   M A C   T E R M I N A L", boxed: true, strColor: .cyan, boxColor: .lightblue))
    
    print(box.leftText(width: appWidth, cols: 1, string: "", string2: "", boxed: true, strColor: .white, boxColor: .lightblue))
    print(box.centeredText(width: appWidth, string: "VERSION 0.1.3", boxed: true, strColor: .cyan, boxColor: .lightblue))
    
    print(box.centeredText(width: appWidth, string: "PRE-ALPHA", boxed: true, strColor: .cyan, boxColor: .lightblue))
    print(box.leftText(width: appWidth, cols: 1, string: "", string2: "", boxed: true, strColor: .white, boxColor: .lightblue))
    print(box.leftText(width: appWidth, cols: 1, string: "", string2: "", boxed: true, strColor: .white, boxColor: .lightblue))
    
    
    print(box.centeredText(width: appWidth, string: "Type START and press return to continue.", boxed: true, strColor: .green, boxColor: .lightblue))
    
    print(box.leftText(width: appWidth, cols: 1, string: "", string2: "", boxed: true, strColor: .white, boxColor: .lightblue))
    print(box.leftText(width: appWidth, cols: 1, string: "", string2: "", boxed: true, strColor: .white, boxColor: .lightblue))
    print(box.leftText(width: appWidth, cols: 1, string: "", string2: "", boxed: true, strColor: .white, boxColor: .lightblue))
    print(box.leftText(width: appWidth, cols: 1, string: "", string2: "", boxed: true, strColor: .white, boxColor: .lightblue))
    
    print(box.centeredText(width: appWidth, string: "Copyright (C) 2020 Jason Elwood", boxed: true, strColor: .white, boxColor: .lightblue))
    print(box.centeredText(width: appWidth, string: "This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; implied or otherwise.", boxed: true, strColor: .white, boxColor: .lightblue))
    print(box.centeredText(width: appWidth, string: "This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License.", boxed: true, strColor: .white, boxColor: .lightblue))
    
    
    print(box.createBottom(width: appWidth, color: .lightblue))
}










