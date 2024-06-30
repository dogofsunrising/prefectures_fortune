//
//  File.swift
//  prefectures_fortune
//
//  Created by 藤本皇汰 on 2024/06/29.
//

import SwiftUI
import RealmSwift

struct LocalList: View {
    @State var results:[LocalData] = []
    var body: some View{
        VStack{
            VStack {
                if results.isEmpty {
                    Text("履歴はありません")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    
                    List(results.reversed(), id: \.id) { result in
                        
                        Section(header: Text("\(result.http.today.year)/\(result.http.today.month)/\(result.http.today.day)")) {
                            NavigationLink(destination: LocalDetailView(LocalData: result)) {
                                Local(LD: result)
                            }
                        }
                        
                    }
                }
            }.onAppear{
                results = GetRealm()
            }
        }
    }
}

extension LocalList{
    @ViewBuilder
    func Local(LD: LocalData) -> some View {
        
        let http = LD.http
        
        VStack(alignment: .leading, spacing: 8){

            Text("名前：\(http.name)")
            Text("誕生日：\(http.birthday.year)/\(http.birthday.month)/\(http.birthday.day)")
            Text("血液型：\(http.blood_type)")
        }
    }
}
