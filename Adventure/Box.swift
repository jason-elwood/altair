//
//  Box.swift
//  Adventure
//
//  Created by Jason Elwood on 7/26/16.
//  Copyright © 2016 Jason Elwood. All rights reserved.
//

import Foundation

class Box: NSObject {
    
    typealias fg = ANSIColorsForeground
    typealias bg = ANSIColorsBackground
    
    let ulc = "\u{2554}"
    let urc = "\u{2557}"
    let blc = "\u{255A}"
    let brc = "\u{255D}"
    let vl = "\u{2551}"
    let hl = "\u{2550}"
    
    func createLid(width: Int) -> String {
        var lid: String = ""
        lid += ulc
        for _ in 0 ..< width - 2 {
            lid += hl
        }
        lid += urc
        return lid
    }
    
    func createLidWithTitle(width: Int, title: String, strColor: ANSIColorsForeground, boxColor: ANSIColorsForeground) -> String {
        var text: String = ""
        text += boxColor + ulc
        let prespaces = width - title.characters.count
        for _ in 0..<prespaces / 2 - 2 {
            text += hl
        }
        text += " "
        text += strColor + title
        let postspaces = width - title.characters.count
        var diff = 0
        if title.characters.count % 2 != 0 {diff = 1}
        text += " "
        for _ in 0..<postspaces / 2 - 2 - diff {
            text +=  boxColor + hl
        }
        text += boxColor + urc
        return text
    }
    
    func createBottom(width: Int, color: ANSIColorsForeground) -> String {
        var bottom: String = ""
        bottom += color + blc
        for _ in 0 ..< width - 2 {
            bottom += color + hl
        }
        bottom += color + brc
        return bottom
    }
    
    func createLinksList(width: Int, links: [String], strColor: ANSIColorsForeground, bgColor: ANSIColorsBackground, boxColor: ANSIColorsForeground) -> String {
        var diff = 0
        strColor + ""
        let spacer = 4
        var text: String = ""
        text += boxColor + vl
        var characters = 0
        for link in links {
            characters += link.characters.count
        }
        let spaces = (width - characters) - ((links.count - 1) * spacer)
        
        text += " "
        for _ in 0..<spaces / 2 - 3 {
            text += bgColor - " "
        }
        if spaces % 2 == 0 {diff = 0} else {diff = 1}
        for link in 0..<links.count {
            text += bgColor - links[link]
            for _ in 0..<spacer {
                text += " "
            }
        }
        for _ in 0..<spaces / 2 - 5 + diff {
            text += " "
        }
        text += bg.clear - ""
        text += " "
        text += boxColor + vl
        return text
    }
    
    func centeredText(width: Int, string: String, boxed: Bool, strColor: ANSIColorsForeground, boxColor: ANSIColorsForeground) -> String {
        var diff = 0
        if string == "" {diff = 1} else {diff = 1}
        var text: String = ""
        if boxed {text += boxColor + vl}
        let prespaces = width - string.characters.count
        
        if prespaces % 2 == 0 {diff = 1} else {diff = 0}
        for _ in 0..<prespaces / 2 - diff {
            text += " "
        }
        text += strColor + string
        let postspaces = width - string.characters.count
        if string.characters.count % 2 != 0 {diff = 1}
        for _ in 0..<postspaces / 2 - diff {
            text += " "
        }
        if boxed == true {text += boxColor + vl}
        return text
    }
    
    func leftText(width: Int, cols: Int, string: String, string2: String, boxed: Bool, strColor: ANSIColorsForeground, boxColor: ANSIColorsForeground) -> String {
        var diff = 0
        var midspaces = 0
        var postspaces = 0
        if string == "" {diff = 1}
        var text: String = ""
        if boxed == true {text += boxColor + vl}
        text += strColor + " \(string)"
        if cols > 1 {
            postspaces = 1
            midspaces = width - string.characters.count - string2.characters.count - 1
            if string.characters.count % 2 != 0 {diff = 1} else {diff = 1}
            for _ in 0..<midspaces - diff - 2 {
                text += " "
            }
            text += strColor + string2
            text += " "
        } else {
            postspaces = width - string.characters.count
            if string.characters.count % 2 != 0 {diff = 1} else {diff = 1}
            for _ in 0..<postspaces - diff - 2 {
                text += " "
            }
        }
        
        if boxed == true {text += boxColor + vl}
        return text
    }
    
    func createHorzLine(strColor: ANSIColorsForeground) -> String {
        
        var line: String = ""
        for _ in 0..<appWidth - 4   {
            line += strColor + hl
        }
        return line
    }
    
}







