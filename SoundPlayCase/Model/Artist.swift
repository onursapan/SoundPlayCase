//
//  Artist.swift
//  SoundPlayCase
//
//  Created by Onur Sapan on 3/4/23.
//

import Foundation

struct Artist: Codable{
    let resultCount: Int?
    let results: [Result]?
}

// MARK: - Result
struct Result: Codable {
    let wrapperType, kind: String?
    let collectionID, trackId: Int?
    let artistName, collectionName, trackName, collectionCensoredName: String?
    let trackCensoredName: String?
    let collectionArtistID: Int?
    let collectionArtistViewURL: String?
    let collectionViewURL, trackViewURL: String?
    let previewURL: String?
    let artworkUrl30, artworkUrl60, artworkUrl100: String?
    let collectionPrice, trackPrice: Double?
    let trackRentalPrice, collectionHDPrice, trackHDPrice, trackHDRentalPrice: Double?
    let releaseDate: String?
    let collectionExplicitness, trackExplicitness: String?
    let discCount, discNumber: Int?
    let trackCount, trackNumber, trackTimeMillis: Int?
    let country, currency, primaryGenreName: String?
    let contentAdvisoryRating, shortDescription, longDescription: String?
    let hasITunesExtras: Bool?
    let artistID: Int?
    let artistViewURL: String?
    let isStreamable: Bool?
}
