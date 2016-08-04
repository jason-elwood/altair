//
//  AppleScripts.swift
//  Adventure
//
//  Created by Jason Elwood on 7/26/16.
//  Copyright © 2016 Jason Elwood. All rights reserved.
//

import Foundation

class AppleScripts: NSObject {
    
    func initializeScripts() {
        
        /********************************************************************
         Not an AppleScript but does help initialize the window so it's here.
        *********************************************************************/
        system("printf '\\e[8;\(appHeight);\(appWidth)t'")          // Window dimensions
        system("printf '\\e[3;0;0t'")                               // Window positions
        
        let terminalBgScript = "tell application \"Terminal\" to set background color of window 1 to {0,0,0,0}"
        var tbsError: NSDictionary?
        if let scriptObject1 = NSAppleScript(source: terminalBgScript) {
            if let output: NSAppleEventDescriptor = scriptObject1.executeAndReturnError(
                &tbsError) {
                print("Output string: \(output.stringValue)")
            } else if (tbsError != nil) {
                print("error: \(tbsError)")
            }
        }
        
        let terminalMonacoScript = "tell application \"Terminal\" to set font of window 1 to \"Monaco\""
        var tmsError: NSDictionary?
        if let scriptObject3 = NSAppleScript(source: terminalMonacoScript) {
            if let output: NSAppleEventDescriptor = scriptObject3.executeAndReturnError(
                &tmsError) {
                print("Output string: \(output.stringValue)")
            } else if (tmsError != nil) {
                print("error: \(tmsError)")
            }
        }
        
        let terminalFontScript = "tell application \"Terminal\" to set font size of window 1 to \"14\""
        var tfsError: NSDictionary?
        if let scriptObject2 = NSAppleScript(source: terminalFontScript) {
            if let output: NSAppleEventDescriptor = scriptObject2.executeAndReturnError(
                &tfsError) {
                print("Output string: \(output.stringValue)")
            } else if (tfsError != nil) {
                print("error: \(tfsError)")
            }
        }
        
        let terminalSpacingScript = "tell application \"Terminal\" to set line spacing size of window 1 to \"1.1\""
        var tssError: NSDictionary?
        if let scriptObject2 = NSAppleScript(source: terminalSpacingScript) {
            if let output: NSAppleEventDescriptor = scriptObject2.executeAndReturnError(
                &tssError) {
                print("Output string: \(output.stringValue)")
            } else if (tssError != nil) {
                print("error: \(tssError)")
            }
        }
    }
    
}