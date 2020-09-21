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
    
    private struct Constants {
        static let rowHeight: CGFloat = 140.0
        static let headerHeight: CGFloat = 40.0
        static let segueIdentifier = "showFiltersController"
        static let errorTitle = "Ops.."
        static let errorMessage = "Failed to get cocktail list."
        static let errorButtonTitle = "OK"
        static let endListTitle = "Attention!"
        static let endListMessage = "The drinks list is over."
    }
    
    var indexOfCurrentSection = 0
    var isPagination = true
    
    @IBOutlet weak var cocktailsNavigationBar: CocktailsNavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        CocktailsViewModel.shared.getCategoriesListAndFirstDrinksList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setup() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        CocktailsViewModel.shared.delegate = self
        cocktailsNavigationBar.delegate = self
        tableView.sectionHeaderHeight = Constants.headerHeight
        tableView.estimatedSectionHeaderHeight = Constants.headerHeight
    }
    
    private func alertHandler(title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: buttonTitle, style: .cancel, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (tableView.contentOffset.y + tableView.frame.size.height) > tableView.contentSize.height, scrollView.isDragging, isPagination {
            
            isPagination = false
            indexOfCurrentSection += 1
            let categories = CocktailsViewModel.shared.categories.filter { $0.isSelected }
            if indexOfCurrentSection < categories.count {
                CocktailsViewModel.shared.getDrinksByCategory(index: indexOfCurrentSection)
            } else {
                self.alertHandler(title: Constants.endListTitle, message: Constants.endListMessage, buttonTitle: Constants.errorButtonTitle)
            }
        }
    }
   
}

//    MARK: - UITableViewControllerDelegate

extension CocktailsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CocktailsTableViewHeader()
        let selectedCategories = CocktailsViewModel.shared.categories.filter { $0.isSelected }
        headerView.setHeaderTitle(title: selectedCategories[section].name)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.headerHeight
    }
    
}
    
    
//    MARK: - UITabelViewDataSource

extension CocktailsListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let numberOfSection = CocktailsViewModel.shared.cocktailsByCategory.count
        self.indexOfCurrentSection = numberOfSection >= 0 ? numberOfSection - 1 :  0
        return numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let SelectedCategories = CocktailsViewModel.shared.categories.filter { $0.isSelected }
        return CocktailsViewModel.shared.cocktailsByCategory[SelectedCategories[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CocktailTableViewCell.reuseID, for: indexPath) as! CocktailTableViewCell
        let SelectedCategories = CocktailsViewModel.shared.categories.filter { $0.isSelected }
        let drinks = CocktailsViewModel.shared.cocktailsByCategory[SelectedCategories[indexPath.section]]

        cell.updateCell(by: drinks![indexPath.row])
        
        return cell
    }
    
}

extension CocktailsListViewController: InputCocktailsListViewControllerProtocol {
    func errorHandler(error: Error) {
        self.alertHandler(title: Constants.errorTitle, message: Constants.errorMessage, buttonTitle: Constants.errorButtonTitle)
       }
       
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        self.isPagination = true
    }
}

extension CocktailsListViewController: CocktailsNavigationBarDelegate {
    func goToFiltersVC() {
        self.performSegue(withIdentifier: Constants.segueIdentifier, sender: nil)
    }
}

extension CocktailsListViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
