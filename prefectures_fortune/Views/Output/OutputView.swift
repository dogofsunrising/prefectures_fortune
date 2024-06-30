

import SwiftUI

struct OutputView: View {
    @State private var result: Response_Body?
   let HTTPbody: HTTP_Body
   @State private var errorMessage: String?
    
   var body: some View {
       ZStack{
           Image("土地")
               .resizable()
               .scaledToFill()
               .ignoresSafeArea()
           ScrollView{
       VStack(spacing: 4) {
           
           if let result = result {
               ResultView
           } else if let errorMessage = errorMessage {
               Text("Error: \(errorMessage)")
           } else {
               ProgressView("あなたの都道府県を占っています")
                                   .progressViewStyle(CircularProgressViewStyle())
                                   .padding()
                   .onAppear {
                       Task {
                           result = await getFortune(HTTPbody: HTTPbody)
                           
                           
                           
                           if result == nil {
                               errorMessage = "入力が正しくありません"
                           } else{
                               SaveRealm(http: HTTPbody, response: result!)
                           }
                       }
                   }
           }
           }.padding()
           }
       }
       
   }


}

extension OutputView{
    
    var ResultView: some View{
        
            VStack {
                if let result = result {
                    var name = result.name
                    var coast = result.has_coast_line
                    var capital = result.capital
                    var brief = result.brief
                    
                    BlinkingWithBlur(text: "\(name)",
                                     fontName: "default",
                                     textSize: 60,
                                     startTime: 0.1)
                    BlinkingWithBlur(text: "首都は\(capital)",
                                     fontName: "default",
                                     textSize: 30,
                                     startTime: 0.1)
                    BlinkingWithBlur(text: "海岸線\(coast ? "○" : "×")",
                                     fontName: "default",
                                     textSize: 20,
                                     startTime: 0.1)
                    if let citizenDay = result.citizen_day {
                        BlinkingWithBlur(text: "県民の日: \(citizenDay.month)/\(citizenDay.day)",
                                         fontName: "default",
                                         textSize: 20,
                                         startTime: 0.1)
                    }else{
                        BlinkingWithBlur(text: "県民の日: なし",
                                         fontName: "default",
                                         textSize: 20,
                                         startTime: 0.1)
                    }
                    
                    
                    
                    if let logoUrlString = result.logo_url, let logoUrl = URL(string: logoUrlString) {
                        AsyncImageView(url: logoUrl)
                            .frame(width: 300, height: 300) // 適切なサイズに設定してください
                    }
                    
                    
                    BlockTextAnimation(text: "概要\n" + brief,
                                       font: .title3,
                                       startTime: 1.0)
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                } else if let errorMessage = errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                } else {
                    Text("Result will be shown here")
                }
                
            }
            .padding()
    }
}



