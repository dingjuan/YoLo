//
//  FireBaseData.swift
//  YoLoBoo
//
//  Created by Kevin Lu on 12/27/20.
//  Copyright © 2020 Juan Ding. All rights reserved.
//

import Foundation
import Firebase

struct  FireBaseCustomData {
    static let ref = Firestore.firestore().collection("states")
    static let base = "https://firebasestorage.googleapis.com/v0/b/yoloboo-181a2.appspot.com/o/"
}

struct state_keys {
    static let nameKey = "name"
    static let capitalKey = "capital"
    static let popKey = "population"
    static let postalKey = "postal"
    static let sloganKey = "slogan"
    static let desKey = "des"
}
