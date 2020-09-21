//
//  CocktailsViewModel.swift
//  ParadiseOfDrinks
//
//  Created by ket on 21.09.2020.
//  Copyright © 2020 Ekaterina Romanchenko. All rights reserved.
//

import Foundation

class CocktailsViewModel {
    private var model: CocktailsModel = CocktailsModel()
    private var cocktailsAPI = CocktailsAPI()
    
    static var shared: CocktailsViewModel = {
        let instance = CocktailsViewModel()
        return instance
    }()
    
    private init() {}
    
    weak var delegate: InputCocktailsListViewControllerProtocol?
    
// MARK: - Access to the Model
    
    var categories: Array<CocktailsModel.Category> {
        model.categories
    }
    
    var cocktailsByCategory: [CocktailsModel.Category : Array<CocktailsModel.Drink>] {
        model.cocktailsByCategory
    }
    
//    MARK: - Intents
    
    func selectOrUnselectCategory(by categoryID: Int) {
        model.selectOrUnselectCategory(by: categoryID)
    }
    
    func deleteAllDrinks() {
        model.cocktailsByCategory.removeAll()
        let categoriesList = self.categories.filter { $0.isSelected }
        guard let firstCategory = categoriesList.first else { return }
        self.getDrinksList(by: firstCategory)
    }
    
    func getDrinksByCategory(index: Int ) {
        let categoriesList = CocktailsViewModel.shared.categories.filter { $0.isSelected }
        print(index)
        let category = categoriesList[index]
        self.getDrinksList(by: category)
    }
    
}

extension CocktailsViewModel {
    
    func getCategoriesListAndFirstDrinksList() {
        cocktailsAPI.getCategoriesList { result in
            switch result {
                
            case .success(let data):
                var categoriesList: Array<CocktailsModel.Category> = []
                for (index, category) in data.drinks.enumerated() {
                    categoriesList.append(CocktailsModel.Category(name: category.name, isSelected: true, id: index))
                }
                self.model.categories = categoriesList
                self.getDrinksList(by: self.model.categories.first!)
            case .failure(let error):
                self.delegate?.errorHandler(error: error)
            }
        }
        
    }
    
    func getDrinksList(by category: CocktailsModel.Category) {
        cocktailsAPI.getDrinksListByCategory(categoryName: category.name ) { result in
            switch result {
                
            case .success(let data):
                var drinkslist: Array<CocktailsModel.Drink> = []
                for drink in data.drinks {
                    drinkslist.append(CocktailsModel.Drink(name: drink.name!, thumb: drink.thumbLink!))
                }
                self.model.cocktailsByCategory[category] = drinkslist
                self.delegate?.reloadTableView()
            case .failure(let error):
                self.delegate?.errorHandler(error: error)
            }
        }
    }
    
}
