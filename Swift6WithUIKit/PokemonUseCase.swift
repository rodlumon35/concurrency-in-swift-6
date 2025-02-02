//
//  Pokemon.swift
//  Swift6WithUIKit
//
//  Created by Luis Rodríguez on 1/2/25.
//

import Combine
import Foundation

struct Pokemon: Decodable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
}

@globalActor
actor PokemonActor {
    static let shared = PokemonActor()
}

@PokemonActor
protocol PokemonUseCase: Sendable {
    func getPokemon(name: String) async throws -> Pokemon
    func getReactivePokemon(name: String) -> AnyPublisher<Pokemon, Error>
}

final class DefaultTestUseCase: PokemonUseCase {
    private var subscriptions: Set<AnyCancellable> = []
    private let httpClient: HTTPClient = DefaultHTTPClient()
    
    func getPokemon(name: String) async throws -> Pokemon {
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(name.lowercased())"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(Pokemon.self, from: data)
    }
    
    func getReactivePokemon(name: String) -> AnyPublisher<Pokemon, Error> {
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(name.lowercased())"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        let request = URLRequest(url: url, method: .GET)
                
        return httpClient.performRequest(request, responseType: Pokemon.self)
            .eraseToAnyPublisher()
    }
}
