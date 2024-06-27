//
//  router.swift
//  prefectures_fortune
//
//  Created by 藤本皇汰 on 2024/06/27.
//


import SwiftUI
import UIKit

// Router Enum
public enum Router: Hashable {
    case input
    case output

    @ViewBuilder
    func view(data: HTTP_Body) -> some View {
        switch self {
        case .input:
            InputView()
        case .output:
            OutputView(data: data)
        }
    }
}
