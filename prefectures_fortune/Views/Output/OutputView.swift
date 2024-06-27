

import SwiftUI

struct OutputView: View {
    
    var body: some View {
        VStack(spacing: 4){
           ResultView
        }.navigationDestination(for: Router.self) { value in
            value.view
        }
    }
    
}

extension OutputView{
    var ResultView: some View{
        Text("pppp")
    }
}
