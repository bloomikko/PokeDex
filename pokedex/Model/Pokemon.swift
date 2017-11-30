//
//  Pokemon.swift
//  pokedex
//  Copyright © 2017 Mikko Rouru. All rights reserved.
//

import Foundation

//Instantiation of a class for Pokémons
class Pokemon {
    
    //OK to unwrap these with force, because they will exist in the app
    private var _name: String!
    private var _pokedexId: Int!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    //Initializer
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
    }
}
