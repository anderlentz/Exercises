import Combine
import CoreUI
import SwiftUI
import UIKit

public class ExerciseDetailsViewController: UIViewController {
    
    private(set) var carrouselViewController: UIHostingController<CarrouselView>?
    private(set) var exercisesViewController: UICollectionViewController?
    private(set) var viewModel: ExerciseDetailsViewModel?
    private(set) var theView = ExerciseDetailsView()
    
    public convenience init(
        viewModel: ExerciseDetailsViewModel,
        carrouselViewController: UIHostingController<CarrouselView>,
        exercisesViewController: UICollectionViewController
    ) {
        self.init()
        self.viewModel = viewModel
        self.carrouselViewController = carrouselViewController
        self.exercisesViewController = exercisesViewController
      }
    
    public override func loadView() {
        view = theView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel?.title ?? ""
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground
        
        addCarrouselViewController()
        addExercisesViewController()
        
    }
    
    private func addCarrouselViewController() {
        guard let vc = carrouselViewController else {
            return
        }
        self.addChild(vc)
        
        vc.view.frame = theView.imagesContainer.frame
        
        self.view.addSubview(vc.view)
        
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        vc.view.topAnchor.constraint(equalTo: self.theView.imagesContainer.topAnchor).isActive = true
        vc.view.bottomAnchor.constraint(equalTo: self.theView.imagesContainer.bottomAnchor).isActive = true
        vc.view.leftAnchor.constraint(equalTo: self.theView.imagesContainer.leftAnchor).isActive = true
        vc.view.rightAnchor.constraint(equalTo: self.theView.imagesContainer.rightAnchor).isActive = true
        
        vc.didMove(toParent: self)
    }
    
    private func addExercisesViewController() {
        guard let vc = exercisesViewController else {
            return
        }
        self.addChild(vc)
        
        vc.view.frame = theView.exerciseVariationsContainer.exercisesContainer.frame
        
        self.view.addSubview(vc.view)

        vc.view.translatesAutoresizingMaskIntoConstraints = false
        vc.view.topAnchor.constraint(equalTo: self.theView.exerciseVariationsContainer.exercisesContainer.topAnchor).isActive = true
        vc.view.bottomAnchor.constraint(equalTo: self.theView.exerciseVariationsContainer.exercisesContainer.bottomAnchor).isActive = true
        vc.view.leftAnchor.constraint(equalTo: self.theView.exerciseVariationsContainer.exercisesContainer.leftAnchor).isActive = true
        vc.view.rightAnchor.constraint(equalTo: self.theView.exerciseVariationsContainer.exercisesContainer.rightAnchor).isActive = true

        vc.didMove(toParent: self)
    }
    
}
