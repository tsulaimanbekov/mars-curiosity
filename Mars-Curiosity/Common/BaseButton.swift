//
//  BaseButton.swift
//  Mars-Curiosity
//
//  Created by Tilek Sulaymanbekov on 5/9/22.
//

import UIKit

class BaseButton: UIButton {
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 300, height: 60)
    }
    
    let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        setTitle("Explore", for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = UIColor(named: "red-button")
        layer.cornerRadius = 10
        layer.shadowColor = UIColor(red: 191/255, green: 46/255, blue: 14/255, alpha: 0.2).cgColor
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.9
    }
}
