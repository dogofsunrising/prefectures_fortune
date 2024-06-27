

import SwiftUI

struct OutputView: View {
    let data:HTTP_Body
    var body: some View {
        VStack(spacing: 4){
           ResultView
        }
    }
    
}

extension OutputView{
    var ResultView: some View{
        Text(data.name)
    }
}
