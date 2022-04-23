import Foundation
import UIKit

class ExerciseDetailsViewController: UIViewController {
    
    private let viewModel: ExerciseDetailsViewModel
    
    public init(viewModel: ExerciseDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
}
