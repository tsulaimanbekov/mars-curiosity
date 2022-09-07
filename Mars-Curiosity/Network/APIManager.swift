//
//  APIManager.swift
//  Mars-Curiosity
//
//  Created by Tilek Sulaymanbekov on 5/9/22.
//

import Foundation

protocol APIManagerProtocol {
    /// completion based request
    func perform(_ request: RequestProtocol, completion: @escaping ((Result<Data,Error>) -> Void)) throws
    
}

class APIManager: APIManagerProtocol {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
      self.urlSession = urlSession
    }

    func perform(_ request: RequestProtocol, completion: @escaping (Result<Data,Error>) -> Void) throws {

        let task = urlSession.dataTask(with: try request.createURLRequest()) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(NetworkError.invalidServerResponse))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
