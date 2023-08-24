//
//  MovieRepository.swift
//  MovieApplication
//
//  Created by MamooN_ on 8/22/23.
//

import Foundation

protocol MovieRepository{
    func fetchMovieList(completion: @escaping (Result<[PopularMovie],Error>) -> Void)
    func fetchMovieDetail(withId id: Int, completion:@escaping (Result<Movie,Error>) -> Void)
}

final class HTTPMovieRepository: MovieRepository{
    
    private let httpClient: HttpClient
    
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    func fetchMovieList(completion: @escaping (Result<[PopularMovie], Error>) -> Void) {
        
        let urlString = baseURL + popularMovieEndpoint
        guard let url = URL(string: urlString) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Bearer " + apiReadAccessToken, forHTTPHeaderField: "Authorization")
        
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        if !NetworkMonitor.shared.isReachable{
            urlRequest.cachePolicy = .returnCacheDataDontLoad
        }
        
        httpClient.execute(urlRequest: urlRequest) { result in
            switch result{
            case .success(let (data,urlResponse)):
                if  urlResponse.statusCode == 200,
                    let jsonDecodedData = try? JSONDecoder().decode(PopularMoviesDTO.self, from: data){
                        let movieList = jsonDecodedData.toDomain()
                        completion(.success(movieList))
                }else{
                    completion(.failure(URLError(.badServerResponse)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchMovieDetail(withId id: Int, completion:@escaping (Result<Movie, Error>) -> Void) {
       
        let urlString = baseURL + String(id)
        guard let url = URL(string: urlString) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Bearer " + apiReadAccessToken, forHTTPHeaderField: "Authorization")
        
        httpClient.execute(urlRequest: urlRequest) { result in
            switch result{
            case .success(let (data,urlResponse)):
                if  urlResponse.statusCode == 200,
                    let jsonDecodedData = try? JSONDecoder().decode(MovieDTO.self, from: data){
                    completion(.success(jsonDecodedData.toDomain()))
                }else{
                    completion(.failure(URLError(.badServerResponse)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
