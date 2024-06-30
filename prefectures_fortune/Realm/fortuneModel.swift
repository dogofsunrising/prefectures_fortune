////
////  fortuneModel.swift
////  prefectures_fortune
////
////  Created by 藤本皇汰 on 2024/06/29.
////
//
import Foundation
import RealmSwift

class RealmData: Object {
    @objc dynamic var id = UUID().uuidString
    
    @objc dynamic var http_name = ""
    @objc dynamic var birth_year = 0
    @objc dynamic var birth_month = 0
    @objc dynamic var birth_day = 0
    @objc dynamic var blood_type = ""
    @objc dynamic var today_year = 0
    @objc dynamic var today_month = 0
    @objc dynamic var today_day = 0
    
    @objc dynamic var res_name = ""
    @objc dynamic var has_coast_line = true
    @objc dynamic var citizen_month = 0
    @objc dynamic var citizen_day = 0
    @objc dynamic var capital = ""
    @objc dynamic var logo_url = ""
    @objc dynamic var brief = ""
    
    

    override static func primaryKey() -> String? {
        return "id"
    }
}



