//
//  String.swift
//  SwiftCrypto
//
//  Created by Harsha Vardhan Ravipati on 02/09/23.
//

import Foundation

extension String{
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
