import CoreUI
import Feature_Exercises
import Feature_ExerciseDetails
import Shared_DataLoader
import SwiftUI

public protocol VariationExercisesLoaderProtocol: ExercisesLoaderProtocol {
    init(exerciseIDs: [Int])
}

public final class ExerciseDetailsComposer {
    public static func composedWith(
        exercise: Exercise,
//        remoteImageLoader: RemoteImageLoader,
        onExerciseVariationSelected: @escaping (Exercise) -> Void,
        exercisesLoader: VariationExercisesLoaderProtocol
    ) -> ExerciseDetailsViewController {
        let viewModel = ExerciseDetailsViewModel(title: exercise.title)
//        let imageURLs
        
        let imagePaths = exercise.imagePaths.compactMap { $0 }
        
        let carrouselViewController = UIHostingController(
            rootView: CarrouselView(
                viewModel: CarrouselViewModel(
                    imageURLs: imagePaths.map { URL(string: $0)! }
                )
            )
        )
        
        let exercisesViewModel = ExercisesViewModel(exercisesLoader: exercisesLoader, onExerciseVariationSelected: onExerciseVariationSelected)
        let exerciseViewController = ExercisesViewController(viewModel: exercisesViewModel)
        
        return ExerciseDetailsViewController(
            viewModel: viewModel,
            carrouselViewController: carrouselViewController,
            exercisesViewController: exerciseViewController
        )
    }
}
