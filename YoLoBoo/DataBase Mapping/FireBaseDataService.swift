//
//  FireBaseDataService.swift
//  YoLoBoo
//
//  Created by Kevin Lu on 12/29/20.
//  Copyright © 2020 Juan Ding. All rights reserved.
//

import Foundation
typealias stateDataComplete = (_ data:[Dictionary<String, Any>]?, Error?) -> ()
typealias cityDataComplete = (_ data:Dictionary<String, Any>?, Error?) -> ()

struct FireBaseDataService {
    
    func fetchStateData(complete: @escaping stateDataComplete) throws -> Void{
        var items: [Dictionary<String, Any>] = Array.init()
        let _: Void = FireBaseCustomData.ref.getDocuments(completion: { [](query, err) in
            if let err = err {
                complete(nil, err.localizedDescription as? Error)

            } else {
                for document in query!.documents {
                    items.append(document.data())
                }
                complete(items, err?.localizedDescription as? Error)
            }
          }
        )
    }
    
    func fetchCities(complete: @escaping cityDataComplete) throws -> Void{
        var items: Dictionary<String, Any> = Dictionary()
        if let filepath = Bundle.main.path(forResource: "city", ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath, encoding: String.Encoding.utf8)
                let strings = contents.components(separatedBy: .newlines)
                for s in strings {
                    let subString = s.components(separatedBy: "\t")
                    let length = Mirror(reflecting: subString).children.count
                    if length > 11 {
                        if let name: String = subString[0] as? String, name.contains("city") {
                            let dic:Dictionary<String, Any> = city_keys().parseDic(subString)
                            let keyExists = items[subString[0]] != nil
                            if keyExists {
                                var list: Array<Dictionary> = items[subString[0]] as! Array<Dictionary<String, Any>>
                                list.append(dic)
                                items[subString[0]] = list
                            } else {
                                var list: Array<Dictionary<String, Any>> = Array()
                                list.append(dic)
                                items[subString[0]] = list
                            }
                        }
                    }
                }
                complete(items, nil)
            } catch {
                complete(items, error)
                // contents could not be loaded
            }
        } else {
        }
        
    }
}


