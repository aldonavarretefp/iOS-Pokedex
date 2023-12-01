//
//  Pokemon.swift
//  Pokedex
//
//  Created by Aldo Yael Navarrete Zamora on 01/12/23.
//

import Foundation

struct Pokemon: Decodable, Identifiable {
    var id: Int
    var name: String
    var sprites: Sprites
    
    struct Sprites: Codable {
        let other: Other
    }
    
    struct Other: Codable {
        let officialArtwork: OfficialArtwork
        
        enum CodingKeys: String, CodingKey {
            case officialArtwork = "official-artwork"
        }
    }
    
    struct OfficialArtwork: Codable {
        let frontDefault: URL
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
}
