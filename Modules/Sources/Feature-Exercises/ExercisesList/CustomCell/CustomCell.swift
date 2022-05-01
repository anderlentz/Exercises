import Combine
import UIKit

class CustomCell: UICollectionViewListCell {
    private var cancellables: Set<AnyCancellable> = []
    
    var viewModel: CustomCellViewModel? {
        didSet {
            update()
        }
    }
    
    private func update() {
        guard let viewModel = viewModel else {
            return
        }
        var content = defaultContentConfiguration()
        
        viewModel
            .$imageData
            .sink(receiveValue: { data in
                guard let data = data ?? UIImage(named: "default-placeholder")?.pngData() else {
                    return
                }
                DispatchQueue.main.async {
                    var content = self.defaultContentConfiguration()
                    content.imageProperties.maximumSize = CGSize(width: 30, height: 30)
                    content.image = UIImage(data: data)
                    content.text = viewModel.exercise.title
                    self.contentConfiguration = content
                }
            })
            .store(in: &cancellables)
        
        viewModel.loadImage()
                
        content.text = viewModel.exercise.title
        contentConfiguration = content
    }
    

}
