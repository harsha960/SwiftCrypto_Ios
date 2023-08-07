//
//  DetailView.swift
//  SwiftCrypto
//
//  Created by Harsha Vardhan Ravipati on 31/08/23.
//

import SwiftUI
import SwiftUI
struct DetailLoadingView: View {
    @Binding var coin: CoinModel?
    var body: some View {
        if let coin = coin {
            DetailView(coin: coin)
        }
    }
    
}

struct DetailView: View {
    @StateObject var vm: DetailViewModel
    @State private var showfullDescription: Bool = false
    private let colums: [GridItem] = [GridItem(.flexible()),
                                      GridItem(.flexible())]
    
    init(coin: CoinModel)
    {
        _vm=StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    private let spacing: CGFloat = 30
    var body: some View {
        VStack(spacing: 20){
           
            HStack(spacing: 20){
                
                Text(vm.coin.name)
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.theme.accent)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(vm.coin.symbol.uppercased())
                    .frame(alignment: .trailing)
                    .font(.headline)
                    .foregroundColor(Color.theme.secondaryText)
                CoinImageView(coin: vm.coin)
                    .frame(width: 25, height: 25)
            }
            
        
            ScrollView {
                
                
                VStack{
                    VStack(spacing: 20) {
                        ChartView(coin: vm.coin)
                            .padding(.vertical)
                        overViewTitle
                        Divider()
                        descriptionSection
                        overviewGrid
                        additionalTitle
                        Divider()
                        additonalGrid
                        WebsiteSection
                    }
                    .padding()
                }
                
            }
            
        }
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}

extension DetailView {
    private var overViewTitle: some View {
        Text("OverView")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    private var descriptionSection: some View {
        ZStack{
            if let coinDescription = vm.coinDescription , !coinDescription.isEmpty{
                VStack(alignment: .leading){
                    Text(coinDescription)
                        .lineLimit(showfullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundColor(Color.theme.secondaryText)
                    Button(action:  {
                        withAnimation(.easeInOut)
                        {
                            showfullDescription.toggle()
                        }
                    }, label:  {
                        Text(showfullDescription ? "Less" : "Read more..")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical, 4)
                    })
                    .accentColor(.blue)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    private var overviewGrid: some View {
        LazyVGrid (columns: colums,
                   alignment: .leading,
                   spacing: spacing,
                   pinnedViews: [],
                   content: {
            ForEach(vm.overviewStatistics) { stat in
                StatisticView(stat: stat)
            }
            
        })
    }
    private var additonalGrid: some View {
        LazyVGrid (columns: colums,
                   alignment: .leading,
                   spacing: spacing,
                   pinnedViews: [],
                   content: {
            ForEach(vm.additionalStatistics) { stat in
                StatisticView(stat: stat)
            }
            
        })
    }
    private var WebsiteSection: some View {
        VStack(alignment: .leading, spacing: 20){
            if let websitestring = vm.websiteURL, let url = URL(string: websitestring){
                Link("Website", destination: url)
            }
            if let redditstring = vm.reddirURL, let url = URL(string: redditstring)
            {
                Link("Reddit", destination: url)
            }
        }
        .accentColor(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
        
    }
}
