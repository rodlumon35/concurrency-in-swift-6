//
//  Dependencies.swift
//  Swift6WithUIKit
//
//  Created by Luis Rodríguez on 1/2/25.
//

import UIKit

protocol Dependencies {
    var navigationController: UINavigationController? { get }
    func resolve() -> AppCoordinator
    @PokemonActor func resolve() -> PokemonUseCase
}

final class DefaultDependencies: Dependencies {
    var navigationController: UINavigationController?
    
    func resolve() -> PokemonUseCase {
        DefaultTestUseCase()
    }
    
    func resolve() -> AppCoordinator {
        return AppCoordinator(navigationController: navigationController)
    }
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
}
