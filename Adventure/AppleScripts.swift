//
//  AppleScripts.swift
//  Adventure
//
//  Created by Jason Elwood on 7/26/16.
//  Copyright © 2016 Jason Elwood. All rights reserved.
//

import Foundation

class AppleScripts: NSObject {
    
    func initializeScripts(appHeight: Int, appWidth: Int) {
        
        /********************************************************************
         Not an AppleScript but does help initialize the window so it's here.
        *********************************************************************/

        let terminalDimenshionsScript = "tell application \"Terminal\" to set bounds of window 1 to {0, 0, \(Int(Double(appWidth) * 7.2)), \(Int(Double(appHeight) * 13.5))}"     // {x, y, width, height}
        var tdsError: NSDictionary?
        if let scriptObject6 = NSAppleScript(source: terminalDimenshionsScript) {
            let output: NSAppleEventDescriptor = scriptObject6.executeAndReturnError(
                &tdsError)
            if (tdsError != nil) {
                print("Diminsion Output string: \(String(describing: output.stringValue))")
            } else if (tdsError != nil) {
                print("Set Dimension error: \(String(describing: tdsError))")
            }
        }
        
        let terminalBgScript = "tell application \"Terminal\" to set background color of window 1 to {0,0,0,0}"
        var tbsError: NSDictionary?
        if let scriptObject1 = NSAppleScript(source: terminalBgScript) {
            let output: NSAppleEventDescriptor = scriptObject1.executeAndReturnError(
                &tbsError)
            if (tdsError != nil) {
                print("Background Color Output string: \(String(describing: output.stringValue))")
            } else if (tbsError != nil) {
                print("error: \(String(describing: tbsError))")
            }
        }
        
        let terminalMonacoScript = "tell application \"Terminal\" to set font of window 1 to \"Monaco\""
        var tmsError: NSDictionary?
        if let scriptObject3 = NSAppleScript(source: terminalMonacoScript) {
            let output: NSAppleEventDescriptor = scriptObject3.executeAndReturnError(
                &tmsError)
            if (tmsError != nil) {
                print("Font Type Output string: \(String(describing: output.stringValue))")
            } else if (tmsError != nil) {
                print("error: \(String(describing: tmsError))")
            }
        }
        
        let terminalFontScript = "tell application \"Terminal\" to set font size of window 1 to \"14\""
        var tfsError: NSDictionary?
        if let scriptObject2 = NSAppleScript(source: terminalFontScript) {
            let output: NSAppleEventDescriptor = scriptObject2.executeAndReturnError(
                &tfsError)
            if (tfsError != nil) {
                print("Font Size Output string: \(String(describing: output.stringValue))")
            } else if (tfsError != nil) {
                print("error: \(String(describing: tfsError))")
            }
        }
        
        let terminalSpacingScript = "tell application \"Terminal\" to set line spacing size of window 1 to \"1.1\""
        var tssError: NSDictionary?
        if let scriptObject2 = NSAppleScript(source: terminalSpacingScript) {
            let output: NSAppleEventDescriptor = scriptObject2.executeAndReturnError(
                &tssError)
            if (tssError != nil) {
                print("Output string: \(String(describing: output.stringValue))")
            } else if (tssError != nil) {
                print("error: \(String(describing: tssError))")
            }
        }
    }
    
}
