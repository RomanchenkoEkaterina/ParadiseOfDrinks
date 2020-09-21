//
//  CustomNavigationBar.swift
//  ParadiseOfDrinks
//
//  Created by ket on 21.09.2020.
//  Copyright © 2020 Ekaterina Romanchenko. All rights reserved.
//

import UIKit

protocol CocktailsNavigationBarDelegate: class {
    func goToFiltersVC()
}

class CocktailsNavigationBar: UIView {
    struct Constants {
        static var nibName = "CocktailsNavigationBar"
    }
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var title: UIView!
    @IBOutlet weak var filter: UIButton!
    
    weak var delegate: CocktailsNavigationBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle(for: CocktailsNavigationBar.self)
        bundle.loadNibNamed(Constants.nibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        baseView.setShadow(color: .gray, offSet: CGSize(width: 0, height: 5))
    }
    
    @IBAction func filterButton(_ sender: UIButton) {
        delegate?.goToFiltersVC()
    }
    
}
