//
//  HomeView.swift
//  SwiftCrypto
//
//  Created by Harsha Vardhan Ravipati on 03/08/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false
    var body: some View {
        ZStack{
            //back Ground area
            Color.theme.backgorund
                .ignoresSafeArea()
            //Content Layer
            VStack{
                homeHeader
                HomeStatsView(showPortfolio: $showPortfolio)
                SearchBarView(searchText: $vm.searchText)
                
                columnTitle
                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }
                if showPortfolio {
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                
                Spacer(minLength: 0)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeVM)
       
    }
}

extension HomeView {
    private var homeHeader : some View {
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .background(
                    CircleButtonAnimation(animate: $showPortfolio)
                )
                .animation(.easeOut(duration: 0), value: 0)
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Price")
                .animation(.easeOut(duration: 0), value: 0)
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0 ))
                .onTapGesture {
                    withAnimation(.spring())
                    {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
        
    }
    private var allCoinsList: some View{
        List{
            ForEach(vm.allCoins) { coin in
                CoinRowView(showHoldingsColumn: false, coin: coin)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
        
    }
    private var portfolioCoinsList: some View{
        List{
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(showHoldingsColumn: true, coin: coin)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
        
    }
    private var columnTitle: some View{
        HStack {
            Text("Coin")
            Spacer()
            if(showPortfolio)
            {
                Text("holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3,alignment: .trailing)
        }
        .padding(.horizontal)
        
    }
}
