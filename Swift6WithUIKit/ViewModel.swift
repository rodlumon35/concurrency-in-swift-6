//
//  ViewModel.swift
//  Swift6WithUIKit
//
//  Created by Luis Rodríguez on 1/2/25.
//


@MainActor
final class ViewModel {
    private let dependencies: Dependencies
    private var pokemon: Pokemon?
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    @MainActor
    func getPokemon(name: String) async {
        let useCase: TestUseCase = await dependencies.resolve()
        do {
            let fetchedPokemon = try await useCase.execute(name: name)
            self.pokemon = fetchedPokemon
            await goToDetail()
        } catch {
            fatalError("pokemon not found")
        }
    }
    
    private func goToDetail() async {
        guard let pokemon else { return }
        let coordinator: AppCoordinator = dependencies.resolve()
        coordinator.navigateTo(route: .details(pokemon))
    }
}
