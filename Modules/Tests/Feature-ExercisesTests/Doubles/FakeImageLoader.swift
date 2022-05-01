import Combine
import Foundation
import Shared_DataLoader

class FakeImageLoader: ImageLoader {
    
    var load: (URL) -> AnyPublisher<Data, Error> = { _ in
        Just(Data())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
}
