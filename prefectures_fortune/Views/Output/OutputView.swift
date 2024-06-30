

import SwiftUI

struct OutputView: View {
    @State private var result: Response_Body?
   let HTTPbody: HTTP_Body
   @State private var errorMessage: String?
    
   var body: some View {
       VStack(spacing: 4) {
           if let result = result {
               ResultView
           } else if let errorMessage = errorMessage {
               Text("Error: \(errorMessage)")
           } else {
               Text("Fetching fortune...")
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
       }
       .padding()
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
                        
                        
                        Text("\(name)")
                        
                        
                        Text("海岸線\(coast ? "はある" : "はない")")
                        
                        if let citizenDay = result.citizen_day {
                            Text("Citizen Day: \(citizenDay.month)/\(citizenDay.day)")
                        }
                        
                        Text("首都は\(capital)")
                        
                        
                        if let logoUrlString = result.logo_url, let logoUrl = URL(string: logoUrlString) {
                            AsyncImageView(url: logoUrl)
                                .frame(width: 100, height: 100) // 適切なサイズに設定してください
                        }
                        
                      
                        Text("概要\n" + brief)
                            .padding()
                        
                        
                        
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


