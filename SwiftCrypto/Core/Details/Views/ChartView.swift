//
//  ChartView.swift
//  SwiftCrypto
//
//  Created by Harsha Vardhan Ravipati on 02/09/23.
//

import SwiftUI
import Foundation

struct ChartView: View {
    private let data: [Double]
    private let maxy: Double
    private let miny: Double
    private let lineColor: Color
    private let startingDate: Date
    private let endingDate: Date
    @State private var percentage: CGFloat = 0
    init(coin: CoinModel)
    {
        data = coin.sparklineIn7D?.price ?? []
        maxy=data.max() ?? 0
        miny=data.min() ?? 0
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? Color.theme.green : Color.theme.red
        endingDate = Date(coinGeckoString: coin.lastUpdated ?? "")
        startingDate = endingDate.addingTimeInterval(-7*24*60*60)
    }
    
    // 300
    // 100
    // each point hast 3 points
    
    var body: some View {
        VStack {
            chartView
                .frame(height: 200)
                .background(charBackground)
                .overlay (ChartYaxis.padding(.horizontal, 4), alignment: .leading)
            chartDatelable
                .padding(.horizontal, 4)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation(.linear(duration: 2.0))
                {
                    percentage = 1.0
                }
            }
        }
        
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
           
    }
}
extension ChartView {
    private var chartView: some View {
        GeometryReader { geometry in
            Path{ path in
                for index in data.indices {
                    let xpostion = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    let yaxis = maxy-miny
                    let yPostion = (1-(data[index] - miny)/yaxis) * geometry.size.height
                    if index == 0 {
                        path.move(to: CGPoint(x: xpostion, y: yPostion))
                    }
                    path.addLine(to: CGPoint(x: xpostion, y: yPostion))
                }
            }
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor, radius: 10, x: 0.0, y: 10)
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0.0, y: 10)
            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0.0, y: 10)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0.0, y: 10)
        }
    }
    private var charBackground: some View {
        VStack{
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    private var ChartYaxis: some View{
        VStack{
            Text(maxy.formattedWithAbbreviations())
            Spacer()
            let price = ((maxy + miny)/2).formattedWithAbbreviations()
            Text(price)
            Spacer()
            Text(miny.formattedWithAbbreviations())
            
        }
    }
    private var chartDatelable: some View {
        HStack{
            Text(startingDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        }
    }
}

