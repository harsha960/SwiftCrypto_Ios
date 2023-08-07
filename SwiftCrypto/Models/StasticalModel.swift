//
//  StasticalModel.swift
//  SwiftCrypto
//
//  Created by Harsha Vardhan Ravipati on 07/08/23.
//

import Foundation

struct StasticalModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let PerecentageChange: Double?
    init(title: String, value:String, PerecentageChange: Double? = nil)
    {
        self.title = title
        self.value = value
        self.PerecentageChange = PerecentageChange
        
    }
    
}
