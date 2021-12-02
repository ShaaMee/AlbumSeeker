//
//  SearchViewController.swift
//  AlbumSeeker
//
//  Created by user on 30.11.2021.
//

import UIKit

class SearchViewController: UIViewController {
    
    let albums = ["Sting", "Kora"]
    
    private var reuseIdentifier = "searchResultsCell"
    
    private var mainView: SearchView {
        guard let view = view as? SearchView else { return SearchView() }
        return view
    }
    
    override func loadView() {
        view = SearchView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
        setupTableView()
    }
    
    private func setupViewController() {
        title = "Albums search"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(logout))
    }
    
    @objc private func logout() {
        let rootVC = UINavigationController(rootViewController: AuthorizationViewController())
        UIApplication.shared.windows.first?.rootViewController = rootVC
        //present(rootVC, animated: true)
    }
    
    private func setupTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(SearchResultsCellTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
}

// MARK: - TableView data source

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? SearchResultsCellTableViewCell else {
            return UITableViewCell()
        }
        cell.textLabel?.text = albums[indexPath.row]
        return cell
    }
}

// MARK: - TableView delegate

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
