//
//  CamerasModel.swift
//  Mars-Curiosity
//
//  Created by Tilek Sulaymanbekov on 6/9/22.
//

import Foundation

enum CameraType: String, CaseIterable, Codable {
    
    case FHAZ
    case RHAZ
    case MAST
    case CHEMCAM
    case MAHLI
    case MARDI
    case NAVCAM
    
    var title: String {
        switch self {
        case .FHAZ:
            return "Front Hazard Avoidance Camera"
        case .RHAZ:
            return "Rear Hazard Avoidance Camera"
        case .MAST:
            return "Mast Camera"
        case .CHEMCAM:
            return "Chemistry and Camera Complex"
        case .MAHLI:
            return "Mars Hand Lens Imager"
        case .MARDI:
            return "Mars Descent Imager"
        case .NAVCAM:
            return "Navigation Camera"
        }
    }
        
    var key: String {
        return self.rawValue
    }
}
