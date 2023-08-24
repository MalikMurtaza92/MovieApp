//
//  MovieDetailViewController.swift
//  MovieApplication
//
//  Created by MamooN_ on 8/23/23.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    var viewModel: MovieDetailViewModel
    
    init?(code: NSCoder,viewModel: MovieDetailViewModel){
        self.viewModel = viewModel
        super.init(coder: code)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Provide view model dependency")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isLoaderVisible(visibility: true)
        self.viewModel.fetchMovieDetail { [weak self] error in
                DispatchQueue.main.async {
                    self?.onApiResponse(error: error)
                }
        }
    }
    
    private func onApiResponse(error: String? = nil){
        if let error{
            showAlert(with: error, title: "Alert",onOkTapped: {
                self.navigationController?.popViewController(animated: true)
            })
        }else{
            isLoaderVisible(visibility: false)
            self.setupMovieDetails()
        }
    }
    
    private func setupMovieDetails(){
        if let movie = viewModel.movieDetails{
            movieTitle.text = movie.movieTitle
            movieDescription.text = movie.movieDescription ?? "Not Available"
            releaseDate.text = movie.releaseDate ?? "Not Available"
            if let movieRating = movie.movieRating{
                rating.text = String(format: "%.2f", movieRating)
            }else{
                rating.text = "Not Available"
            }
            movieImageView.sd_setImage(with: movie.movieBannerImage)
       }
    }

}
