import Foundation
import Combine
import CombineSchedulers
import Shared_DataLoader

public class ExercisesViewModel {
    @Published var exercises: [Exercise] = []
    @Published var isLoading = false
    @Published var isShowingError = false
        
    private(set) var onExerciseVariationSelected: (Exercise) -> Void
    private(set) var imageLoader: ImageLoader
    private let exercisesLoader: ExercisesLoaderProtocol
    private let mainQueue: AnySchedulerOf<DispatchQueue>
    
    private var cancellables: Set<AnyCancellable> = []
    
    public init(
        exercisesLoader: ExercisesLoaderProtocol,
        imageLoader: ImageLoader,
        onExerciseVariationSelected: @escaping (Exercise) -> Void,
        mainQueue: AnySchedulerOf<DispatchQueue> = .main
    ) {
        self.exercisesLoader = exercisesLoader
        self.onExerciseVariationSelected = onExerciseVariationSelected
        self.mainQueue = mainQueue
        self.imageLoader = imageLoader
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
