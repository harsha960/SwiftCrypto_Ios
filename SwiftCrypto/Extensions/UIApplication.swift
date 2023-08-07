//
//  UIApplication.swift
//  SwiftCrypto
//
//  Created by Harsha Vardhan Ravipati on 06/08/23.
//

import SwiftUI

extension UIApplication{
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
