import SwiftUI

struct InputView: View {
    @State private var path = NavigationPath()
    @State private var username: String = "aaa"
    @State private var userbirth_year: String = "2000"
    @State private var userbirth_month: String = "1"
    @State private var userbirth_day: String = "1"
    @State private var userblood: String = "ab"
    @State private var errorMessage: Bool = false
    
    @FocusState var isFocused: Bool
    @State var userbirth:YearMonthDay = YearMonthDay(year: 0, month: 0, day: 0)
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 4) {
                texttitle
                textFieldList
                runButton
                
                errorMessageView(error: errorMessage)
            }
            .navigationDestination(for: Router.self) { value in
//                let sampleData = HTTP_Body(
//                            name: "ゆめみん",
//                            birthday: YearMonthDay(year: 2000, month: 1, day: 27),
//                            blood_type: "ab",
//                            today: YearMonthDay(year: 2023, month: 5, day: 5)
//                        )
                
                if let year = convertToInt(userbirth_year),
                   let month = convertToInt(userbirth_month),
                   let day = convertToInt(userbirth_day) {
                    value.view(data: HTTP_Body(name: username, birthday: YearMonthDay(year: year, month: month, day: day), blood_type: userblood, today: Today()))
//                    value.view(data: sampleData)
                }
            }
            
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                        Button(action:{
                            path.append(Router.local)
                        }) {
                            Text("占いの履歴を見る")
                        }
                }
            }
        }
    }
}



extension InputView {
    //View
    
    var texttitle: some View {
        VStack {
               Text("都道府県占いアプリ")
        }
    }
    
    
    var textFieldList: some View {
        VStack {
            Button(action:{
                DeleteRealm()
            }) {
                Text("test")
            }
                customTextField(text: $username, title: "名前を入力してください")
                customTextField(text: $userbirth_year, title: "生年を入力してください")
                customTextField(text: $userbirth_month, title: "生月を入力してください")
                customTextField(text: $userbirth_day, title: "生日を入力してください")
                customTextField(text: $userblood, title: "血液型を入力してください")
            
        }.textFieldStyle(.roundedBorder)
            .padding()
    }
    
    
    
    var runButton: some View {
        Button(action: {
            errorMessage = false
            if let year = convertToInt(userbirth_year),
               let month = convertToInt(userbirth_month),
               let day = convertToInt(userbirth_day) {
                userbirth = YearMonthDay(year: year, month: month, day: day)
            } else {
                errorMessage = true
            }
            
            
            let validator = Validation_input(name: username, birth: userbirth, blood: userblood)
            validator.validation()
            // 他のバリデーションも追加できる
            
            if validator.hasError != "" {
                errorMessage = true
            }
            
            if !errorMessage{
               
                isFocused = false
                path.append(Router.output)
            }
        }) {
            Text("占う")
        }
    }
    
    
    //func
    func customTextField(text: Binding<String>, title: String) -> some View {
        
            TextField(
                title,
                text: text
            )
            .focused($isFocused)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
           
    }
    
    @ViewBuilder
    func errorMessageView(error: Bool) -> some View {
        if error {
            Text("入力が適切ではありません")
                .foregroundColor(.red)
        } else {
            EmptyView()
        }
    }
}
