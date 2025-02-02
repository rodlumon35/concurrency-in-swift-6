//
//  HTTPClient.swift
//  Swift6WithUIKit
//
//  Created by Luis Rodríguez on 2/2/25.
//


import Foundation
import Combine

protocol HTTPClient {
    func performRequest<T: Decodable>(_ request: URLRequest, responseType: T.Type) -> AnyPublisher<T, Error>
}

final class DefaultHTTPClient: HTTPClient {
    func performRequest<T: Decodable>(_ request: URLRequest, responseType: T.Type) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                guard (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.httpError(statusCode: httpResponse.statusCode, data: data)
                }
                                
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
