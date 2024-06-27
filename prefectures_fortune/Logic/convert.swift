//
//  convert.swift
//  prefectures_fortune
//
//  Created by 藤本皇汰 on 2024/06/27.
//

import Foundation

func convertToInt(_ numberString: String) -> Int? {
    if let intValue = Int(numberString) {
        return intValue
    } else {
        print("Error: 数字をIntに変換できません: \(numberString)")
        return nil
    }
}
