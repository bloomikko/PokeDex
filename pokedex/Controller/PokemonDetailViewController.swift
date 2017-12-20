//
//  PokemonDetailViewController.swift
//  pokedex
//  Copyright © 2017 Mikko Rouru. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
   
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonDescription: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var defense: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var pokedexId: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var attack: UILabel!
    @IBOutlet weak var currentEvolutionImage: UIImageView!
    @IBOutlet weak var nextEvolutionImage: UIImageView!
    @IBOutlet weak var evolution: UILabel!
    
    var pokemon: Pokemon!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonName.text = pokemon.name.capitalized
        
        let img = UIImage(named: "\(pokemon.pokedexId)")
        
        mainImage.image = img
        currentEvolutionImage.image = img
        pokedexId.text = "\(pokemon.pokedexId)"
        pokemon.downloadPokemonDetails {
            self.updateUI()
        }
    }

    func updateUI() {
        attack.text = pokemon.attack
        defense.text = pokemon.defense
        height.text = pokemon.height
        weight.text = pokemon.weight
        type.text = pokemon.type
        pokemonDescription.text = pokemon.description
        
        if pokemon.nextEvolutionId == "" {
            evolution.text = "No Evolutions"
            nextEvolutionImage.isHidden = true
        } else {
            nextEvolutionImage.isHidden = false
            nextEvolutionImage.image = UIImage(named: pokemon.nextEvolutionId)
            let string = "Next Evolution: \(pokemon.nextEvolutionName) - LVL \(pokemon.nextEvolutionLevel)"
            evolution.text = string
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
