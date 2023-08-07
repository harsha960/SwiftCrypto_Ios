//
//  HomeStatsView.swift
//  SwiftCrypto
//
//  Created by Harsha Vardhan Ravipati on 07/08/23.
//

import SwiftUI

struct HomeStatsView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var showPortfolio: Bool
    
    var body: some View {

        HStack {
            ForEach(vm.statistical) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               alignment: showPortfolio ? .trailing : .leading
        )
    }
}

struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            HomeStatsView(showPortfolio: .constant(false))
                .environmentObject(dev.homeVM)
        }
    }
}
