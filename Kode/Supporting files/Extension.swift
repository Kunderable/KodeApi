//
//  Extension.swift
//  Kode
//
//  Created by Илья Сутормин on 08.10.2022.
//

import UIKit

extension TableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Departament.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "departamentCell", for: indexPath) as! CollectionViewCell
            
        cell.positionLabel.text = Departament.allCases[indexPath.row].rawValue
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        
        if let department = Departament(rawValue: cell.positionLabel.text ?? "") {
            if department == .all {
                filtredUsers = users
            } else {
                filtredUsers = users.filter({ $0.department == String(describing: department) })
            }
            
            tableView.reloadData()
        }
    }
}

extension TableViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText  = searchController.searchBar.text {
            filterContentForSearchText(searchText)
            tableView.reloadData()
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        if !searchText.isEmpty {
            filtredUsers = users.filter({ (user: Item) -> Bool in
                let firstTitle  = user.firstName.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                let lastTitle = user.lastName.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                let tag = user.userTag.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                return firstTitle != nil || lastTitle != nil || tag != nil
            })
        } else {
            filtredUsers = users
        }
    }
}

    
