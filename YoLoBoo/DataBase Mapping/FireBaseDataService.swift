//
//  FireBaseDataService.swift
//  YoLoBoo
//
//  Created by Kevin Lu on 12/29/20.
//  Copyright © 2020 Juan Ding. All rights reserved.
//

import Foundation
typealias stateDataComplete = (_ data:[Dictionary<String, Any>]?, Error?) -> ()
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
}


