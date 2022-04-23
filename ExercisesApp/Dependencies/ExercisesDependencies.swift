import Combine
import Foundation
import Feature_Exercises

struct ExerciseResult: Decodable {
    let results: [ExerciseResult]
    
    struct ExerciseResult: Decodable {
        let id: Int
        let name: String
    }
}

struct ExercisesDependencies {
    
    class RemoteExercisesLoader: ExercisesLoaderProtocol {
        
        let url = URL(string: "https://wger.de/api/v2/exerciseinfo")!
        
        func load() -> AnyPublisher<[Exercise], Error> {
            URLSession
                .shared
                .dataTaskPublisher(for: url)
                .tryMap() { element -> Data in
                    guard let httpResponse = element.response as? HTTPURLResponse,
                        httpResponse.statusCode == 200 else {
                            throw URLError(.badServerResponse)
                        }
                    return element.data
                }
                .decode(type: ExerciseResult.self, decoder: JSONDecoder())
                .map { result in
                    return result.results.map { Exercise(id: $0.id, title: $0.name) }
                }
                .eraseToAnyPublisher()
        }
    }
}
