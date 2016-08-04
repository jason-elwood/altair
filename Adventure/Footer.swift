//
//  Footer.swift
//  Adventure
//
//  Created by Jason Elwood on 7/27/16.
//  Copyright © 2016 Jason Elwood. All rights reserved.
//

import Foundation

func showFooter() {
    
    if footerRow.count > 0 {
        print(box.leftText(appWidth, cols: 1, string: footerRow[0], string2: "", boxed: true, strColor: fg.green, boxColor: fg.lightblue))
    } else {
        print(box.centeredText(appWidth, string: "", boxed: true, strColor: fg.white, boxColor: fg.lightblue))
    }
    print(box.createBottom(appWidth, color: fg.lightblue))
    
}
