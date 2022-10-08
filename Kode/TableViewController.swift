//
//  TableViewController.swift
//  Kode
//
//  Created by Илья Сутормин on 07.10.2022.
//

import UIKit
import Kingfisher

class TableViewController: UITableViewController {
    
    @IBOutlet var tableViews: UITableView!
    @IBOutlet weak var arrayDepartament: UICollectionView!
    var users: [Item] = []
    var filtredUsers: [Item] = []
    let searchBar = UISearchController(searchResultsController: nil)
    let urlString = "https://stoplight.io/mocks/kode-education/trainee-test/25143926/users"
    var myRefreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh(sender: )), for: .valueChanged)
        return refreshControl
    }
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayDepartament.delegate = self
        arrayDepartament.dataSource = self
        searchingBar()
        fetch()
        tableViews.refreshControl = myRefreshControl
        
    }
    
    private func searchingBar() {
        searchBar.searchBar.delegate = self
        navigationItem.searchController = searchBar
        searchBar.obscuresBackgroundDuringPresentation = false
        searchBar.searchBar.placeholder = "Введите имя, тег, почту"
        searchBar.searchBar.setImage(UIImage(named: "filter"), for: .bookmark, state: .normal)
        searchBar.searchBar.setPositionAdjustment(UIOffset(horizontal: 0, vertical: 0), for: .bookmark)
        definesPresentationContext = true
        
        if searchBar.isActive {
            searchBar.searchBar.showsBookmarkButton = false
        } else {
            searchBar.searchBar.showsBookmarkButton = true
        }
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    @objc private func pullToRefresh(sender: UIRefreshControl) {
        tableViews.reloadData()
        sender.endRefreshing()
    }
    
    private func fetch() {
        Networking.arrayUser(url: urlString) { [weak self] user in
            self?.users = user
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if inSearchMode {
            return filtredUsers.count
        } else {
            return users.count
        }
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        let user: Item!
        
        if inSearchMode {
            user = filtredUsers[indexPath.row]
        } else {
            user = users[indexPath.row]
        }
        
        cell.nameLabel.text = String("\(self.users[indexPath.row].firstName) \(self.users[indexPath.row].lastName)")
        cell.departamentLabel.text = users[indexPath.row].position
        
        let url = URL(string: users[indexPath.row].avatarURL)
        cell.imageLabel.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "person"), options: [.transition(.fade(0.4)),.processor(DownsamplingImageProcessor(size: cell.imageLabel.frame.size)),
                                                 .cacheOriginalImage])
        cell.imageLabel.layer.cornerRadius = 10
        
        
        return cell
    }
}

