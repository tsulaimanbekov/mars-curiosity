//
//  PhotoListViewController.swift
//  Mars-Curiosity
//
//  Created by Tilek Sulaymanbekov on 6/9/22.
//

import UIKit

class PhotoListViewController: UIViewController {
    
    //MARK: - UI Components
    fileprivate lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView()
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "background-color")
    }

}
