//
//  MovieDetailViewModel.swift
//  MovieApplication
//
//  Created by MamooN_ on 8/23/23.
//

import Foundation

final class MovieDetailViewModel{
    
    private let movieID: Int
    private let movieRepository: MovieRepository
    private(set) var movieDetails: Movie? = nil
    
    init(movieID: Int, movieRepository: MovieRepository) {
        self.movieID = movieID
        self.movieRepository = movieRepository
    }
    
    func fetchMovieDetail(completion: @escaping (String?) -> Void){
        movieRepository.fetchMovieDetail(withId: movieID) {[weak self] result in
            switch result {
            case .success(let data):
                self?.movieDetails = data
                completion(nil)
            case .failure(let error):
                let error = error.maskedDescription
                completion(error)
            }
        }
    }
    
    
}
