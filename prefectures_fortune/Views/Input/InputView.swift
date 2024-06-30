import SwiftUI

struct InputView: View {
    @State private var isBlurred: Bool = true
    
    @State private var path = NavigationPath()
    @State private var username: String = ""
    @State private var userbirth_year: String = ""
    @State private var userbirth_month: String = ""
    @State private var userbirth_day: String = ""
    @State private var userblood: String = ""
    @State private var errorMessage: Bool = false
    
    @FocusState var isFocused: Bool
    @State var userbirth:YearMonthDay = YearMonthDay(year: 0, month: 0, day: 0)
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack{
                Image("魔法")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                VStack(spacing: 4) {
                    texttitle
                    textFieldList
                    runButton
                    
                    errorMessageView(error: errorMessage)
                }
                .blur(radius: isBlurred ? 100 : 0)
                    .onAppear {
                        withAnimation(.easeInOut.delay(0.5)) {
                        isBlurred = false
                    }
                }
                .navigationDestination(for: Router.self) { value in
                    //                let sampleData = HTTP_Body(
                    //                            name: "ゆめみん",
                    //                            birthday: YearMonthDay(year: 2000, month: 1, day: 27),
                    //                            blood_type: "ab",
                    //                            today: YearMonthDay(year: 2023, month: 5, day: 5)
                    //                        )
                    if(value == Router.output){
                        if let year = convertToInt(userbirth_year),
                           let month = convertToInt(userbirth_month),
                           let day = convertToInt(userbirth_day) {
                            value.view(data: HTTP_Body(name: username, birthday: YearMonthDay(year: year, month: month, day: day), blood_type: userblood, today: Today()))
                            //                    value.view(data: sampleData)
                        }
                    }else if(value == Router.local){
                        value.view(data: HTTP_Body(name: username, birthday: YearMonthDay(year: 0, month: 0, day: 0), blood_type: userblood, today: Today()))
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
}



extension InputView {
    //View
    
    var texttitle: some View {
        VStack {
               Text("都道府県占いアプリ")
                .font(.largeTitle)
                .bold()
                .foregroundColor(lightblue)
            
        }
    }
    
    
    var textFieldList: some View {
        VStack {
//            Button(action:{
//                DeleteRealm()
//            }) {
//                Text("test")
//            }
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
            
            HStack{
                
                   Image(systemName: "globe.asia.australia")
                    Text("占う")
                Image(systemName: "globe.asia.australia")
                
                    
            }
            .bold()
            .padding()
            .frame(width: 200, height: 50)
            .foregroundColor(Color.white)
            .background(Color.blue)
            .cornerRadius(25)
            
        }
    }
    
    
    //func
    func customTextField(text: Binding<String>, title: String) -> some View {
        
            TextField(
                title,
                text: text
            )
            .opacity(0.9)
            .font(.system(size: 30))
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
