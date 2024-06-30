//
//  DeleteRealm.swift
//  prefectures_fortune
//
//  Created by 藤本皇汰 on 2024/06/30.
//

import Foundation
import RealmSwift


func DeleteRealm(){
    let realm = try! Realm()

    try! realm.write {
        realm.deleteAll()
    }
}
