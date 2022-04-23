@testable import Feature_Exercises

extension ExercisesViewController {
    var numberOfItems: Int {
        return collectionView.numberOfSections == 0 ? 0
            : collectionView.numberOfItems(inSection: 0)
    }
}
