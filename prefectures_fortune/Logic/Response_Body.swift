//
//  Response_Body.swift
//  prefectures_fortune
//
//  Created by 藤本皇汰 on 2024/06/28.
//

import Foundation
public struct Response_Body: Codable {
    let name: String
    let has_coast_line: Bool
    let citizen_day: MonthDay?
    let capital: String
    let logo_url: String
    let brief: String
}
