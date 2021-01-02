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

struct city_keys {
    static let name = "name"
    static let latitude = "lat"
    static let longtitude = "long"
    static let state = "state"
    static let code = "ansicode"
    
    func parseDic(_ data: Array<Any>) -> Dictionary<String, Any> {
        var dic:Dictionary<String, Any> = Dictionary()
        if let city = data[3] as? String {
            dic[city_keys.name] = city.replacingOccurrences(of: "city", with: "")
        }
        dic[city_keys.state] = data[0]
        dic[city_keys.latitude] = data[10]
        dic[city_keys.longtitude] = data[11]
        dic[city_keys.code] = data[2]
        return dic
    }
}
