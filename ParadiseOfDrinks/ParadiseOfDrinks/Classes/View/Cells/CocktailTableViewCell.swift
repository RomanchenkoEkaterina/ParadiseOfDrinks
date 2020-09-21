//
//  CocktailsTableViewCell.swift
//  ParadiseOfDrinks
//
//  Created by ket on 21.09.2020.
//  Copyright © 2020 Ekaterina Romanchenko. All rights reserved.
//

import UIKit
import SDWebImage

class CocktailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cocktailNameLabel: UILabel!
    @IBOutlet weak var cocktailImageView: UIImageView!
    
    static let reuseID = "CocktailsCell"
    
    func updateCell(by cocktailInfo: CocktailsModel.Drink) {
        cocktailNameLabel.text = cocktailInfo.name
        let imageLink = cocktailInfo.thumb
        cocktailImageView.sd_setImage(with: URL(string: imageLink), completed: nil)
    }
    
}
