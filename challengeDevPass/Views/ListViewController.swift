//
//  ViewController.swift
//  challengeDevPass
//
//  Created by Pedro Neto on 28/12/21.
//

import UIKit

class ListViewController: UITableViewController {

    var onCellSelected: ((RepositoryModel) -> Void)?
    var repoList = [RepositoryModel]()
    var githubUser = "PsN-1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFromwebFor(githubUser)
        title = "Repository List"
        setupSearchBar()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: K.cellName)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(settingsButtonTapped))
    }
    
    @objc func settingsButtonTapped() {
        print("settingsButtonTapped")
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let repo = repoList[indexPath.row]
        
        var cell = tableView.dequeueReusableCell(withIdentifier: K.cellName, for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: K.cellName)
        cell.textLabel?.text = "\(repo.name ?? "")"
        cell.detailTextLabel?.text = repo.language
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repoList.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onCellSelected?(repoList[indexPath.row])
    }
}

extension ListViewController {
    func loadFromwebFor(_ user: String) {
        Networking.doGetReposFor(user) { response in
            if let response = response as? [RepositoryModel] {
                self.repoList = response
                self.tableView.reloadData()
            }
        }
    }
}

extension ListViewController: UISearchBarDelegate, UISearchControllerDelegate  {
    
    func setupSearchBar() {
        navigationItem.searchController = UISearchController()
        navigationItem.searchController?.searchBar.placeholder = "Type a GitHub username..."
        navigationItem.searchController?.searchBar.setImage(UIImage(), for: .search, state: .normal)
        navigationItem.searchController?.delegate = self
        navigationItem.searchController?.searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let user = searchBar.text
        loadFromwebFor(user ?? "")
    }
}
