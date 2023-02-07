
import UIKit

protocol ReusableView {
    static var identifier: String { get }
}

extension ReusableView {
    static var identifier: String {
        return String(describing: Self.self)
    }
}
