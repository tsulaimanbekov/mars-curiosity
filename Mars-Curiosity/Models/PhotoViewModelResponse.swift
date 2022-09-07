//
//  PhotoViewModelResponse.swift
//  Mars-Curiosity
//
//  Created by Tilek Sulaymanbekov on 6/9/22.
//

import Foundation

struct PhotoViewModelResponse: Codable {
    let photos: [ImageSourceModel]
}

struct ImageSourceModel: Codable {
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case image = "img_src"
    }
}
