//
//  PokedexTests.swift
//  PokedexTests
//
//  Created by Aldo Yael Navarrete Zamora on 01/12/23.
//

import XCTest
@testable import Pokedex

final class PokedexTests: XCTestCase {

    func testPokemonDecoding() throws {
        // Example JSON data for testing
        let jsonData = """
        {
            "id": 1,
            "name": "Bulbasaur",
            "sprites": {
                "other": {
                    "official-artwork": {
                        "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png"
                    }
                }
            }
        }
        """.data(using: .utf8)!

        // Decoding the JSON data to the Pokemon struct
        let pokemon = try JSONDecoder().decode(Pokemon.self, from: jsonData)

        // Assertions to verify the decoding is correct
        XCTAssertEqual(pokemon.id, 1)
        XCTAssertEqual(pokemon.name, "Bulbasaur")
        XCTAssertEqual(pokemon.sprites.other.officialArtwork.frontDefault.absoluteString, "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png")
    }


}
