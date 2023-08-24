//
//  MovieListingPresenter.swift
//  MovieApplication
//
//  Created by MamooN_ on 8/22/23.
//

import Foundation

final class MovieListingViewModel{
    
    private let movieRepository: MovieRepository
    private(set) var movieList: [PopularMovie] = []
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func fetchMovieList(completion: @escaping (String?) -> Void){
        movieRepository.fetchMovieList { [weak self] result in
            switch result {
                case .success(let data):
                    self?.movieList = data
                    completion(nil)
                case .failure(let error):
                    let errorDescription = error.maskedDescription
                    completion(errorDescription)
            }
        }
    }
}
