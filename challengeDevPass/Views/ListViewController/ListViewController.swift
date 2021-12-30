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
    lazy var loadingView = ActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: K.cellName)
        tableView.clearsContextBeforeDrawing = true
        setupAdicionalViewConfiguration()
    }
    
    func setupAdicionalViewConfiguration() {
        setupNavigationBar()
        setupSearchBar()
        setupNotFoundMessageCell()
        setupLoadingView()
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
        loadingView.isHidden = true
        notFoundView.isHidden = !repoList.isEmpty
        tableView.isScrollEnabled = !repoList.isEmpty
        tableView.separatorStyle = repoList.isEmpty ? .none : .singleLine
        tableView.reloadData()
    }
}

extension ListViewController {
    func loadFromWebFor(_ user: String) {
        showLoadingView()
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
    
    func setupLoadingView() {
        view.addSubview(loadingView)
        loadingView.isHidden = true
        NSLayoutConstraint.activate([
            loadingView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor, constant: -160),
            loadingView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
        ])
    }
    
    func showLoadingView() {
        notFoundView.isHidden = true
        loadingView.isHidden = false
    }
}

extension ListViewController: UISearchBarDelegate, UISearchControllerDelegate  {
    
    func setupNavigationBar() {
        title = "Repository List"
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
