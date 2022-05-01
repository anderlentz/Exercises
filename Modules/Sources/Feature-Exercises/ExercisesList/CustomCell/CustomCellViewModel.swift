import Combine
import Foundation
import Shared_DataLoader

class CustomCellViewModel {
    @Published var exercise: Exercise
    @Published var imageData: Data?
    
    private let imageLoader: ImageLoader
    private var cancellables: Set<AnyCancellable> = []
    
    init(
        exercise: Exercise,
        imageLoader: ImageLoader
    ) {
        self.exercise = exercise
        self.imageLoader = imageLoader
    }
    
    func loadImage() {
        guard let imagePath = exercise.imagePaths.first as? String,
              let imageURL = URL(string: imagePath) else {
            return
        }
        
        imageLoader
            .load(imageURL)
            .sink(
                receiveCompletion: { [weak self] result in
                    switch result {
                    case .failure:
                        self?.imageData = nil
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] data in
                    self?.imageData = data
                }
            )
            .store(in: &cancellables)
    }
}
