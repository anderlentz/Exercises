import Foundation
import Combine

public class ExercisesViewModel {
    @Published var exercises: [Exercise] = []
    
    private let exercisesLoader: ExercisesLoaderProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    public init(exercisesLoader: ExercisesLoaderProtocol) {
        self.exercisesLoader = exercisesLoader
    }
    
    func loadExercises() {
        exercisesLoader
            .load()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] exercises in
                    self?.exercises = exercises
                }
            )
            .store(in: &cancellables)
    }
}
