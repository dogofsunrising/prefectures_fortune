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
                    List(results, id: \.id) { result in
                        
                        NavigationLink(destination: LocalDetailView(LocalData: result)) {
                            Local(LD:result) // リスト内のデータ表示例
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
                Text("\(http.today.year)年\(http.today.month)月\(http.today.day)日の占い結果")
            Text("名前：\(http.name)")
            Text("誕生日：\(http.birthday.year)年\(http.birthday.month)月\(http.birthday.day)日")
            Text("血液型：\(http.blood_type)")
        }
    }
}
