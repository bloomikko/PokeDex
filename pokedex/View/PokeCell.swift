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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    //Configuring the cell
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        
        nameLabel.text = self.pokemon.name.capitalized
        thumbnailImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
}
