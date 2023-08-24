//
//  UIView+Extension.swift
//  MovieApplication
//
//  Created by MamooN_ on 8/24/23.
//

import UIKit
import Network

extension UIViewController{
    
    func showAlert(with message: String, title: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func isLoaderVisible(visibility: Bool){
        if !visibility{
            view.viewWithTag(100)?.removeFromSuperview()
            return
        }
        
        let view = UIView(frame: view.frame)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tag = 100
        view.backgroundColor = .white
        self.view.addSubview(view)
       
        var activityIndicator = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
}

extension Error{
    var maskedDescription: String { "Oops something went wrong.." }
}


