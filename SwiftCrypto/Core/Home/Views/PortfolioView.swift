//
//  PortfolioView.swift
//  SwiftCrypto
//
//  Created by Harsha Vardhan Ravipati on 08/08/23.
//

import SwiftUI

struct PortfolioView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoList
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button (action: {
                        
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingNavBarButtons
                        .padding(.leading)
                        
                }
            })
            .onChange(of: vm.searchText) { value in
                if value == "" {
                    removeSelectedCoin()
                }
            }
            
            
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}

extension PortfolioView {
    private var coinLogoList: some View{
        
                ScrollView(.horizontal,showsIndicators: false) {
                    LazyHStack(spacing: 10) {
                        ForEach(vm.allCoins) { coin in
                            CoinlogoView(coin: coin)
                                .frame(width: 75)
                                .padding(4)
                                .onTapGesture {
                                    withAnimation(.easeIn)
                                    {
                                        selectedCoin = coin
                                    }
                                }
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(selectedCoin?.id == coin.id ? Color.theme.green: Color.clear
                                            ,lineWidth: 1.0)
                                )
                        }
                    }
                    .frame(height: 120)
                    .padding(.vertical, 4)
                    .padding(.leading)
                }
            }
    private func getCurrentval() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    private var portfolioInputSection: some View {
        VStack(spacing: 20){
            HStack{
                Text("Current Price of \(selectedCoin?.symbol.uppercased() ??  " "):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrency6Decimals() ?? "")
            }
            Divider()
            HStack {
                Text("Amount holdings")
                Spacer()
                TextField("Ex: 1.4", text: $quantityText)
                    .multilineTextAlignment(.center)
                    .keyboardType(.decimalPad)
              
            }
            Divider()
            HStack {
                Text("Current Value:")
                Spacer()
                Text(getCurrentval().asCurrency2Decimals())
            }
            
        }
        .animation(.none)
        .font(.headline)
        .padding()
    }
    private var trailingNavBarButtons: some View {
        
        HStack(spacing: 20) {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
            Button (action: {
                saveButtonPressed()
            }, label: {
                Text("save".uppercased())
            })
            .opacity(
                (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0
                
            )
        }
        .font(.headline)
        
    }
    private func saveButtonPressed()
    {
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
            else { return }
        // save to portfolio
        vm.updatePortfolio(coin: coin, amount: amount)
        // show check mark
        withAnimation(.easeIn)
        {
            showCheckmark = true
            removeSelectedCoin()
        }
        // hide keyborad
        UIApplication.shared.endEditing()
        // hide check mark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0)
        {
            withAnimation(.easeOut)
            {
                showCheckmark = false
                
            }
        }
        
    }
    private func removeSelectedCoin()
    {
        selectedCoin = nil
        vm.searchText = ""
    }
}
