//
//  CocktailsTableViewHeader.swift
//  ParadiseOfDrinks
//
//  Created by ket on 21.09.2020.
//  Copyright © 2020 Ekaterina Romanchenko. All rights reserved.
//

import UIKit

class CocktailsTableViewHeader: UIView {
    struct Constants {
        static var nibName = "CocktailsTableViewHeader"
    }
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var headerTitle: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
       
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
       
    private func commonInit() {
        let bundle = Bundle(for: CocktailsTableViewHeader.self)
        bundle.loadNibNamed(Constants.nibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func setHeaderTitle(title: String) {
        self.headerTitle.text = title
    }
    
}
