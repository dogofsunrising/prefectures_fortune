
import UIKit
import SwiftUI

public protocol Wireframe {

    // MARK: - Views

    func instantiateInput(input: LaunchScreenInput) -> AnyView
    
}

public struct LaunchScreenInput {
    public init() {}
}
