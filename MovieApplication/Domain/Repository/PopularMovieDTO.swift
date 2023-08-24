//
//  MovieDTO.swift
//  MovieApplication
//
//  Created by MamooN_ on 8/22/23.
//

import Foundation

import Foundation

// MARK: - Welcome
struct PopularMoviesDTO: Decodable {
    
    let results: [PopularMovieDTO]

    enum CodingKeys: String, CodingKey {
        case results
    }
}


struct PopularMovieDTO: Decodable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int
 //   let originalLanguage: OriginalLanguage?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate: String?
    let title: String
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
     //   case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}




extension PopularMoviesDTO{
    func toDomain() -> [PopularMovie]{
         results.map { PopularMovie(id: $0.id, movieName: $0.title, movieImage: URL(string: imagePath + ($0.backdropPath ?? ""))) }
    }
}
