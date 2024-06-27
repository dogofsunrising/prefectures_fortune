
import SwiftUI

struct InputView: View {
    @State private var path = NavigationPath()
    @State private var username: String = ""
    @State private var userbirth: String = ""
    @State private var userblood: String = ""
    var body: some View {
        NavigationStack(path: $path){
            VStack(spacing: 4){
                TextFieldList
                RunBottun
            }.navigationDestination(for: Router.self) { value in
                value.view
            }
        }
    }
    
}

extension InputView{
    var TextFieldList: some View{
        VStack{
            customTextField(text: $username,title: "名前を入力してください")
            customTextField(text: $userbirth, title: "生年月日を入力してください")
            customTextField(text: $userblood, title: "血液型を入力してください")
        }
    }
    
    func customTextField(text: Binding<String>,title: String) -> some View {
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
    
    var RunBottun: some View{
        VStack{
            Button(action: {
                path.append(Router.output)
            }) {
                Text("Button")
            }
        }
    }
}
