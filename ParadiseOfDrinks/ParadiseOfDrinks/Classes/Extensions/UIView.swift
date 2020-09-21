//
//  UIView.swift
//  ParadiseOfDrinks
//
//  Created by ket on 21.09.2020.
//  Copyright © 2020 Ekaterina Romanchenko. All rights reserved.
//

import UIKit

extension UIView {

    func setShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
    }
}
