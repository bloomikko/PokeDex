//
//  PokeCell.swift
//  pokedex
//  Copyright © 2017 Mikko Rouru. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    //Setting the IBOutlets
    @IBOutlet weak var thumbnailImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    //Configuring the cell
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        
        nameLabel.text = self.pokemon.name.capitalized
        thumbnailImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
}
