import CombineSchedulers
import XCTest
@testable import Feature_Exercises

final class ExercisesViewControllerTests: XCTestCase {
    
    func test_init_shouldNotDisplayExercices() {
        let viewModel = ExercisesViewModel(exercisesLoader: ExercisesLoaderSpy(), imageLoader: FakeImageLoader(), onExerciseVariationSelected: { _ in })
        let sut = ExercisesViewController(viewModel: viewModel)
        
        XCTAssertEqual(sut.numberOfItems, 0)
    }
    
    func test_viewDidLoad_shouldCallLoadExercises() {
        let exercisesLoadSpy = ExercisesLoaderSpy(
            result: .complete(with: .success([.mock(id: 0, title: "MockExercise")]))
        )
        let viewModel = ExercisesViewModel(
            exercisesLoader: exercisesLoadSpy,
            imageLoader: FakeImageLoader(),
            onExerciseVariationSelected: { _ in }
        )
        let sut = ExercisesViewController(viewModel: viewModel)
        
        sut.viewDidLoad()
        
        XCTAssertEqual(exercisesLoadSpy.didCallLoad, true)
    }
    
    func test_viewDidLoad_whenLoadedExercises_shouldUpdateCollection() {
        let exercises: [Exercise] = [
            .mock(id: 0, title: "MockExercise0"),
            .mock(id: 1, title: "MockExercise1", image: Data())
        ]
        let exercisesLoadSpy = ExercisesLoaderSpy(
            result: .complete(with: .success(exercises))
        )
        let viewModel = ExercisesViewModel(
            exercisesLoader: exercisesLoadSpy,
            imageLoader: FakeImageLoader(),
            onExerciseVariationSelected: { _ in },
            mainQueue: .immediate.eraseToAnyScheduler()
        )
        let sut = ExercisesViewController(viewModel: viewModel)
        
        sut.viewDidLoad()

        XCTAssertEqual(sut.numberOfItems, 2)
        XCTAssertFalse(sut.collectionView.isHidden)
        XCTAssertTrue(sut.infoLabel.isHidden)
        XCTAssertTrue(sut.loadingIndicator.isHidden)
        
    }
    
    func test_loading() {
        let viewModel = ExercisesViewModel(
            exercisesLoader: ExercisesLoaderSpy(),
            imageLoader: FakeImageLoader(),
            onExerciseVariationSelected: { _ in },
            mainQueue: .immediate.eraseToAnyScheduler()
        )
        let sut = ExercisesViewController(viewModel: viewModel)
        
        sut.viewDidLoad()
        
        viewModel.isLoading = true
        
        XCTAssertFalse(sut.loadingIndicator.isHidden)
        XCTAssertTrue(sut.infoLabel.isHidden)
        XCTAssertTrue(sut.collectionView.isHidden)
    }
    
    func test_showInfoLabel_whenHasError() {
        let viewModel = ExercisesViewModel(
            exercisesLoader: ExercisesLoaderSpy(),
            imageLoader: FakeImageLoader(),
            onExerciseVariationSelected: { _ in },
            mainQueue: .immediate.eraseToAnyScheduler()
        )
        let sut = ExercisesViewController(viewModel: viewModel)
        
        sut.viewDidLoad()
        
        viewModel.isShowingError = true
        
        XCTAssertFalse(sut.infoLabel.isHidden)
        XCTAssertTrue(sut.loadingIndicator.isHidden)
        XCTAssertTrue(sut.collectionView.isHidden)
    }
    
}



extension Exercise {
    static func mock(id: Int, title: String, image: Data? = nil) -> Self {
        .init(id: id, title: title, variations: [], imagePaths: [], image: image)
    }
}
