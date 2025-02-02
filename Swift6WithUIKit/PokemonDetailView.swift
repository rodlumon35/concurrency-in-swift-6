//
//  PokemonDetailView.swift
//  Swift6WithUIKit
//
//  Created by Luis Rodríguez on 1/2/25.
//


//
//  PokemonDetailView.swift
//  Swift6Test
//
//  Created by Luis Rodríguez on 1/2/25.
//

import SwiftUI

struct PokemonDetailView: View {
    private let pokemon: Pokemon
    
    init(with pokemon: Pokemon) {
        self.pokemon = pokemon
    }
    
    var body: some View {
        VStack {
            Text(pokemon.name)
                .font(.headline)
                .fontWeight(.bold)
            Text("Height: \(pokemon.height)")
            Text("Weight: \(pokemon.weight)")
        }
    }
}

#Preview {
    PokemonDetailView(with: Pokemon(name: "Pikachu", height: 3, weight: 5))
}
