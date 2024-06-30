//
//  BlinkwithBlur.swift
//  prefectures_fortune
//
//  Created by 藤本皇汰 on 2024/06/30.
//

import SwiftUI

struct BlinkingWithBlur: View {
    let characters: Array<String.Element>
    let fontName: String
    let baseTime: Double
    let textSize: Double

    @State var blurValue: Double = 10
    @State var opacity: Double = 0

    init(text:String, fontName: String, textSize: Double, startTime: Double) {
        self.characters = Array(text)
        self.fontName = fontName
        self.textSize = textSize
        self.baseTime = startTime
    }

    var body: some View {

        HStack(spacing: 0.5){
            ForEach(0..<characters.count) { num in
                ZStack{
                    Text(String(self.characters[num]))
                        .font(.custom(fontName, fixedSize: textSize * 1.0))
                        .blur(radius: blurValue)
                        .opacity(opacity)
                        .animation(.easeInOut.delay( baseTime + Double(num) * 0.5 * Double.random(in: 0.003...0.55)),
                                   value: blurValue)

                    Text(String(self.characters[num]))
                        .font(.custom(fontName, fixedSize: textSize * 0.9))
                        .blur(radius: blurValue)
                        .foregroundColor(.white)
                        .opacity(opacity)
                        .animation(.easeInOut.delay( baseTime + Double(num) * 0.5 * Double.random(in: 0.003...0.55)),
                                   value: blurValue)

                    Text(String(self.characters[num]))
                        .font(.custom(fontName, fixedSize: textSize*1.0))
                        .blur(radius: blurValue)
                        .opacity(opacity)
                        .animation(.easeInOut.delay( baseTime + Double(num) * 1 * Double.random(in: 0.10...0.3)),
                                   value: blurValue)
                }
            }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + baseTime) {
                if blurValue == 0{
                    blurValue = 10
                    opacity = 0.01
                } else {
                    blurValue = 0
                    opacity = 1
                }
            }
        }
    }
}
