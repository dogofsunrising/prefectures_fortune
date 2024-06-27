//
//  validation_input.swift
//  prefectures_fortune
//
//  Created by 藤本皇汰 on 2024/06/27.
//

import SwiftUI

public class Validation_input {
    private var name: String
       private var birth: YearMonthDay
       private var blood: String
       private var errorMessage: String = ""
       
       public init(name: String, birth: YearMonthDay, blood: String) {
           self.name = name
           self.birth = birth
           self.blood = blood
       }
    
    
    var hasError: String {
        print(errorMessage)
        return errorMessage
    }
    
    
    public func validation(){
        validation_name()
        validation_birth()
        validation_blood()
    }
    private func validation_name() {
        if(name.isEmpty){
            
            errorMessage += "名前の入力がされていません\n"
        }
    }
    
    private func validation_birth() {
        if !isValidDate(year: birth.year, month: birth.month, day: birth.day){
            errorMessage += "日付の入力が正しくありません\n"
        }
        
    }
    
    private func validation_blood() {
        if(blood.isEmpty){
            errorMessage += "血液型の入力がされていません\n"
        }
    }
    
    private func isValidDate(year: Int, month: Int, day: Int) -> Bool {
        // 年と月の基本範囲チェック
        if year < 0{
            return false
        }
        if month < 1 || month > 12 {
            return false
        }
        
        // 日付の範囲チェック
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        let calendar = Calendar.current
        if let date = calendar.date(from: dateComponents) {
            // 作成した日付から逆にDateComponentsを取得し、入力値と比較する
            let components = calendar.dateComponents([.year, .month, .day], from: date)
            return components.year == year && components.month == month && components.day == day
        } else {
            return false
        }
    }
    
    
}
