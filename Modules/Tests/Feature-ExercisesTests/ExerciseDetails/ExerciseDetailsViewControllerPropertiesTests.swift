import Foundation
import XCTest
@testable import Feature_Exercises

final class ExerciseDetailsViewControllerPropertiesTest: XCTestCase {
    func test_viewDidLoad_setTitle() {
        let title = "Some Title"
        let sut = ExerciseDetailsViewController(viewModel: .init(title: title))
        
        sut.viewDidLoad()
        
        XCTAssertEqual(sut.title, title)
    }
}
