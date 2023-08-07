//
//  StatisticView.swift
//  SwiftCrypto
//
//  Created by Harsha Vardhan Ravipati on 07/08/23.
//

import SwiftUI

struct StatisticView: View {
    let stat: StasticalModel
    var body: some View {
        VStack(alignment: .leading,spacing: 4){
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees:(stat.PerecentageChange ?? 0) >= 0 ? 0 : 180))
                Text(stat.PerecentageChange?.aspercentageString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundColor((stat.PerecentageChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
            .opacity(stat.PerecentageChange  == nil ? 0 : 1)
            
            
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            StatisticView(stat: dev.stat1)
                .previewLayout(.sizeThatFits)
        }
    }
}
