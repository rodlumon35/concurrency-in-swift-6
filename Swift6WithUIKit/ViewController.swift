//
//  ViewController.swift
//  Swift6WithUIKit
//
//  Created by Luis Rodríguez on 1/2/25.
//

import UIKit

class ViewController: UIViewController {
    private lazy var dependencies: Dependencies = {
        guard let navigationController = navigationController else {
            fatalError("NavigationController is not available")
        }
        return DefaultDependencies(navigationController: navigationController)
    }()
    
    private lazy var viewModel: PokemonViewModel = PokemonViewModel(dependencies: dependencies)
    private lazy var coordinator: AppCoordinator = dependencies.resolve()

    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Fetch Pokemon", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var secondaryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("secondary button", for: .normal)
        button.addTarget(self, action: #selector(secondary), for: .touchUpInside)
        return button
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .black
        
        view.addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            contentStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        contentStackView.addArrangedSubview(button)
        contentStackView.addArrangedSubview(secondaryButton)
    }
    
    @objc private func buttonTapped() {
        Task {
            await viewModel.getPokemon(name: "pikachu")
            await viewModel.getPokemon(name: "pidgeot", shouldNavigate: true)
            await viewModel.getPokemon(name: "geodude", shouldNavigate: true)
        }
        //viewModel.getPokemonWithReactive(name: "pikachu")
    }
    
    @objc private func secondary() {
        print("secondary button tapped")
    }
}
