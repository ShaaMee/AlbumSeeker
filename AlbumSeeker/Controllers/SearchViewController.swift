//
//  SearchViewController.swift
//  AlbumSeeker
//
//  Created by user on 30.11.2021.
//

import UIKit

class SearchViewController: UIViewController, UISearchControllerDelegate {
    
    var albums = [AlbumListResult]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.mainView.tableView.reloadData()
            }
        }
    }
    
    private var reuseIdentifier = "searchResultsCell"
    private let searchController = UISearchController(searchResultsController: nil)
    
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
        setupSearchController()
        setupRefreshControl()
    }
    
    private func setupViewController() {
        title = "Albums search"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(logout))
    }
    
    @objc private func logout() {
        let rootVC = UINavigationController(rootViewController: AuthorizationViewController())
        UIApplication.shared.windows.first?.rootViewController = rootVC
    }
    
    private func setupTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(SearchResultsCellTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    private func setupSearchController() {
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    private func setupRefreshControl() {
        mainView.refreshControl.addTarget(self, action: #selector(fetchAlbums), for: .valueChanged)
    }
    
    @objc private func fetchAlbums() {
        searchBarSearchButtonClicked(searchController.searchBar)
        mainView.refreshControl.endRefreshing()
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
        cell.tag = indexPath.row
        cell.activityIndicator.startAnimating()
        DispatchQueue.global().async { [weak self] in
            guard let self = self,
                  let imageUrl = URL(string: self.albums[indexPath.row].artworkUrl100),
                  let imageData = try? Data(contentsOf: imageUrl),
                  let image = UIImage(data: imageData) else {
                cell.activityIndicator.stopAnimating()
                return
            }
            DispatchQueue.main.async {
                if cell.tag == indexPath.row {
                    cell.albumImageView.image = image
                    cell.activityIndicator.stopAnimating()
                }
            }
        }
        
        cell.albumNameLabel.text = albums[indexPath.row].collectionName
        cell.artistNameLabel.text = "Artist name: " + albums[indexPath.row].artistName
        cell.numberOfSongsLabel.text = "Number of songs: " + String(albums[indexPath.row].trackCount)
        return cell
    }
}

// MARK: - TableView delegate

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


// MARK: - SearchBar delegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, searchTerm != "" else { return }
        
        let searchUrlComponents = composeURLComponentsForAlbums(searchTerm: searchTerm)
        guard let url = searchUrlComponents.url else { return }
        fetchAlbumDataFor(url: url)
    }
    
    func composeURLComponentsForAlbums(searchTerm: String) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "itunes.apple.com"
        urlComponents.path = "/search"
        urlComponents.queryItems = [
            URLQueryItem(name: "term", value: searchTerm),
            URLQueryItem(name: "media", value: "music"),
            URLQueryItem(name: "entity", value: "album"),
        ]
        return urlComponents
    }
    
    func fetchAlbumDataFor( url: URL) {
        NetworkService.shared.fetchRequestFor(url: url) { [weak self] requestResult in
            guard let self = self else { return }
            
            switch requestResult {
            case .failure(let error):
                AlertService.shared.showAlertWith(messeage: error.localizedDescription, inViewController: self)
            case .success(let data):
                self.decodeReceivedData(data)
            }
        }
    }
    
    func decodeReceivedData(_ data: Data) {
        let decoder = JSONDecoder()
        do {
            let albumsData = try decoder.decode(AlbumsInfo.self, from: data)
            self.albums = albumsData.results.sorted {$0.collectionName.lowercased() < $1.collectionName.lowercased()}
        }
        catch {
            AlertService.shared.showAlertWith(messeage: "Can't decode Albums info from server data", inViewController: self)
        }
    }
}
