import UIKit

@testable import Feature_Exercises
import XCTest

final class ExercisesViewControllerPropertiesTests: XCTestCase {
    
    func test_didLoad_setTitle() {
        let sut = ExercisesViewController(viewModel: .init())
        
        sut.viewDidLoad()
        
        XCTAssertEqual(sut.title, "Exercises")
    }
    
}