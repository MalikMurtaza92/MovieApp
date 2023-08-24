//
//  Movie.swift
//  MovieApplication
//
//  Created by MamooN_ on 8/23/23.
//

import Foundation

struct Movie: Identifiable{
    let id: Int
    let movieTitle: String
    let movieBannerImage: URL?
    let movieRating: Double?
    let releaseDate: String?
    let movieDescription: String?
}

