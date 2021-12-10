//
//  AlbumDetails.swift
//  AlbumSeeker
//
//  Created by user on 08.12.2021.
//

import Foundation

struct AlbumDetails: Codable {
    let results: [AlbumData]
}

struct AlbumData: Codable {
    let wrapperType: String
    let artistName: String
    let collectionName: String
    let artworkUrl100: String
    let trackCount: Int
    let releaseDate: String
    let trackName: String?
    let trackNumber, trackTimeMillis: Int?
}
