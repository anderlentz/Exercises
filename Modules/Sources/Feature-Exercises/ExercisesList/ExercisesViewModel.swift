import Foundation
import Combine
import CombineSchedulers

public class ExercisesViewModel {
    @Published var exercises: [Exercise] = []
    @Published var isLoading = false
    @Published var isShowingError = false
    
    private(set) var onExerciseVariationSelected: (Exercise) -> Void
    private let exercisesLoader: ExercisesLoaderProtocol
    private var cancellables: Set<AnyCancellable> = []
    private let mainQueue: AnySchedulerOf<DispatchQueue>
    
    public init(
        exercisesLoader: ExercisesLoaderProtocol,
        onExerciseVariationSelected: @escaping (Exercise) -> Void,
        mainQueue: AnySchedulerOf<DispatchQueue> = .main
    ) {
        self.exercisesLoader = exercisesLoader
        self.onExerciseVariationSelected = onExerciseVariationSelected
        self.mainQueue = mainQueue
    }
    
    func loadExercises() {
        isLoading = true
        exercisesLoader
            .load()
            .receive(on: mainQueue)
            .sink(
                receiveCompletion: { [weak self] result in
                    self?.isLoading = false
                    switch result {
                    case .failure:
                        self?.isShowingError = true
                    default:
                        break
                    }
                },
                receiveValue: { [weak self] exercises in
                    self?.exercises = exercises
                }
            )
            .store(in: &cancellables)
    }
}
