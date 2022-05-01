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
                    content.image = UIImage(data: data)?.withBackground(color: .white)
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

// Source: https://stackoverflow.com/questions/28299886/how-to-set-a-background-color-in-uiimage-in-swift-programming
extension UIImage {
    func withBackground(color: UIColor, opaque: Bool = true) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)

        guard let ctx = UIGraphicsGetCurrentContext(), let image = cgImage else { return self }
        defer { UIGraphicsEndImageContext() }

        let rect = CGRect(origin: .zero, size: size)
        ctx.setFillColor(color.cgColor)
        ctx.fill(rect)
        ctx.concatenate(CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: size.height))
        ctx.draw(image, in: rect)

        return UIGraphicsGetImageFromCurrentImageContext() ?? self
    }
}
