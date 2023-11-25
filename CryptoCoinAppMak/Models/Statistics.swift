//
//  Statistics.swift
//  CryptoCoinAppMak
//
//  Created by Paris Makris on 18/11/23.
//

import Foundation


struct Statistics: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
    
}
