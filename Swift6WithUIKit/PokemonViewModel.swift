//
//  PokemonViewModel.swift
//  Swift6WithUIKit
//
//  Created by Luis Rodríguez on 1/2/25.
//

import Combine
import Foundation

final class PokemonViewModel {
    private let dependencies: Dependencies
    private var pokemon: Pokemon?
    private var subscriptions: Set<AnyCancellable> = []
    private lazy var coordinator: AppCoordinator = dependencies.resolve()
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func getPokemon(name: String, shouldNavigate: Bool = false) async {
        let useCase: PokemonUseCase = dependencies.resolve()
        do {
            pokemon = try await useCase.getPokemon(name: name)
            for _ in 0..<100000 {
                print(".")
            }
            if shouldNavigate {
                goToDetail()
            }
        } catch {
            fatalError("pokemon not found")
        }
    }
    
    @PokemonActor
    func getPokemonWithReactive(name: String) {
        let useCase: PokemonUseCase = dependencies.resolve()
        useCase.getReactivePokemon(name: name)
            .sink { _ in } receiveValue: { pokemon in
                for _ in 0..<100000 {
                    print(".")
                }
                self.pokemon = pokemon
                self.goToDetail()
            }.store(in: &subscriptions)
    }
    
    private func goToDetail() {
        guard let pokemon else { return }
        coordinator.navigateTo(route: .details(pokemon))
    }
}
