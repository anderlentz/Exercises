import UIKit

@testable import Feature_Exercises
import XCTest

final class ExercisesViewControllerPropertiesTests: XCTestCase {
    
    func test_didLoad_setTitle() {
        let sut = ExercisesViewController(
            viewModel: .init(
                exercisesLoader: ExercisesLoaderSpy(),
                onExerciseVariationSelected: { _ in }
            )
        )
        
        sut.viewDidLoad()
        
        XCTAssertEqual(sut.title, "Exercises")
    }
    
}
