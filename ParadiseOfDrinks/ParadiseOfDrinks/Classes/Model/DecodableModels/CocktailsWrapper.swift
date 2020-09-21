//
//  CocktailsModel.swift
//  ParadiseOfDrinks
//
//  Created by ket on 21.09.2020.
//  Copyright © 2020 Ekaterina Romanchenko. All rights reserved.
//

struct CocktailsWrapper: Decodable {
    let drinks: [CocktailInfo]
}

struct CocktailInfo: Decodable {
    let name: String?
    let thumbLink: String?
    let idDrink: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "strDrink"
        case thumbLink = "strDrinkThumb"
        case idDrink = "idDrink"
    }
}
