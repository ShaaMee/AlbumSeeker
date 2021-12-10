//
//  SongTableVewCell.swift
//  AlbumSeeker
//
//  Created by user on 08.12.2021.
//

import UIKit

class SongTableVewCell: UITableViewCell {
    
    var trackNumberLabel = UILabel()
    var trackNameLabel = UILabel()
    var trackTimeLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        [trackNumberLabel, trackNameLabel, trackTimeLabel].forEach { label in
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 1
            label.font = UIFont.preferredFont(forTextStyle: .body)
            label.textColor = .label
            label.text = "Loading track info"
            addSubview(label)
        }
        trackNameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        trackNameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            trackNumberLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            trackNumberLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            
            trackNameLabel.leadingAnchor.constraint(equalTo: trackNumberLabel.trailingAnchor, constant: 8),
            trackNameLabel.centerYAnchor.constraint(equalTo: trackNumberLabel.centerYAnchor),
            
            trackTimeLabel.leadingAnchor.constraint(greaterThanOrEqualTo: trackNameLabel.trailingAnchor, constant: 8),
            trackTimeLabel.centerYAnchor.constraint(equalTo: trackNameLabel.centerYAnchor),
            trackTimeLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8)

        ])
    }
}
