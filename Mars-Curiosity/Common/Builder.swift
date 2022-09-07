//
//  AppDependencyContainer.swift
//  Mars-Curiosity
//
//  Created by Tilek Sulaymanbekov on 5/9/22.
//

import Foundation
import UIKit

class Builder {
    
    
    init() {
        
    }
    
    func makeMainViewController() -> MainViewController {
        let vc = MainViewController()
        return vc
    }
    
}
