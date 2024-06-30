//
//  LocalData.swift
//  prefectures_fortune
//
//  Created by 藤本皇汰 on 2024/06/30.
//

import Foundation
struct LocalData: Codable {
    var id: String
    var http:HTTP_Body
    var response: Response_Body
}
