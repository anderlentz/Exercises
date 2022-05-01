import Foundation
import UIKit

class ExerciseVariationsContainerView: UIView {
    let titleLabel: UILabel
    let exercisesContainer: UIView
    
    override init(frame: CGRect) {
        titleLabel = UILabel()
        exercisesContainer = UIView()
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubview(titleLabel)
        addSubview(exercisesContainer)
        
        titleLabel.text = "Exercise Variations"
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        exercisesContainer.translatesAutoresizingMaskIntoConstraints = false
        exercisesContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        exercisesContainer.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        exercisesContainer.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        exercisesContainer.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        exercisesContainer.backgroundColor = .clear
    }
}
