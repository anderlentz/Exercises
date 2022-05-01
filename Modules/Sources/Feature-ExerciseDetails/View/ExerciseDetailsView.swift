import Foundation
import UIKit

class ExerciseDetailsView: UIView {
    
    let imagesContainer: UIView
    let exerciseVariationsContainer: ExerciseVariationsContainerView
    
    override init(frame: CGRect) {
        imagesContainer = UIView()
        exerciseVariationsContainer = ExerciseVariationsContainerView()
        super.init(frame: frame)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubview(imagesContainer)
        addSubview(exerciseVariationsContainer)
        
        imagesContainer.translatesAutoresizingMaskIntoConstraints = false
        exerciseVariationsContainer.translatesAutoresizingMaskIntoConstraints = false
        
        imagesContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        imagesContainer.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        imagesContainer.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        imagesContainer.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        exerciseVariationsContainer.topAnchor.constraint(equalTo: imagesContainer.bottomAnchor, constant: 16).isActive = true
        exerciseVariationsContainer.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        exerciseVariationsContainer.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        exerciseVariationsContainer.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
//        imagesContainer.backgroundColor = .clear
        exerciseVariationsContainer.backgroundColor = .clear
    }
}
