//
//  NetworkService.swift
//  AlbumSeeker
//
//  Created by user on 08.12.2021.
//

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    
    enum NetworkError: Error {
        case transportError(Error)
        case serverError(statusCode: Int)
        case noData
    }
    
    private init() {}
    
    func fetchRequestFor(url: URL, completion: @escaping (Result<Data, NetworkError>) -> ()) {
        
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 5)
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(.transportError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse,
               !(200...299).contains(response.statusCode) {
                completion(.failure(.serverError(statusCode: response.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            completion(.success(data))
        }
        dataTask.resume()
    }
}
