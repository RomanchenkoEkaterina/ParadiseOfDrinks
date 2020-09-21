//
//  CategoriesModel.swift
//  ParadiseOfDrinks
//
//  Created by ket on 21.09.2020.
//  Copyright © 2020 Ekaterina Romanchenko. All rights reserved.
//

struct CategoriesWrapper: Decodable {
    let drinks: [CategoryInfo]
}

struct CategoryInfo: Decodable, Hashable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "strCategory"
    }
}
