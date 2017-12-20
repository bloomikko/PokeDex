//
//  Pokemon.swift
//  pokedex
//  Copyright © 2017 Mikko Rouru. All rights reserved.
//

import Foundation
import Alamofire

//Instantiation of a class for Pokémons
class Pokemon {
    
    //OK to unwrap these with force, because they will exist in the app
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionText: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    private var _pokemonURL: String!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionText: String {
        if _nextEvolutionText == nil {
            _nextEvolutionText = ""
        }
        return _nextEvolutionText
    }
    
    var nextEvolutionName: String {
        if _nextEvolutionName == nil {
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    
    var nextEvolutionId: String {
        if _nextEvolutionId == nil {
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionLevel: String {
        if _nextEvolutionLevel == nil {
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }
    
    //Initializer
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
    }
 
    /*
    THE JSON DOWNLOAD IS NOT WORKING AT THE MOMENT
    The PokeApi version 1 has been deprecated. Version 2 is highly different and needs more complex functions, this will be fixed.
    */
    func downloadPokemonDetails(completed: @escaping DownloadComplete) {
        Alamofire.request(_pokemonURL).responseJSON { (response) in
           if let dict = response.result.value as? Dictionary<String, Any> {
            if let stats = dict["stats"] as? [Dictionary<String, AnyObject>], stats.count > 0 {
                if let stat = stats[0] as? Dictionary<String, String> {
                    if name = stat["name"] as? String, let score = stats[0]["base_stat"] as? Int, name == "defense" {
                        print(self._defense)
                    }

                if let height = dict["height"] as? String {
                    self._height = height
                }

                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }

                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }

                print(self._weight)
                print(self._height)
                print(self._attack)
                print(self._defense)
    
                if let types = dict["types"] as? [Dictionary<String, String>], types.count > 0 {
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                        for x in 1..<types.count {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                    
                } else {
                    self._type = ""
                }
                    
                    if let descriptionArray = dict["descriptions"] as? [Dictionary<String, String>], descriptionArray.count > 0 {
                        if let url = descriptionArray[0]["resource_uri"] {
                            let descriptionURL = "\(URL_BASE)\(url)"
                            Alamofire.request(descriptionURL).responseJSON(completionHandler: { (response) in
                                if let descriptionDictionary = response.result.value as? Dictionary<String, Any> {
                                    if let description = descriptionDictionary["description"] as? String {
                                        let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                        self._description = newDescription
                                    }
                                }
                                completed()
                            })
                        }
                    } else {
                        self._description = ""
                    }
                    if let evolutions = dict["evolutions"] as? [Dictionary<String, Any>], evolutions.count > 0 {
                        if let nextEvolution = evolutions[0]["to"] as? String {
                            if nextEvolution.range(of: "mega") == nil {
                                self._nextEvolutionName = nextEvolution
                                
                                if let uri = evolutions[0]["resource_uri"] as? String {
                                    let newString = uri.replacingOccurrences(of: "/api/v1/pokemon", with: "")
                                    let nextEvolutionId = newString.replacingOccurrences(of: "/", with: "")
                                    self._nextEvolutionId = nextEvolutionId
                                    
                                    if let levelExist = evolutions[0]["level"] {
                                        if let level = levelExist as? Int {
                                            self._nextEvolutionLevel = "\(level)"
                                        }
                                    } else {
                                        self._nextEvolutionLevel = ""
                                    }
                                }
                            }
                        }
                    }
            }
        completed()
        }
    }
}
}
}
