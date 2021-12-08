//
//  AlbumsInfo.swift
//  AlbumSeeker
//
//  Created by user on 08.12.2021.
//

import Foundation

struct AlbumsInfo: Codable {
    let results: [AlbumListResult]
}

struct AlbumListResult: Codable {
    let collectionId: Int
    let artistName: String
    let collectionName: String
    let artworkUrl100: String
    let trackCount: Int
}
