//
//  RequestPhotoList.swift
//  Mars-Curiosity
//
//  Created by Tilek Sulaymanbekov on 6/9/22.
//

import Foundation

fileprivate let apiKey = "IhuwdtAy3tqpK7zaVh10cziYq5GhpWwXvNND1oRs"

enum RequestPhotoList: RequestProtocol {
    
    case getPhotos(data: CameraModel)
    
    var path: String {
        switch self {
        case .getPhotos:
            return "/mars-photos/api/v1/rovers/curiosity/photos"
        }
    }
    
    var requestMethod: HTTPMethod {
        switch self {
        case .getPhotos:
            return .GET
        }
    }
    
    var queryParams: [String : String] {
        switch self {
        case .getPhotos(let data):
            return [
                "camera": data.camera,
                "earth_date": data.date,
                "api_key": apiKey
            ]
        }
    }
}
