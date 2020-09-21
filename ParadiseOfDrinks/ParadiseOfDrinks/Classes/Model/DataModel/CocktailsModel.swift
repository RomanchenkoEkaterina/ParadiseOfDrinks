//
//  CocktailsModel.swift
//  ParadiseOfDrinks
//
//  Created by ket on 21.09.2020.
//  Copyright © 2020 Ekaterina Romanchenko. All rights reserved.
//

import Foundation

struct CocktailsModel {
    
    var categories: Array<Category> = []
    var cocktailsByCategory: [Category: Array<Drink>] = [:]
    
    struct Category: Identifiable, Hashable {
        var name: String
        var isSelected: Bool
        var id: Int
    }
    
    struct Drink {
        var name: String
        var thumb: String
    }
    
    func getIndexOfCategory(by categoryID: Int) -> Int {
        for index in 0..<self.categories.count {
            if self.categories[index].id == categoryID {
                return index
            }
        }
        return 0 // TODO: bogus!
    }
    
    mutating func selectOrUnselectCategory(by categoryID: Int) {
        let index = self.getIndexOfCategory(by: categoryID)
        categories[index].isSelected.toggle()
    }
    
}
