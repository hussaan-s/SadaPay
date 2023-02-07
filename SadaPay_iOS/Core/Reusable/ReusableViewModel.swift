import Foundation

protocol ReusableViewModel {
    var identifier: String { get }
}

extension ReusableViewModel {
    var identifier: String {
        return String(describing: Self.self)
    }
}

