//
//  CameraModel.swift
//  Mars-Curiosity
//
//  Created by Tilek Sulaymanbekov on 6/9/22.
//

import Foundation

struct CameraModel: Codable {
    var camera: String
    var date: String
    
    enum CodingKeys: String, CodingKey {
        case date = "earth_date"
        case camera
    }
}
