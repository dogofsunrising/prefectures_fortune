//
//  LocalDetailView.swift
//  prefectures_fortune
//
//  Created by 藤本皇汰 on 2024/06/30.
//

import SwiftUI

struct LocalDetailView: View {
    let LocalData : LocalData
    
    var body: some View{
        VStack{
            VStack {
                let result = LocalData.response
                let name = result.name
                let coast = result.has_coast_line
                let capital = result.capital
                let brief = result.brief
                
                
                Text("\(name)")
                
                
                Text("海岸線\(coast ? "はある" : "はない")")
                
                if let citizenDay = result.citizen_day {
                    Text("Citizen Day: \(citizenDay.month)/\(citizenDay.day)")
                }
                
                Text("首都は\(capital)")
                
                
                if let logoUrlString = result.logo_url, let logoUrl = URL(string: logoUrlString) {
                    AsyncImageView(url: logoUrl)
                        .frame(width: 100, height: 100) // 適切なサイズに設定してください
                }
                
              
                Text("概要\n" + brief)
                    .padding()
            }.padding()
        }
    }
}
