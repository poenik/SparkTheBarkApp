//
//  CardSegmentsService.swift
//  SparkTheBark
//
//  Created by Nicoleta Poenar on 4/26/20.
//

import Foundation
import Combine

enum HTTPError: LocalizedError {
    case statusCode
}

final class CardSegmentsService {
    var components: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "spark-13.vapor.cloud"
        components.path = "/api/cards/segments"
        return components
    }

    func fetchData() -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: components.url!)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw HTTPError.statusCode
                }
                return output.data
        }
        .decode(type: Data.self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}

typealias Data = [CardSegmentsData]

struct CardSegmentsData: Codable {
    let card: Card
    let segments: [Segment]

}

struct Card: Codable {
    let id: Int?
    let title: String?
    let subtitle: String?
    let body: String?
    let imageURL: String?
}
