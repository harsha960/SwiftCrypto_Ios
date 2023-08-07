//
//  CoinlogoView.swift
//  SwiftCrypto
//
//  Created by Harsha Vardhan Ravipati on 09/08/23.
//

import SwiftUI

struct CoinlogoView: View {
    let coin: CoinModel
    var body: some View {
        VStack{
            CoinImageView(coin: coin)
                .frame(width: 50,height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .lineLimit(2)
                .multilineTextAlignment(.center)
        }
    }
}

struct CoinlogoView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            CoinlogoView(coin: dev.coin)
                .previewLayout(.sizeThatFits)
            CoinlogoView(coin: dev.coin)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
