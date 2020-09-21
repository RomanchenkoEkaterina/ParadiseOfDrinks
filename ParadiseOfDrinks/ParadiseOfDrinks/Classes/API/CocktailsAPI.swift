//
//  CocktailsAPI.swift
//  ParadiseOfDrinks
//
//  Created by ket on 21.09.2020.
//  Copyright © 2020 Ekaterina Romanchenko. All rights reserved.
//

import Foundation
import Alamofire

class CocktailsAPI {
    
    // Get a list of all categories of drinks.
    func getCategoriesList(callback: @escaping (Result<CategoriesWrapper, Error>) -> Void) {
        AF.request(Router.categories).response { response in
            guard let data = response.data else { return }
            do {
                let categoriesList = try JSONDecoder().decode(CategoriesWrapper.self, from: data)
                callback(.success(categoriesList))
            } catch {
                print(error)
                callback(.failure(error))
            }
        }
    }
    
    // Get a list of drinks from some category.
    func getDrinksListByCategory(categoryName: String, callBack: @escaping (Result<CocktailsWrapper, Error>) -> Void ) {
        AF.request(Router.cocktailsByCategory(categoryName: categoryName)).response { response in
            guard let data = response.data else { return }
            
            do {
                let cocktailsList = try JSONDecoder().decode(CocktailsWrapper.self, from: data)
                callBack(.success(cocktailsList))
            } catch {
                callBack(.failure(error))
            }
        }
    }
    
}
