//
//  AlbumDetailsViewController.swift
//  AlbumSeeker
//
//  Created by user on 08.12.2021.
//

import UIKit

class AlbumDetailsViewController: UIViewController {
    
    var albumID: Int
    var selectedAlbumInfo = [AlbumData]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.updateMainView(self.mainView)
            }
        }
    }
    private var reuseIdentifier = "songCell"
    private var numberOfRows: CGFloat {
        let numberOfSections = mainView.songsListTableView.numberOfSections
        guard numberOfSections == 1 else { return 0 }
        return CGFloat(mainView.songsListTableView.numberOfRows(inSection: 0))
    }
    
    var mainView: AlbumDetailsView {
        return (view as? AlbumDetailsView) ?? AlbumDetailsView()
    }
    
    init(albumID: Int) {
        self.albumID = albumID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = AlbumDetailsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMainView()
        fetchAlbumDetailsFor(albumID)
    }
    
    private func setupMainView() {
        mainView.songsListTableView.register(SongTableVewCell.self, forCellReuseIdentifier: reuseIdentifier)
        mainView.songsListTableView.dataSource = self
        mainView.songsListTableView.delegate = self
        mainView.activityIndicator.startAnimating()
    }
    
    private func fetchAlbumDetailsFor(_ albumID: Int) {
        guard let requestUrl = composeURLComponentsForAlbumID(albumID: albumID).url else { return }
        NetworkService.shared.fetchRequestFor(url: requestUrl) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                AlertService.shared.showAlertWith(message: "Can't get album data from server: \(error.localizedDescription)", inViewController: self)
            case .success(let data):
                self.decodeReceivedData(data)
            }
        }
    }
    
    private func composeURLComponentsForAlbumID(albumID: Int) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "itunes.apple.com"
        urlComponents.path = "/lookup"
        urlComponents.queryItems = [
            URLQueryItem(name: "id", value: String(albumID)),
            URLQueryItem(name: "entity", value: "song"),
        ]
        return urlComponents
    }
    
    private func decodeReceivedData(_ data: Data) {
        let decoder = JSONDecoder()
        do {
            let albumData = try decoder.decode(AlbumDetails.self, from: data)
            var albumNewData = [AlbumData]()
            albumData.results.forEach { singleResultData in
                guard singleResultData.wrapperType != "collection" else { return }
                albumNewData.append(singleResultData)
            }
            selectedAlbumInfo = albumNewData
        }
        catch {
            AlertService.shared.showAlertWith(message: "Can't decode Album info from server data: \(error.localizedDescription)", inViewController: self)
        }
    }
    
    private func updateMainView(_ view: AlbumDetailsView) {
        view.songsListTableView.reloadData()
        view.songsListTableView.heightAnchor.constraint(equalToConstant: numberOfRows * view.songsTableViewRowHeight).isActive = true
        view.albumNameLabel.text = selectedAlbumInfo.first?.collectionName
        view.artistNameLabel.text = selectedAlbumInfo.first?.artistName
        view.albumReleaseYearLabel.text = selectedAlbumInfo.first?.releaseDate
        
        guard let albumCoverImageUrl = selectedAlbumInfo.first?.artworkUrl100.replacingOccurrences(of: "100x100", with: "300x300") else { return }
        ImageService.shared.image(forURLString: albumCoverImageUrl) { [weak view] coverImage in
            DispatchQueue.main.async {
                view?.albumCoverImage.image = coverImage
                view?.activityIndicator.stopAnimating()
            }
        }
    }
}

extension AlbumDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedAlbumInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? SongTableVewCell else { return UITableViewCell() }
        cell.trackNameLabel.text = selectedAlbumInfo[indexPath.row].trackName
        guard let trackTime = selectedAlbumInfo[indexPath.row].trackTimeMillis else { return cell }
        cell.trackNumberLabel.text = "\(indexPath.row + 1)."
        cell.trackTimeLabel.text = String(trackTime)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension AlbumDetailsViewController: UITableViewDelegate {

}
