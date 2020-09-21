//
//  FiltersListViewController.swift
//  ParadiseOfDrinks
//
//  Created by ket on 21.09.2020.
//  Copyright © 2020 Ekaterina Romanchenko. All rights reserved.
//

import UIKit

class FiltersListViewController: UIViewController {
    
    struct Constants {
        static let cellHeight: CGFloat = 60.0
        static let enabledApplyButtonBackgroundColor: UIColor = .black
        static let disableApplyButtonBackgroundColor: UIColor = .gray
    }
    
    @IBOutlet weak var filterNavigationBar: FilterNavigationBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var applyButton: UIButton!
    
    
    var selectedFiltersIDs: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        filterNavigationBar.delegate = self
        tableView.allowsMultipleSelection = true
        self.applyButton.isEnabled = false
        self.applyButton.backgroundColor = Constants.disableApplyButtonBackgroundColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    @IBAction func applyButton(_ sender: UIButton) {
        self.applyButton.isEnabled = false
        self.applyButton.backgroundColor = Constants.disableApplyButtonBackgroundColor
        
        for identifire in selectedFiltersIDs {
            CocktailsViewModel.shared.selectOrUnselectCategory(by: identifire)
        }
        CocktailsViewModel.shared.deleteAllDrinks()
        self.selectedFiltersIDs.removeAll()
    }
    
}


//    MARK: UITabelViewDataSource

extension FiltersListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FilterTableViewCell
        DispatchQueue.main.async {
            cell.checkmarkIcon.isHidden.toggle()
        }
        self.applyButton.isEnabled = true
        self.applyButton.backgroundColor = Constants.enabledApplyButtonBackgroundColor

        setSelectedCellIndex(id: cell.categoryIdentifire)
    }
    
    private func setSelectedCellIndex(id: Int) {
        if selectedFiltersIDs.contains(id) {
            guard let indexForDelete = selectedFiltersIDs.firstIndex(of: id) else { return }
            selectedFiltersIDs.remove(at: indexForDelete)
        } else {
            selectedFiltersIDs.append(id)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeight
    }
}


//    MARK: UITabelViewDataSource

extension FiltersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CocktailsViewModel.shared.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.reuseID, for: indexPath) as! FilterTableViewCell
        
        let filter = CocktailsViewModel.shared.categories[indexPath.row]
        
        cell.categoryNameLabel.text = filter.name
        cell.checkmarkIcon.isHidden = !filter.isSelected
        cell.categoryIdentifire = filter.id

        return cell
    }
}

extension FiltersListViewController: FilterNavigationBarDelegate {
    func backToDrinksList() {
        self.navigationController?.popViewController(animated: true)
    }
}
