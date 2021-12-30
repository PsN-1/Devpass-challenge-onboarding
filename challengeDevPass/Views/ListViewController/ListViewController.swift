//
//  ViewController.swift
//  challengeDevPass
//
//  Created by Pedro Neto on 28/12/21.
//

import UIKit

class ListViewController: UITableViewController {

    var onCellSelected: ((RepositoryModel) -> Void)?
    var onSettingsPressed: (() -> Void)?
    var repoList = [RepositoryModel]()
    
    lazy var notFoundView = NotFoundMessageCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupSearchBar()
        setupNotFoundMessageCell()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: K.cellName)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let repo = repoList[indexPath.row]
        
        var cell = tableView.dequeueReusableCell(withIdentifier: K.cellName, for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: K.cellName)
        cell.textLabel?.text =  repo.name
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
    
    @objc func settingsButtonTapped() {
        onSettingsPressed?()
    }
    
    func reloadData() {
        notFoundView.isHidden = !repoList.isEmpty
        tableView.isScrollEnabled = !repoList.isEmpty
        tableView.separatorStyle = repoList.isEmpty ? .none : .singleLine
        tableView.reloadData()
    }
}

extension ListViewController {
    func loadFromWebFor(_ user: String) {
        Networking.doGetReposFor(user) { response in
            if let response = response as? [RepositoryModel] {
                self.repoList = response
                self.reloadData()
            }
        }
    }
}

extension ListViewController {
    func setupNotFoundMessageCell() {
        view.addSubview(notFoundView)
    
        NSLayoutConstraint.activate([
            notFoundView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor, constant: -160),
            notFoundView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
        ])
    }
}

extension ListViewController: UISearchBarDelegate, UISearchControllerDelegate  {
    
    func setupNavigationBar() {
        title = "Repository List"
//        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(settingsButtonTapped))
    }
    
    func setupSearchBar() {
        navigationItem.searchController = UISearchController()
        navigationItem.searchController?.searchBar.placeholder = "Type a GitHub username..."
        navigationItem.searchController?.searchBar.setImage(UIImage(), for: .search, state: .normal)
        navigationItem.searchController?.delegate = self
        navigationItem.searchController?.searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let user = searchBar.text
        loadFromWebFor(user ?? "")
    }
}
