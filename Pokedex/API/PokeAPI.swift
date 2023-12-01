//
//  PokeAPI.swift
//  Pokedex
//
//  Created by Aldo Yael Navarrete Zamora on 01/12/23.
//

import Foundation


enum PokeAPIError: Error, LocalizedError {
    case invalidURL
    case noData
    case networkError(Error)
    case decodingError

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .noData:
            return "No data was received from the server."
        case .networkError(let underlyingError):
            return "Network error: \(underlyingError.localizedDescription)"
        case .decodingError:
            return "Failed to decode the data into the specified format."
        }
    }
}
class PokeAPI {
    
    let baseUrl: String = "https://pokeapi.co/api/v2/"
    
    let requestedIds: Set<Int> = Set()
    
    let rangeOfPokemonIds: Range = Range(1...800)
    
    func fetchPokemon(completion: @escaping (Result<Pokemon, Error>) -> Void) -> Void {
        var randomNumber = Int.random(in: rangeOfPokemonIds)
        
        while(requestedIds.contains(randomNumber)) {
            randomNumber = Int.random(in: rangeOfPokemonIds)
        }
        
        let pokemonEndPointUrl = baseUrl + "pokemon/" + String(randomNumber)
        
        guard let url = URL(string: pokemonEndPointUrl) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
