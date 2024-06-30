//
//  Realmfortune.swift
//  prefectures_fortune
//
//  Created by 藤本皇汰 on 2024/06/30.
//

import RealmSwift

func SaveRealm(http:HTTP_Body,response:Response_Body){
    
    let realm = try! Realm()

    let Body = RealmData()
    Body.http_name   = http.name
    Body.birth_year  = http.birthday.year
    Body.birth_month = http.birthday.month
    Body.birth_day   = http.birthday.day
    Body.blood_type  = http.blood_type
    Body.today_year  = http.today.year
    Body.today_month = http.today.month
    Body.today_day   = http.today.day
    
    Body.res_name       = response.name
    Body.has_coast_line = response.has_coast_line
    Body.citizen_month  = response.citizen_day?.month ?? 0
    Body.citizen_day    = response.citizen_day?.day ?? 0
    Body.capital        = response.capital
    Body.logo_url       = response.logo_url!
    Body.brief          = response.brief


    try! realm.write {
        realm.add(Body)
    }
}
