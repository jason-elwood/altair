//
//  LargeText.swift
//  Adventure
//
//  Created by Jason Elwood on 7/28/16.
//  Copyright © 2016 Jason Elwood. All rights reserved.
//

import Foundation

let boxed: Box = Box()

func showTitle() {
    
    bodyRows.append("      _    _ _        _")
    bodyRows.append("     / \\  | | |_ __ _(_)_ __")
    bodyRows.append("    / _ \\ | | __/ _` | | '__|")
    bodyRows.append("   / ___ \\| | || (_| | | |")
    bodyRows.append("  /_/   \\_\\_|\\__\\__,_|_|_|")
    //bodyRows.append("")
    bodyRows.append(createHorizLine())
    bodyRows.append("")
}

func createHorizLine() -> String {
    
    var word: String = ""
    for _ in 0..<appWidth - 4 {
        word += "="
    }
    return word
}
