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
        
    }
}

extension TableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            
            view.endEditing(true)
        } else {
            inSearchMode = true
            let lower = searchText.lowercased()
            
            filtredUsers = users.filter({ $0.firstName.range(of: lower) != nil})
        }
        tableViews.reloadData()
    }
}

    
