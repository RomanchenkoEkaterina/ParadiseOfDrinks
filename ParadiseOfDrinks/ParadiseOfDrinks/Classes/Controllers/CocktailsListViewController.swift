//
//  ViewController.swift
//  ParadiseOfDrinks
//
//  Created by ket on 21.09.2020.
//  Copyright © 2020 Ekaterina Romanchenko. All rights reserved.
//

import UIKit

protocol InputCocktailsListViewControllerProtocol: class {
    
    func errorHandler(error: Error)
    func reloadTableView()
    
}

class CocktailsListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }


}

extension CocktailsListViewController: InputCocktailsListViewControllerProtocol {
    func errorHandler(error: Error) {
           // TODO: Show Alert
        
       }
       
    func reloadTableView() {
    }
}

