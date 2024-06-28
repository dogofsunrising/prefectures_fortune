//
//  fortune_data.swift
//  prefectures_fortune
//
//  Created by 藤本皇汰 on 2024/06/27.
//

import SwiftUI

public struct HTTP_Body: Codable  {
    var name :String
    var birthday : YearMonthDay
    var blood_type: String
    var today : YearMonthDay
}
