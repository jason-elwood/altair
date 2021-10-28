//
//  Constants.swift
//  Altair
//
//  Created by Jason Elwood on 2/27/20.
//  Copyright © 2020 Jason Elwood. All rights reserved.
//

import Foundation

//curl -d '{"fields" : {"user": {"stringValue": "Jason"}} }' -H "Content-Type: application/json" -X POST 'https://firestore.googleapis.com/v1/projects/altair-89e7c/databases/(default)/documents/users.json/'

// Add in ?print=pretty

enum ConstantStrings: String {
    case APP_NAME = "Altair"
    case FIREBASE_DATABASE_URL_OLD = "https://firestore.googleapis.com/v1/projects/altair-89e7c/databases/(default)/documents/users/"
    case FIREBASE_DATABASE_URL = "https://firestore.googleapis.com/v1/projects/altair-89e7c/databases/(default)/documents/users.json/"
    case HEART_EMOJI  = "❤️"
    case SPIDER_EMOJI = "🕷"
    case SNAKE_EMOJI  = "🐍"
}

enum ConstantInts: Int {
    case MAX_PLAYER_LEVEL = 10
}
	



