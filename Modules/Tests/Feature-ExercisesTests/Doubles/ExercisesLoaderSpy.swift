import Foundation
import Combine
@testable import Feature_Exercises

class ExercisesLoaderSpy: ExercisesLoaderProtocol {
    
    private(set) var didCallLoad = false
    private let result: AnyPublisher<[Exercise], Error>
    
    init(result: AnyPublisher<[Exercise], Error> = .complete(with: .success([]))) {
        self.result = result
    }
    
    func load() -> AnyPublisher<[Exercise], Error> {
        didCallLoad = true
        return result
    }
    
}


public extension AnyPublisher where Output == [Exercise], Failure == Error {
    static func complete(with result: Result<Output, Failure>) -> Self {
        switch result {
        case let .success(successResult):
            return Just(successResult)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        
        case let .failure(error):
            return Fail(
                outputType: Output.self,
                failure: error
            )
                .eraseToAnyPublisher()
        }
    }
}
