//
//  RequestManager.swift
//  Mars-Curiosity
//
//  Created by Tilek Sulaymanbekov on 6/9/22.
//

import Foundation

protocol RequestManagerProtocol {
    func perform<T: Decodable>(_ request: RequestProtocol, completion: @escaping ((Result<T,Error>) -> Void)) throws
}

class RequestManager: RequestManagerProtocol {
    private let apiManager: APIManagerProtocol
    private let parser: DataParserProtocol
    
    init(apiManager: APIManagerProtocol = APIManager(),
         parser: DataParserProtocol = DataParser()) {
      self.apiManager = apiManager
      self.parser = parser
    }
        
    func perform<T: Decodable>(_ request: RequestProtocol, completion: @escaping ((Result<T,Error>) -> Void)) throws {
        try apiManager.perform(request) { [weak self] result in
            guard let self = self else {
                completion(.failure(URLError(.unknown)))
                return
            }
            
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                do {
                    let decoded: T = try self.parser.parse(data: data)
                    DispatchQueue.main.async {
                        completion(.success(decoded))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
}



