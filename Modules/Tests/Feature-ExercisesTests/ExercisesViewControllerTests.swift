import XCTest
@testable import Feature_Exercises

final class ExercisesViewControllerTests: XCTestCase {
    
    func test_init_shouldNotDisplayExercices() {
        let viewModel = ExercisesViewModel(exercisesLoader: ExercisesLoaderSpy())
        let sut = ExercisesViewController(viewModel: viewModel)
        
        XCTAssertEqual(sut.numberOfItems, 0)
    }
    
    func test_viewDidLoad_shouldCallLoadExercises() {
        let exercisesLoadSpy = ExercisesLoaderSpy(
            result: .complete(with: .success([.init(title: "MockExercise")]))
        )
        let viewModel = ExercisesViewModel(exercisesLoader: exercisesLoadSpy)
        let sut = ExercisesViewController(viewModel: viewModel)
        
        sut.viewDidLoad()
        
        XCTAssertEqual(exercisesLoadSpy.didCallLoad, true)
    }
    
    func test_viewDidLoad_whenLoadedExercises_shouldUpdateCollection() {
        let exercises: [Exercise] = [
            .init(title: "MockExercise0"),
            .init(title: "MockExercise1", image: Data())
        ]
        let exercisesLoadSpy = ExercisesLoaderSpy(
            result: .complete(with: .success(exercises))
        )
        let viewModel = ExercisesViewModel(exercisesLoader: exercisesLoadSpy)
        let sut = ExercisesViewController(viewModel: viewModel)
        
        sut.viewDidLoad()
        
        XCTAssertEqual(sut.numberOfItems, 2)
    }
}
