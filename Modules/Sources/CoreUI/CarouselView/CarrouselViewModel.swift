import Foundation
import Combine
import Shared_DataLoader
import SwiftUI

public class CarrouselViewModel: ObservableObject {
    @Published var loadedImageData: Data?
    
    private(set) var imageURLs: [URL]
    private var cancellables: Set<AnyCancellable> = []
    private let imageLoader: RemoteImageLoader
    
    public init(
        imageURLs: [URL],
        imageLoader: RemoteImageLoader = RemoteImageLoader()
    ) {
        self.imageURLs = imageURLs
        self.imageLoader = imageLoader
    }
    
    func loadImage(url: URL) {
        loadedImageData = nil
        imageLoader
            .load(url)
            .sink { _ in
                
            } receiveValue: { data in
                DispatchQueue.main.async { [weak self] in
                    self?.loadedImageData = data
                }
            }
            .store(in: &cancellables)
    }
}
