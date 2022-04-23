import Foundation
import Combine

public protocol ExercisesLoaderProtocol {
    func load() -> AnyPublisher<[Exercise], Error>
}
