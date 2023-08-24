//
//  SceneDelegate.swift
//  MovieApplication
//
//  Created by MamooN_ on 8/22/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    lazy var movieRepository: MovieRepository = {
        let session = URLSession(configuration: .default)
        let httpClient = UPURLSessionHttpClient(session: session)
        let movieRepository = HTTPMovieRepository(httpClient: httpClient)
        return movieRepository
    }()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let navigation = UINavigationController()
        let movieListingRouter = MovieListingRouter(navigationController: navigation, movieRepository: movieRepository)
        
        window.rootViewController = navigation
        self.window = window
        window.makeKeyAndVisible()
        
        movieListingRouter.start()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {
        NetworkMonitor.shared.startMonitoring()
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        NetworkMonitor.shared.stopMonitoring()
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

