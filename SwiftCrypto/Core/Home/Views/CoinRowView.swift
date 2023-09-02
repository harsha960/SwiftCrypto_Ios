//
//  CoinRowView.swift
//  SwiftCrypto
//
//  Created by Harsha Vardhan Ravipati on 03/08/23.
//

import SwiftUI

struct CoinRowView: View {
    let showHoldingsColumn: Bool
    let coin: CoinModel
    var body: some View {
        HStack(spacing: 0){
            leftcoulmn
            Spacer()
            if(showHoldingsColumn)
            {
                centercoulmn
            }
            rightcoulmn
            
        }
        .font(.subheadline)
<<<<<<< HEAD
        .background(
            Color.theme.backgorund.opacity(0.001)
        )
=======
>>>>>>> dffd75de0a984333e233edd3a4ff99ffb8e1b4af
        
        
        
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(showHoldingsColumn: true, coin: dev.coin)
                .previewLayout(.sizeThatFits)
            CoinRowView(showHoldingsColumn: true, coin: dev.coin)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}

extension CoinRowView{
    private var leftcoulmn: some View {
        HStack(spacing: 0){
            Text(String(coin.Rank))
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(Color.theme.accent)
           
            
        }
    }
    private var centercoulmn: some View {
       VStack(alignment: .trailing)
        {
            Text(coin.currentHoldingsValue.asCurrency2Decimals())
            .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundColor(Color.theme.accent)
        
    }
    private var rightcoulmn: some View {
        VStack(alignment: .trailing){
            Text(coin.currentPrice.asCurrency2Decimals())
                .bold()
                .foregroundColor(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.aspercentageString() ?? "" )
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green :Color.theme.red
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3,alignment: .trailing)
    }
}

