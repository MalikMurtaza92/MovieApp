//
//  ViewController.swift
//  MovieApplication
//
//  Created by MamooN_ on 8/22/23.
//

import UIKit

class MovieListingViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: MovieListingViewModel
    var selection: ((PopularMovie) -> Void)
    
 
     init?(coder: NSCoder,viewModel: MovieListingViewModel,selection:@escaping ((PopularMovie) -> Void)) {
         self.viewModel = viewModel
         self.selection = selection
         super.init(coder: coder)
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovieList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
   
    }
    
    private func fetchMovieList(){
        isLoaderVisible(visibility: true)
        viewModel.fetchMovieList { errorString in
            DispatchQueue.main.async { [weak self] in
                self?.onApiResponse(error: errorString)
            }
        }
    }
    
    private func onApiResponse(error: String? = nil){
        isLoaderVisible(visibility: false)
        if let error{ self.showAlert(with: error, title: "Alert") }
        else if viewModel.movieList.isEmpty{
            self.showAlert(with: "No popular movies available at the moment", title: "Alert")
        }else{
            self.collectionView.reloadData()
        }
    }
}

extension MovieListingViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularMovieCollectionViewCell.reuseIdentifier, for: indexPath) as! PopularMovieCollectionViewCell
        let model = viewModel.movieList[indexPath.item]
        cell.configureCell(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 16) / 2
        let height = width * 0.8
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel.movieList[indexPath.item]
        selection(movie)
    }
    
}

