//
//  fortuneAPI.swift
//  prefectures_fortune
//
//  Created by 藤本皇汰 on 2024/06/28.
//

import SwiftUI


func getFortune(HTTPbody: HTTP_Body) async -> Response_Body? {
    guard let url = URL(string: "https://yumemi-ios-junior-engineer-codecheck.app.swift.cloud/my_fortune") else {
        print("Invalid URL")
        return nil
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("v1", forHTTPHeaderField: "API-Version")

    guard let httpBody = try? JSONEncoder().encode(HTTPbody) else {
        print("Failed to encode JSON")
        return nil
    }

    request.httpBody = httpBody

    do {
        let (data, _) = try await URLSession.shared.data(for: request)
//        if let jsonString = String(data: data, encoding: .utf8) {
//                    print("Received JSON: \(jsonString)")
//                }
        let decodedData = try JSONDecoder().decode(Response_Body.self, from: data)
        return decodedData
    } catch {
        print("Error: \(error.localizedDescription)")
        return nil
    }
}


