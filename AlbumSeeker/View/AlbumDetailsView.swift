//
//  AlbumDetailsView.swift
//  AlbumSeeker
//
//  Created by user on 08.12.2021.
//

import UIKit

class AlbumDetailsView: UIView {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    let songsListTableView = UITableView(frame: .zero, style: .plain)
    let albumCoverImage = UIImageView()
    let albumNameLabel = UILabel()
    let artistNameLabel = UILabel()
    let albumReleaseYearLabel = UILabel()
    let activityIndicator = UIActivityIndicatorView()
    let songsTableViewRowHeight: CGFloat = 44

    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }
    
    private func setupViews() {
        setupMainView()
        viewsBasicSetup()
        setupScrollView()
        setupContentView()
        setupAlbumCoverImageView()
        setupLabels()
        setupSongsListTableView()
        setupActivityIndicator()
        setupConstraints()
    }
    
    private func setupMainView() {
        backgroundColor = .systemBackground
        addSubview(scrollView)
    }

    private func viewsBasicSetup() {
        [scrollView, contentView, songsListTableView, albumCoverImage, artistNameLabel, albumNameLabel, albumReleaseYearLabel, activityIndicator].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupScrollView() {
        scrollView.contentSize = contentView.bounds.size
    }
    
    private func setupContentView() {
        contentView.backgroundColor = .systemBackground
        
        [songsListTableView, albumCoverImage, artistNameLabel, albumNameLabel, albumReleaseYearLabel].forEach { view in
            contentView.addSubview(view)
        }
        scrollView.addSubview(contentView)
    }

    private func setupAlbumCoverImageView() {
        albumCoverImage.backgroundColor = .systemGray5
        albumCoverImage.contentMode = .scaleAspectFill
        albumCoverImage.addSubview(activityIndicator)
    }
    
    private func setupLabels() {
        [albumNameLabel, artistNameLabel, albumReleaseYearLabel].forEach { label in
            label.numberOfLines = 0
            label.font = UIFont.preferredFont(forTextStyle: .body)
            label.textColor = .label
            label.textAlignment = .center
        }
        albumNameLabel.font = .boldSystemFont(ofSize: 17)
    }
    
    private func setupSongsListTableView() {
        songsListTableView.isScrollEnabled = false
    }
    
    private func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: widthAnchor),
                        
            albumCoverImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            albumCoverImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            albumCoverImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            albumCoverImage.heightAnchor.constraint(equalTo: albumCoverImage.widthAnchor),
            
            albumNameLabel.topAnchor.constraint(equalTo: albumCoverImage.bottomAnchor, constant: 20),
            albumNameLabel.widthAnchor.constraint(equalTo: albumCoverImage.widthAnchor),
            albumNameLabel.centerXAnchor.constraint(equalTo: albumCoverImage.centerXAnchor),
            
            artistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 8),
            artistNameLabel.widthAnchor.constraint(equalTo: albumCoverImage.widthAnchor),
            artistNameLabel.centerXAnchor.constraint(equalTo: albumCoverImage.centerXAnchor),
            
            albumReleaseYearLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 8),
            albumReleaseYearLabel.widthAnchor.constraint(equalTo: albumCoverImage.widthAnchor),
            albumReleaseYearLabel.centerXAnchor.constraint(equalTo: albumCoverImage.centerXAnchor),
            
            songsListTableView.topAnchor.constraint(equalTo: albumReleaseYearLabel.bottomAnchor, constant: 8),
            songsListTableView.widthAnchor.constraint(equalTo: albumCoverImage.widthAnchor),
            songsListTableView.centerXAnchor.constraint(equalTo: albumCoverImage.centerXAnchor),
            songsListTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            activityIndicator.centerYAnchor.constraint(equalTo: albumCoverImage.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: albumCoverImage.centerXAnchor)
        ])
    }
}
