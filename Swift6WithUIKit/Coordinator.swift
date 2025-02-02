//
//  Coordinator.swift
//  Swift6WithUIKit
//
//  Created by Luis Rodríguez on 2/2/25.
//

import Foundation
import UIKit

protocol Coordinator: Sendable {
    var navigationHandler: NavigationHandler { get }
    func navigateTo(route: Route)
    func back()
}

extension Coordinator {
    func navigateTo(route: Route) {
        Task { await navigationHandler.navigateTo(route: route) }
    }
    
    func back() {
        Task { await navigationHandler.back() }
    }
}

final class AppCoordinator: Coordinator {
    internal let navigationHandler: NavigationHandler
    
    init(navigationController: UINavigationController?) {
        self.navigationHandler = NavigationHandler(navigationController: navigationController)
    }
}
