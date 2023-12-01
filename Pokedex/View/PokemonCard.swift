//
//  PokemonCard.swift
//  Pokedex
//
//  Created by Aldo Yael Navarrete Zamora on 01/12/23.
//

import SwiftUI
import Kingfisher

struct PokemonCard: View {
    
    let pokemon: Pokemon
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                Text(pokemon.name.capitalized)
                    .font(.headline)
                    .foregroundStyle(.black)
                    .padding()
                    .lineLimit(3)
                let pokemonImageUrl = pokemon.sprites.other.officialArtwork.frontDefault.absoluteString
                KFImage(URL(string: pokemonImageUrl))
                    .resizable()
                    .placeholder {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .frame(width: 68, height: 68)
                    }
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 68, height: 68)
                    
                
            }
        }
        .frame(width: 150, height: 150)
        .background(
            .ultraThinMaterial
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .secondary.opacity(0.5), radius: 5, x: 0.0, y: 0.0)
        .padding()
        .transition(.asymmetric(insertion: .slide, removal: .opacity))
    }
}
struct PokemonCard_Previews: PreviewProvider {
    static var previews: some View {
        let pokemon = Pokemon(id: 1, name: "Bulbasour", sprites: .init(other: .init(officialArtwork: .init(frontDefault: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/5.png")!))))
        return PokemonCard(pokemon: pokemon)
        //        return PokemonCard()
    }
}
