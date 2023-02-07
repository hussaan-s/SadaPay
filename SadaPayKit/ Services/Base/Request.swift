import Foundation
import Networking

public struct Request: URLRequestConvertible {
    
    let base: String
    
    init(base: String) {
        self.base = base
    }
    
    public var urlRequest: URLRequest? {
        
        guard let url = URL(string: base) else {
            return nil
        }
        
        return URLRequest(url: url)
        
    }
}
