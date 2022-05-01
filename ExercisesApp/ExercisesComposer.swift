import Foundation
import Feature_Exercises

public final class ExercisesComposer {
    
    public static func composedWith(
        exercisesLoader: ExercisesLoaderProtocol,
        onExerciseVariationSelected: @escaping (Exercise) -> Void
    ) -> ExercisesViewController {
        let exercisesViewModel = ExercisesViewModel(exercisesLoader: exercisesLoader, onExerciseVariationSelected: onExerciseVariationSelected)
        return ExercisesViewController(viewModel: exercisesViewModel)
    }
    
}
