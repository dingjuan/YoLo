//
//  homeViewModel.swift
//  YoLoBoo
//
//  Created by Kevin Lu on 12/29/20.
//  Copyright © 2020 Juan Ding. All rights reserved.
//

import Foundation

typealias completion = () -> ()

class homeViewModel: NSObject {
    var serviceClient: FireBaseDataService = FireBaseDataService()
    var stateData: [Dictionary<String, Any>]?
    var loadingStatus: (completion)?
    
    override init() {
        super.init()
        fetchStateData()
    }
    
    private func fetchStateData() {
        try! self.serviceClient.fetchStateData(complete: { (data, error) in
            self.stateData = data
            self.loadingStatus?()
        })
    }
}
