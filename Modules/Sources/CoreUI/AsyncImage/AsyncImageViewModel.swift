import Combine
import Foundation
import Shared_DataLoader
import SwiftUI

public class AsyncImageViewModel: ObservableObject {
    @Published var image: UIImage?
    
    private let imageLoader: RemoteImageLoader
    private var cancellable: AnyCancellable?
    
    public init(imageLoader: RemoteImageLoader) {
        self.imageLoader = imageLoader
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    public func load(url: URL) {
        cancellable = imageLoader
            .load(url)
            .tryMap { UIImage(data: $0) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }
}
