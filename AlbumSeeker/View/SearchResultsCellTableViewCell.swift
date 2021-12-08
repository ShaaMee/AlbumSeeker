//
//  SearchResultsCellTableViewCell.swift
//  AlbumSeeker
//
//  Created by user on 30.11.2021.
//

import UIKit

class SearchResultsCellTableViewCell: UITableViewCell {
    
    private let labelsStackView = UIStackView(frame: .zero)
    let albumImageView = UIImageView(frame: .zero)
    let albumNameLabel = UILabel()
    let artistNameLabel = UILabel()
    let numberOfSongsLabel = UILabel()
    let activityIndicator = UIActivityIndicatorView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        setupLabelsStackView()
        viewsBasicSetup()
        setupImageView()
        setupLabels()
        setupActivityIndicator()
    }
    
    private func setupLabelsStackView() {
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 8
        labelsStackView.isLayoutMarginsRelativeArrangement = true
        labelsStackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        labelsStackView.distribution = .fillEqually
        labelsStackView.alignment = .leading
        labelsStackView.backgroundColor = .systemGray5
        labelsStackView.layer.cornerRadius = 16
        labelsStackView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        [albumNameLabel, artistNameLabel, numberOfSongsLabel].forEach {
            labelsStackView.addArrangedSubview($0)
        }
        contentView.addSubview(labelsStackView)
    }
    
    private func viewsBasicSetup() {
        [self, albumImageView, albumNameLabel, artistNameLabel, numberOfSongsLabel, labelsStackView, activityIndicator].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupImageView() {
        albumImageView.contentMode = .scaleAspectFill
        albumImageView.backgroundColor = .systemGray5
        albumImageView.layer.cornerRadius = 16
        albumImageView.clipsToBounds = true
        albumImageView.addSubview(activityIndicator)
        contentView.addSubview(albumImageView)
    }
   
    private func setupLabels() {
        [albumNameLabel, artistNameLabel, numberOfSongsLabel].forEach { label in
            label.numberOfLines = 1
            label.font = UIFont.preferredFont(forTextStyle: .body)
            label.textColor = .label
        }
        albumNameLabel.font = .boldSystemFont(ofSize: 17)
        prepareForReuse()
    }
    
    private func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
    }

    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            albumImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            albumImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            albumImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            albumImageView.widthAnchor.constraint(equalTo: albumImageView.heightAnchor),
            albumImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            labelsStackView.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 16),
            labelsStackView.topAnchor.constraint(equalTo: albumImageView.topAnchor),
            labelsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            labelsStackView.heightAnchor.constraint(equalTo: albumImageView.heightAnchor),
            
            activityIndicator.centerYAnchor.constraint(equalTo: albumImageView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: albumImageView.centerXAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        albumImageView.image = nil
        albumNameLabel.text = "Album: loading..."
        artistNameLabel.text = "Artist name: loading..."
        numberOfSongsLabel.text = "Number of songs: loading..."
    }
}
