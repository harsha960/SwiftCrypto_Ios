//
//  HomeView.swift
//  SwiftCrypto
//
//  Created by Harsha Vardhan Ravipati on 03/08/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm: HomeViewModel
<<<<<<< HEAD
    @State private var showPortfolio: Bool = false // animate
    @State private var showPortfolioView: Bool = false  // new sheet
    @State private var selectedCoin: CoinModel? = nil
    @State private var showDetailView: Bool = false
=======
    @State private var showPortfolio: Bool = false
>>>>>>> dffd75de0a984333e233edd3a4ff99ffb8e1b4af
    var body: some View {
        ZStack{
            //back Ground area
            Color.theme.backgorund
                .ignoresSafeArea()
<<<<<<< HEAD
                .sheet(isPresented: $showPortfolioView, content: {
                    PortfolioView()
                        .environmentObject(vm)
                })
=======
>>>>>>> dffd75de0a984333e233edd3a4ff99ffb8e1b4af
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
<<<<<<< HEAD
        .background(
            NavigationLink(destination: DetailLoadingView(coin: $selectedCoin),
                           isActive: $showDetailView,
                           label: {
                               EmptyView()
                           })
        )
=======
>>>>>>> dffd75de0a984333e233edd3a4ff99ffb8e1b4af
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
<<<<<<< HEAD
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    }
                }
=======
>>>>>>> dffd75de0a984333e233edd3a4ff99ffb8e1b4af
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
<<<<<<< HEAD
                    .onTapGesture {
                        segue(coin: coin)
                    }
                
                
=======
>>>>>>> dffd75de0a984333e233edd3a4ff99ffb8e1b4af
            }
        }
        .listStyle(PlainListStyle())
        
    }
    private var portfolioCoinsList: some View{
        List{
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(showHoldingsColumn: true, coin: coin)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
<<<<<<< HEAD
                    .onTapGesture {
                        segue(coin: coin)
                    }
=======
>>>>>>> dffd75de0a984333e233edd3a4ff99ffb8e1b4af
            }
        }
        .listStyle(PlainListStyle())
        
    }
<<<<<<< HEAD
    private func segue(coin: CoinModel)
    {
        selectedCoin = coin
        showDetailView.toggle()
        
    }
    private var columnTitle: some View{
        HStack{
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0:0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default)
                {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            Spacer()
            if(showPortfolio)
            {
                HStack(spacing: 4) {
                    Text("holdings")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1.0:0.0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default)
                    {
                        vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
            }
            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1.0:0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default)
                {
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
            }
            
                .frame(width: UIScreen.main.bounds.width / 3,alignment: .trailing)
            Button (action: {
                withAnimation(.linear(duration: 2.9))
                {
                    vm.reloadData()
                }
            }, label: {
                Image(systemName: "goforward")
            })
            .rotationEffect(Angle(degrees: vm.isLoading ? 360: 0),anchor: .center)

        }
        .padding(.horizontal)
        .foregroundColor(Color.theme.secondaryText)
        .font(.caption)
=======
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
>>>>>>> dffd75de0a984333e233edd3a4ff99ffb8e1b4af
        
    }
}
