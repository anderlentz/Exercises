import Foundation

public struct Exercise: Hashable {
    public let id: Int
    public let title: String
    public let variations: [Int?]
    public let imagePaths: [String?]
    let image: Data?
    
    public init(
        id: Int,
        title: String,
        variations: [Int?],
        imagePaths: [String?],
        image: Data? = nil
    ) {
        self.id = id
        self.title = title
        self.variations = variations
        self.imagePaths = imagePaths
        self.image = image
    }
}
