import SwiftUI

struct InputView: View {
    @State private var path = NavigationPath()
    @State private var username: String = "name"
    @State private var userbirth_year: String = "2000"
    @State private var userbirth_month: String = "1"
    @State private var userbirth_day: String = "1"
    @State private var userblood: String = "ab"
    @State private var errorMessage: Bool = false
    
    @State private var userbirth:YearMonthDay = YearMonthDay(year: 2000, month: 1, day: 1)
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 4) {
                textFieldList
                runButton
                
                errorMessageView(error: errorMessage)
            }
            .navigationDestination(for: Router.self) { value in
                let sampleData = HTTP_Body(
                            name: "ゆめみん",
                            birthday: YearMonthDay(year: 2000, month: 1, day: 27),
                            blood_type: "ab",
                            today: YearMonthDay(year: 2023, month: 5, day: 5)
                        )
                value.view(data: HTTP_Body(name: username, birthday: userbirth, blood_type: userblood, today: userbirth))
//                value.view(data: sampleData)
            }
        }
    }
}



extension InputView {
    //View
    var textFieldList: some View {
        VStack {
            customTextField(text: $username, title: "名前を入力してください")
            customTextField(text: $userbirth_year, title: "生年を入力してください")
            customTextField(text: $userbirth_month, title: "生月を入力してください")
            customTextField(text: $userbirth_day, title: "生日を入力してください")
            customTextField(text: $userblood, title: "血液型を入力してください")
        }
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
                
                path.append(Router.output)
            }
        }) {
            Text("Button")
        }
    }
    
    
    //func
    func customTextField(text: Binding<String>, title: String) -> some View {
        TextField(
            title,
            text: text
        )
        .onSubmit {
            // validate(name: text.wrappedValue)
        }
        .textInputAutocapitalization(.never)
        .disableAutocorrection(true)
        .border(.secondary)
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
