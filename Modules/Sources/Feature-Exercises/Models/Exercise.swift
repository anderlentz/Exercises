import Foundation

public struct Exercise: Hashable {
    let id: Int
    let title: String
    let image: Data?
    
    public init(id: Int, title: String, image: Data? = nil) {
        self.id = id
        self.title = title
        self.image = image
    }
}
