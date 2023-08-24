//
//  PopularMovieCollectionViewCell.swift
//  MovieApplication
//
//  Created by MamooN_ on 8/23/23.
//

import UIKit
import SDWebImage
class PopularMovieCollectionViewCell: UICollectionViewCell {
    
    
    static var reuseIdentifier: String = "PopularMovieCollectionViewCell"
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageTitle: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.sd_cancelCurrentImageLoad()
        imageView.image = nil
    }
    
    //MARK: Setup Cell UI
    func configureCell(with model: PopularMovie){
        imageTitle.text = model.movieName
        imageView.sd_setImage(with: model.movieImage)
    }
    
    
}
