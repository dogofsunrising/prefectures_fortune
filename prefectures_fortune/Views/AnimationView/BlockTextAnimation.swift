//
//  BlockTextAnimation.swift
//  prefectures_fortune
//
//  Created by 藤本皇汰 on 2024/06/30.
//

import SwiftUI

struct BlockTextAnimation: View {
    @Environment(\.colorScheme) var colorScheme
    let characters: Array<String.Element>
    var font: Font

    @State var rectHeight: CGFloat = 0.1
    @State var pathWidth: CGFloat = 100
    @State var pathHeight: CGFloat = 100

    @State var rectScale: Double = 0.0
    @State var rectAnchor: UnitPoint = .leading

    @State var textOpacity: Double = 0.0

    var baseTime: Double = 1.0

    init(text: String, font: Font, startTime: Double) {
        self.characters = Array(text)
        self.font = font
        self.baseTime = startTime
    }

    var body: some View {
        ZStack {
            Text(String(characters))
                .padding()
                .background(colorScheme == .dark ? Color.black.opacity(0.5) : Color.white.opacity(0.5))
                .font(font)
                .opacity(textOpacity)
                .background(GeometryReader{ geometry -> Text in
                    // NavigationLinkなどで遷移した際、
                    // 正しく描画後のサイズが取れないことがあるのでバッファ時間を設ける
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                        rectHeight = geometry.frame(in: .local).height
                        pathWidth = geometry.frame(in: .local).width
                        pathHeight = geometry.frame(in: .local).height
                    }
                    return Text("")
                })

            Rectangle()
                .scale(x: rectScale, y: 1, anchor: rectAnchor)
                .frame(width: pathWidth, height: pathHeight, alignment: .center)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 + baseTime) {
                        withAnimation(.easeInOut) {
                            rectScale = 1
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 + baseTime) {
                        textOpacity = 1.0
                        rectAnchor = .trailing
                        withAnimation(.easeInOut){
                            rectScale = 0.0
                        }
                    }
                }
        }
        .onTapGesture {
            blockAnimation()
        }
    }

    func blockAnimation(){
        rectAnchor = .leading
        textOpacity = 0.0
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.easeInOut) {
                rectScale = 1
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            textOpacity = 1.0
            rectAnchor = .trailing
            withAnimation(.easeInOut){
                rectScale = 0.0
            }
        }
    }
}
