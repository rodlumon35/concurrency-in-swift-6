//
//  NavigationHandler.swift
//  Swift6WithUIKit
//
//  Created by Luis Rodríguez on 1/2/25.
//


import UIKit
import SwiftUI

enum Route {
    case details(Pokemon)
}

actor NavigationHandler {
    private let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
}

@MainActor
extension NavigationHandler {
    func navigateTo(route: Route) {
        switch route {
        case .details(let pokemon):
            let hostingController = UIHostingController(rootView: PokemonDetailView(with: pokemon))
            navigationController?.pushViewController(hostingController, animated: true)
        }
    }
    
    func back() {
        navigationController?.popViewController(animated: true)
    }
}
