//
//  PhotoDetailViewController.swift
//  Mars-Curiosity
//
//  Created by Tilek Sulaymanbekov on 6/9/22.
//

import UIKit
import Kingfisher

class PhotoDetailViewController: UIViewController, AlertTrait {

    //MARK: - UI Components
    
    fileprivate lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //MARK: - Variable
    
    var image: URL!
    
    
    //MARK: - Dependencies
        
    var presenter: PhotoDetailPresenterProtocol!
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupUI()
        presenter.loadImage()
        prepareShareButton()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        view.addSubview(imageView)
  
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.equalTo(view.safeAreaInsets.top).offset(96)
            make.left.equalTo(view.snp.left).offset(16)
            make.right.equalTo(view.snp.right).offset(-16)
            make.bottom.equalTo(view.safeAreaInsets.bottom).offset(-32)
        }
    }
    
    private func prepareShareButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareBtnDidTap))
        self.navigationItem.rightBarButtonItem = button
    }
    
    @objc func shareBtnDidTap(sender: UIView) {
        showShareActivity(with: image)
    }
}

extension PhotoDetailViewController: PhotoDetailViewProtocol {
    func loadImage(from image: String) {
        if let url = URL(string: image) {
            self.image = url
            imageView.kf.setImage(with: url)
        }
    }
}

