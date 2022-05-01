import Foundation
import Combine

public protocol ImageLoader {
    var load: (_ url: URL) -> AnyPublisher<Data,Error> { get set }
}

public struct RemoteImageLoader: ImageLoader {
    
    public init() { }
    
    public var load: (_ url: URL) -> AnyPublisher<Data,Error> = { url in
        URLSession
            .shared
            .dataTaskPublisher(for: url)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                return element.data
            }
            .eraseToAnyPublisher()
    }
}
