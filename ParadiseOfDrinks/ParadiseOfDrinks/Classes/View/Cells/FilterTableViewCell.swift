//
//  FilterTableViewCell.swift
//  ParadiseOfDrinks
//
//  Created by ket on 21.09.2020.
//  Copyright © 2020 Ekaterina Romanchenko. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var checkmarkIcon: UIButton!
    
    var categoryIdentifire = 0
    static let reuseID = "FiltersCell"
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        tintColor = .clear
    }
}
