import CoreUI
import Foundation
import XCTest
@testable import Feature_ExerciseDetails

final class ExerciseDetailsViewControllerPropertiesTest: XCTestCase {
    
    func test_viewDidLoad_setTitle() {
        let sut = makeSUT(viewModel: .init(title: "Title"))
        
        sut.viewDidLoad()
        
        XCTAssertEqual(sut.title, "Title")
    }
    
    func testInit() {
        let sut = makeSUT(viewModel: .init(title: "Title"))
        
        XCTAssertNotNil(sut.carrouselViewController)
        XCTAssertNotNil(sut.exercisesViewController)
    }
    
    // MARK: - Helpers
    
    func makeSUT(
        viewModel: ExerciseDetailsViewModel = .init(title: "Some Title")
    ) -> ExerciseDetailsViewController{
        .init(
            viewModel: viewModel,
            carrouselViewController: .init(rootView: CarrouselView(viewModel: .init(imageURLs: []))),
            exercisesViewController: UICollectionViewController(collectionViewLayout: .init())
        )
    }
}
