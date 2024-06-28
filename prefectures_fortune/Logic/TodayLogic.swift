//
//  TodayLogic.swift
//  prefectures_fortune
//
//  Created by 藤本皇汰 on 2024/06/29.
//

import Foundation
func Today() -> (YearMonthDay) {
    let currentDate = Date()
    let calendar = Calendar.current

    let year = calendar.component(.year, from: currentDate)
    let month = calendar.component(.month, from: currentDate)
    let day = calendar.component(.day, from: currentDate)

    return YearMonthDay(year: year, month: month, day: day)
}

