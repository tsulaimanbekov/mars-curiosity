//
//  PhotoDetailPresenter.swift
//  Mars-Curiosity
//
//  Created by Tilek Sulaymanbekov on 7/9/22.
//

import Foundation

protocol PhotoDetailViewProtocol: AnyObject {
    func loadImage(from image: String)
}

protocol PhotoDetailPresenterProtocol {
    init(view: PhotoDetailViewProtocol, image: String)
    func loadImage()
}

class PhotoDetailPresenter: PhotoDetailPresenterProtocol {
    
    private var image: String!
    private weak var view: PhotoDetailViewProtocol?
    
    required init(view: PhotoDetailViewProtocol, image: String) {
        self.image = image
        self.view = view
    }
    
    func loadImage() {
        view?.loadImage(from: image)
    }
}
