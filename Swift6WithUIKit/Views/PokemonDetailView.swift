//
//  PokemonDetailView.swift
//  Swift6WithUIKit
//
//  Created by Luis Rodríguez on 1/2/25.
//

import SwiftUI

struct PokemonDetailView: View {
    private let pokemon: Pokemon
    private var imageUrl: URL? {
        let pokeID = pokemon.id
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokeID).png")
    }
    
    init(with pokemon: Pokemon) {
        self.pokemon = pokemon
    }
    
    var body: some View {
        VStack {
            AsyncImage(url: imageUrl) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable().scaledToFit()
                case .failure:
                    Image(systemName: "exclamationmark.triangle").foregroundColor(.red)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 250, height: 250)
            Text(pokemon.name)
                .font(.title)
                .fontWeight(.bold)
            Text("Height: \(pokemon.height)")
            Text("Weight: \(pokemon.weight)")
        }
    }
}

#Preview {
    PokemonDetailView(with: Pokemon(id: 1, name: "Bulbasaur", height: 3, weight: 5))
}
