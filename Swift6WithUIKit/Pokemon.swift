//
//  Pokemon.swift
//  Swift6WithUIKit
//
//  Created by Luis Rodríguez on 1/2/25.
//

import Foundation

struct Pokemon: Decodable {
    let name: String
    let height: Int
    let weight: Int
}

@globalActor
actor TestuseCaseActor {
    static let shared = TestuseCaseActor()
}

@TestuseCaseActor
protocol TestUseCase: Sendable {
    func execute(name: String) async throws -> Pokemon
}

final class DefaultTestUseCase: TestUseCase {
    func execute(name: String) async throws -> Pokemon {
        try await Task.sleep(nanoseconds: 3 * 1_000_000_000)
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
}
