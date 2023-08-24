//
//  URLSessionHttpClient.swift
//  MovieApplication
//
//  Created by MamooN_ on 8/22/23.
//

import Foundation


final class UPURLSessionHttpClient: HttpClient{
    
    struct URLSessionHttpTask: HttpTask{
        let dataTask: URLSessionDataTask
        func cancel() {
            dataTask.cancel()
        }
    }
    
    let session: URLSession
    
    init(session: URLSession){
        self.session = session
    }
    
    func execute(urlRequest: URLRequest, completion: @escaping (HttpResult) -> Void) -> HttpTask {
      //  debugPrint(urlRequest.url,"API")
        let dataTask = session.dataTask(with: urlRequest) { data, urlResponse, error in
           
            if let error{
                completion(.failure(error))
            }else if let data,
                     let urlResponse = urlResponse as? HTTPURLResponse{
                completion(.success((data,urlResponse)))
            }else{
                completion(.failure(URLError(.badServerResponse)))
            }
        }
        dataTask.resume()
        return URLSessionHttpTask(dataTask: dataTask)
    }
}
