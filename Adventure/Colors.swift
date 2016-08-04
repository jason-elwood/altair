//
//  Colors.swift
//  Adventure
//
//  Created by Jason Elwood on 7/26/16.
//  Copyright © 2016 Jason Elwood. All rights reserved.
//

import Foundation

enum ANSIColorsBackground: String {
    case black = "\u{001B}[0;40m"
    case red = "\u{001B}[0;41m"
    case green = "\u{001B}[0;42m"
    case yellow = "\u{001B}[0;43m"
    case blue = "{0,0,45000,0}"
    case magenta = "\u{001B}[0;45m"
    case cyan = "\u{001B}[0;46m"
    case white = "\u{001B}[0;47m"
    case clear = "\u{001b}[0;49m"
    
    func name() -> String {
        switch self {
        case black: return "Black"
        case red: return "Red"
        case green: return "Green"
        case yellow: return "Yellow"
        case blue: return "Blue"
        case magenta: return "Magenta"
        case cyan: return "Cyan"
        case white: return "White"
        case clear: return "Clear"
        }
    }
    
    static func all() -> [ANSIColorsBackground] {
        return [.black, .red, .green, .yellow, .blue, .magenta, .cyan, .white, .clear]
    }
}

enum ANSIColorsForeground: String {
    case black = "\u{001B}[0;30m"
    case red = "\u{001B}[0;31m"
    case green = "\u{001B}[0;32m"
    case yellow = "\u{001B}[0;33m"
    case blue = "\u{001B}[0;34m"
    case magenta = "\u{001B}[0;35m"
    case cyan = "\u{001B}[0;36m"
    case white = "\u{001B}[0;37m"
    case clear = "\u{001B}[0;39m"
    case lightblue = "\u{001B}[94m"
    
    func name() -> String {
        switch self {
        case black: return "Black"
        case red: return "Red"
        case green: return "Green"
        case yellow: return "Yellow"
        case blue: return "Blue"
        case magenta: return "Magenta"
        case cyan: return "Cyan"
        case white: return "White"
        case clear: return "Clear"
        case .lightblue: return "Lightblue"
        }
    }
    
    static func all() -> [ANSIColorsForeground] {
        return [.black, .red, .green, .yellow, .blue, .magenta, .cyan, .white, .clear, .lightblue]
    }
}

func + (let left: ANSIColorsForeground, let right: String) -> String {
    return left.rawValue + right
}

func - (let left: ANSIColorsBackground, let right: String) -> String {
    return left.rawValue + right
}

// END