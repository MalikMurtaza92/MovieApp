//
//  MovieListingRouter.swift
//  MovieApplication
//
//  Created by MamooN_ on 8/24/23.
//

import UIKit

final class MovieListingRouter{
    
    let navigationController: UINavigationController
    let movieRepository: MovieRepository
    
    init(navigationController: UINavigationController, movieRepository: MovieRepository) {
        self.navigationController = navigationController
        
        self.movieRepository = movieRepository
    }
    
    func start(){
        let movieListingView = createMovieListingUI()
        navigationController.pushViewController(movieListingView, animated: true)
    }
    
    private func createMovieListingUI() -> UIViewController{
       let viewModel = MovieListingViewModel(movieRepository: movieRepository)
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MovieListingViewController",
                                                                                               creator: { coder in
            let viewController = MovieListingViewController(coder: coder, viewModel: viewModel, selection: self.onMovieSelected)
            return viewController
        })
     
       return viewController
    }
    
    private func onMovieSelected(movie: PopularMovie){
        let router = MovieDetailRouter(navigatonController: navigationController, movieID: movie.id, movieRepository: movieRepository)
        router.start()
    }
    
    
}
