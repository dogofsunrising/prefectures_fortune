

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
                   .onAppear(perform: getFortune)
           }
       }
       .padding()
   }

   func getFortune() {
       guard let url = URL(string: "https://yumemi-ios-junior-engineer-codecheck.app.swift.cloud/my_fortune") else {
           print("Invalid URL")
           return
       }

       var request = URLRequest(url: url)
       request.httpMethod = "POST"
       request.setValue("application/json", forHTTPHeaderField: "Content-Type")
       request.setValue("v1", forHTTPHeaderField: "API-Version")

       guard let httpBody = try? JSONEncoder().encode(HTTPbody) else {
           print("Failed to encode JSON")
           return
       }

       request.httpBody = httpBody

       URLSession.shared.dataTask(with: request) { data, response, error in
           if let error = error {
               DispatchQueue.main.async {
                   print("URLSessionError:" + error.localizedDescription)
                   self.errorMessage = error.localizedDescription
               }
               return
           }

           guard let data = data else {
               DispatchQueue.main.async {
                   print("dataError:" + "No data received")
                   self.errorMessage = "No data received"
               }
               return
           }

           
           do {
               let decodedData = try JSONDecoder().decode(Response_Body.self, from: data)
               DispatchQueue.main.async {
                   self.result = decodedData
                   self.errorMessage = nil
               }
           } catch {
               DispatchQueue.main.async {
                   
                   print(error)
                   print(error.localizedDescription)
                   self.errorMessage = "Failed to decode JSON: \(error.localizedDescription)"
               }
           }
       }.resume()
   }

}

extension OutputView{
    var ResultView: some View{
        VStack {
                    if let result = result {
                        Text("Name: \(result.name)")
                        Text("Has Coast Line: \(result.has_coast_line ? "Yes" : "No")")
//                        Text("Citizen Day: \(result.citizen_day.month)/\(result.citizen_day.day)")
                        Text("Capital: \(result.capital)")
                        if let url = URL(string: result.logo_url),
                           let data = try? Data(contentsOf: url),
                           let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                        }
                        Text(result.brief)
                            .padding()
                    } else if let errorMessage = errorMessage {
                        Text("Error: \(errorMessage)")
                            .foregroundColor(.red)
                    } else {
                        Text("Result will be shown here")
                    }

                    Button(action: {
                        getFortune()
                    }) {
                        Text("Get Fortune")
                    }
                }
                .padding()
    }
}


