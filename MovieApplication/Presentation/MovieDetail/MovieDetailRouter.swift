//
//  MovieListingUIComposer.swift
//  MovieApplication
//
//  Created by MamooN_ on 8/24/23.
//

import UIKit


final class MovieDetailRouter{
    
    let navigatonController: UINavigationController
    let movieID: Int
    let movieRepository: MovieRepository
    
    init(navigatonController: UINavigationController, movieID: Int, movieRepository: MovieRepository) {
        self.navigatonController = navigatonController
        self.movieID = movieID
        self.movieRepository = movieRepository
    }
    
    func start(){
        let viewController = createMovieDetailView()
        navigatonController.pushViewController(viewController, animated: true)
    }
    
    private func createMovieDetailView() -> UIViewController{
        let viewModel = MovieDetailViewModel(movieID: movieID, movieRepository: movieRepository)
        let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(identifier: "MovieDetailViewController") { coder in
                MovieDetailViewController(code: coder, viewModel: viewModel)
            }
       
        return viewController
    }
    
 
    
}
