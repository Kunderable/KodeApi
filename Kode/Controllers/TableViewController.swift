//
//  TableViewController.swift
//  Kode
//
//  Created by Илья Сутормин on 07.10.2022.
//

import UIKit
import Kingfisher

class TableViewController: UITableViewController {
    
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
        tableView.refreshControl = myRefreshControl
    }
    
    private func searchingBar() {
        searchBar.searchBar.delegate = self
        searchBar.searchResultsUpdater =  self
        navigationItem.searchController = searchBar
        searchBar.obscuresBackgroundDuringPresentation = false
        UIBarButtonItem.appearance().tintColor = #colorLiteral(red: 0.482652545, green: 0.2100374699, blue: 1, alpha: 1)
        UIBarButtonItem.appearance().title = "Отмена"
        searchBar.searchBar.placeholder = "Введите имя, тег, почту..."
        searchBar.searchBar.layer.cornerRadius = 10
        searchBar.searchBar.setImage(UIImage(named: "Vector"), for: .bookmark, state: .normal)
        searchBar.searchBar.setPositionAdjustment(UIOffset(horizontal: 0, vertical: 0), for: .bookmark)
        
        if searchBar.isActive {
            searchBar.searchBar.showsBookmarkButton = false
        } else {
            searchBar.searchBar.showsBookmarkButton = true
        }
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "VC") as? ViewController else { return }
        self.present(vc, animated: true)
    }
    
    @objc private func pullToRefresh(sender: UIRefreshControl) {
        filtredUsers = users
        tableView.reloadData()
        sender.endRefreshing()
    }
    
    private func fetch() {
        Networking.arrayUser(url: urlString) { [weak self] user in
            self?.users = user
            self?.filtredUsers = user
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = filtredUsers[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "detailVC") as? DetailViewController else { return }
        vc.user = user
        
        navigationController?.pushViewController(vc, animated: true)
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtredUsers.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        
        let user = filtredUsers[indexPath.row]
        
        cell.nameLabel.text = String("\(user.firstName) \(user.lastName)")
        cell.departamentLabel.text = user.position
        cell.tagLabel.text = user.userTag.lowercased()
        
        
        let url = URL(string: user.avatarURL)
        cell.imageLabel.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "person"), options: [.transition(.fade(0.4)),.processor(DownsamplingImageProcessor(size: cell.imageLabel.frame.size)),
                                                 .cacheOriginalImage])
        cell.imageLabel.layer.cornerRadius = 10
        
        return cell
    }
}

