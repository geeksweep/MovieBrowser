//
//  Movie.swift
//  MovieBrowser
//
//  Created by Chad Saxon on 6/14/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import Foundation

struct Root: Codable {
    let results: [Movie]
 }

class Movie: Codable {
    let originalTitle:String
    var releaseDate:String
    var shortFormatReleaseDate:String?
    var longFormatReleaseDate:String?
    let overview:String
    let voteAverage:Float
    let posterPath:String?
    var posterImage:Data?
    
    enum CodingKeys: String, CodingKey {
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case shortFormatReleaseDate
        case longFormatReleaseDate
        case overview
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case posterImage
    }
}

