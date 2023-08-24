//
//  HttpClient.swift
//  MovieApplication
//
//  Created by MamooN_ on 8/22/23.
//


import Foundation

protocol HttpTask{
    func cancel()
}

protocol HttpClient{
  
    typealias Response = (Data,HTTPURLResponse)
    typealias HttpResult = Result<Response,Error>
    
    @discardableResult
    func execute(urlRequest: URLRequest, completion:@escaping (HttpResult) -> Void) -> HttpTask
}


