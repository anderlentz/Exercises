import Foundation
import Feature_Exercises
import Shared_DataLoader

public final class ExercisesComposer {
    
    public static func composedWith(
        exercisesLoader: ExercisesLoaderProtocol,
        remoteImageLoader: ImageLoader,
        onExerciseVariationSelected: @escaping (Exercise) -> Void
    ) -> ExercisesViewController {
        let exercisesViewModel = ExercisesViewModel(
            exercisesLoader: exercisesLoader,
            imageLoader: remoteImageLoader,
            onExerciseVariationSelected: onExerciseVariationSelected
        )
        return ExercisesViewController(viewModel: exercisesViewModel)
    }
    
}
