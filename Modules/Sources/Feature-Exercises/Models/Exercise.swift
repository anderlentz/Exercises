import Foundation

public struct Exercise: Hashable {
    let title: String
    let image: Data?
    
    public init(title: String, image: Data? = nil) {
        self.title = title
        self.image = image
    }
}
