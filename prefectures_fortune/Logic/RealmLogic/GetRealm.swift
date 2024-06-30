//
//  GetRealm.swift
//  prefectures_fortune
//
//  Created by 藤本皇汰 on 2024/06/30.
//

import RealmSwift

func GetRealm() -> [LocalData]{
    let realm = try! Realm()
//    var result:[RealmData] = []
    var result:[LocalData] = []
    // データを取得
    let savedCards = realm.objects(RealmData.self)
    
    
    for card in savedCards {
        result.append(
            LocalData(
                id: card.id,
                      http: HTTP_Body(
                        name: card.http_name,
                        birthday: YearMonthDay(
                            year: card.birth_year,
                            month: card.birth_month,
                            day: card.birth_day),
                        blood_type: card.blood_type,
                        today: YearMonthDay(
                            year: card.today_year,
                            month: card.today_month,
                            day: card.today_day)
                      ),
                      response: Response_Body(
                        name: card.res_name,
                        has_coast_line: card.has_coast_line,
                        citizen_day: MonthDay(
                            month: card.citizen_month,
                            day: card.citizen_day),
                        capital: card.capital,
                        logo_url: card.logo_url,
                        brief: card.brief
                      )
            )
            
            )
    }
    return result
}
