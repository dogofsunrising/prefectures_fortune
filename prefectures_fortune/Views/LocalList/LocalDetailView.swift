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
        
        ZStack{
            Image("土地")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            ScrollView{
                VStack {
                    let result = LocalData.response
                    let name = result.name
                    let coast = result.has_coast_line
                    let capital = result.capital
                    let brief = result.brief
                    
                    
                    
                    BlinkingWithBlur(text: "\(name)",
                                     fontName: "default",
                                     textSize: 60,
                                     startTime: 0.1)
                    BlinkingWithBlur(text: "首都は\(capital)",
                                     fontName: "default",
                                     textSize: 30,
                                     startTime: 0.1)
                    BlinkingWithBlur(text: "海岸線\(coast ? "○" : "×")",
                                     fontName: "default",
                                     textSize: 20,
                                     startTime: 0.1)
                    if let citizenDay = result.citizen_day {
                        if(citizenDay.month != 0){
                            BlinkingWithBlur(text: "県民の日: \(citizenDay.month)/\(citizenDay.day)",
                                             fontName: "default",
                                             textSize: 20,
                                             startTime: 0.1)
                        }else{
                            BlinkingWithBlur(text: "県民の日: なし",
                                             fontName: "default",
                                             textSize: 20,
                                             startTime: 0.1)
                        }
                    }
                    
                    
                    
                    if let logoUrlString = result.logo_url, let logoUrl = URL(string: logoUrlString) {
                        AsyncImageView(url: logoUrl)
                            .frame(width: 300, height: 300) // 適切なサイズに設定してください
                    }
                    
                    
                    BlockTextAnimation(text: "概要\n" + brief,
                                       font: .title3,
                                       startTime: 1.0)
                    
                    
                    
                }.padding()
            }
        }
    }
}
