//
//  router.swift
//  prefectures_fortune
//
//  Created by 藤本皇汰 on 2024/06/27.
//

import SwiftUI
import UIKit

public enum Router:Hashable{
    case input
    case output

    @ViewBuilder
    var view: some View {
        switch self {
        case .input:
            InputView()
        case .output:
            OutputView()
        }
    }
}
