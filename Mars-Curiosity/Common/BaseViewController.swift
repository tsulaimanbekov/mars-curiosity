//
//  BaseViewController.swift
//  Mars-Curiosity
//
//  Created by Tilek Sulaymanbekov on 7/9/22.
//

import UIKit

class BaseViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

