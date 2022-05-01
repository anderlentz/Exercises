import Combine
import Foundation
import Feature_Exercises

struct ExerciseResult: Decodable {
    let results: [ExerciseInfoResult]
}

struct Image: Decodable {
    let image: String
}

struct ExerciseInfoResult: Decodable {
    let id: Int
    let name: String
    let variations: [Int?]
    let images: [Image?]
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
                    return result.results.map { Exercise(id: $0.id, title: $0.name, variations: $0.variations, imagePaths: $0.images.map { $0?.image }) }
                }
                .eraseToAnyPublisher()
        }
    }
    
    class VariationExercisesLoader: VariationExercisesLoaderProtocol {
        
        private let baseURL = URL(string: "https://wger.de/api/v2/exerciseinfo")!
        private let exerciseIDs: [Int]
        
        required init(exerciseIDs: [Int]) {
            self.exerciseIDs = exerciseIDs
        }
        
        func load() -> AnyPublisher<[Exercise], Error> {
            
            return exerciseIDs
                .publisher
                .map { id -> URL in
                    var url = baseURL
                    url.appendPathComponent("\(id)")
                    return url
                }
                .flatMap { url in
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
                        .decode(type: ExerciseInfoResult.self, decoder: JSONDecoder())
                        .map {
                            Exercise(id: $0.id, title: $0.name, variations: $0.variations, imagePaths: $0.images.map { $0?.image })
                            
                        }
                        .eraseToAnyPublisher()
                }
                .collect()
                .eraseToAnyPublisher()
        }
    }
    
}
