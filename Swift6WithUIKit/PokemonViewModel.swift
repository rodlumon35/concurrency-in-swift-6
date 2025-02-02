//
//  PokemonViewModel.swift
//  Swift6WithUIKit
//
//  Created by Luis Rodríguez on 1/2/25.
//

import Combine

final class PokemonViewModel {
    private let dependencies: Dependencies
    private var pokemon: Pokemon?
    private var subscriptions: Set<AnyCancellable> = []
    private lazy var coordinator: AppCoordinator = dependencies.resolve()
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    @PokemonActor
    func getPokemon(name: String) async {
        let useCase: PokemonUseCase = dependencies.resolve()
        do {
            pokemon = try await useCase.getPokemon(name: name)
            goToDetail()
        } catch {
            fatalError("pokemon not found")
        }
    }
    
    func getPokemonWithReactive(name: String) async {
        let useCase: PokemonUseCase = await dependencies.resolve()
        await useCase.getReactivePokemon(name: name)
            .sink { _ in } receiveValue: { pokemon in
                self.pokemon = pokemon
                self.goToDetail()
            }.store(in: &subscriptions)
    }
    
    private func goToDetail() {
        guard let pokemon else { return }
        coordinator.navigateTo(route: .details(pokemon))
    }
}
