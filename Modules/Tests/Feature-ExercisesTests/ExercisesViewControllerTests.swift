import XCTest
@testable import Feature_Exercises

final class ExercisesViewControllerTests: XCTestCase {
    
    func test_init_shouldNotDisplayExercices() {
        let viewModel = ExercisesViewModel()
        let sut = ExercisesViewController(viewModel: viewModel)
        
        XCTAssertEqual(sut.numberOfItems, 0)
    }
}
