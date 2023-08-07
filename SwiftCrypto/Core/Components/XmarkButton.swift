//
//  XmarkButton.swift
//  SwiftCrypto
//
//  Created by Harsha Vardhan Ravipati on 08/08/23.
//

import SwiftUI


struct XmarkButton: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button (action: {
            
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }

}

struct XmarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XmarkButton()
    }
}
