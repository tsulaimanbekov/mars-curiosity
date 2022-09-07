//
//  PhotoListViewPresenter.swift
//  Mars-Curiosity
//
//  Created by Tilek Sulaymanbekov on 6/9/22.
//

import Foundation

protocol PhotoListViewInputPresenter: AnyObject {
    func didGetData(images: [ImageSourceModel])
    func failure(error: Error)
}

protocol PhotoListViewPresenterProtocol {
    init(view: PhotoListViewInputPresenter, network: RequestManagerProtocol, router: RouterProtocol, data: CameraModel)
    
    func showDetailScreen(image: String)
    func makeRequest()
    func popToRootVC()
    func setupTitle() -> String
    func setupTitleDate() -> String
}

class PhotoListViewPresenter: PhotoListViewPresenterProtocol {

    private weak var view: PhotoListViewInputPresenter?
    private var network: RequestManagerProtocol
    private var router: RouterProtocol
    private var data: CameraModel
    
    required init(view: PhotoListViewInputPresenter,
                  network: RequestManagerProtocol,
                  router: RouterProtocol,
                  data: CameraModel) {
        self.view = view
        self.router = router
        self.network = network
        self.data = data
    }
    
    func setupTitle() -> String {
        data.camera
    }
    
    func setupTitleDate() -> String {
        data.date
    }
    
    func showDetailScreen(image: String) {
        router.showDetailPhotoVC(image: image)
    }
    
    func popToRootVC() {
        router.popToRoot()
    }
    
    func makeRequest() {
        do {
            try network.perform(RequestPhotoList.getPhotos(data: data)) { (result: Result<PhotoViewModelResponse?, Error>) in
                switch result {
                case .success(let success):
                    if let object = success {
                        self.view?.didGetData(images: object.photos)
                    }
                case .failure(let failure):
                    self.view?.failure(error: failure)
                }
            }
        }
        catch {
            self.view?.failure(error: error)
        }
    }
}
