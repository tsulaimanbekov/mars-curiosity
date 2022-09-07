//
//  AppDependencyContainer.swift
//  Mars-Curiosity
//
//  Created by Tilek Sulaymanbekov on 5/9/22.
//

import Foundation
import UIKit

protocol BuilderProtocol {
    func createMainVC(router: RouterProtocol) -> UIViewController
    func createPhotosView(router: RouterProtocol, data: CameraModel) -> UIViewController
    func createPhotoDetailView(image: String) -> UIViewController
}

class Builder: BuilderProtocol {
    
    let network = RequestManager()
    
    func createMainVC(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let presenter = MainViewPresenter(view: view, network: network, router: router)
        view.presenter = presenter
        return view
    }
    
    func createPhotosView(router: RouterProtocol, data: CameraModel) -> UIViewController {
        let view = PhotoListViewController()
        let presenter = PhotoListViewPresenter(view: view, network: network, router: router, data: data)
        view.presenter = presenter
        return view
    }
    
    func createPhotoDetailView(image: String) -> UIViewController {
        let view = PhotoDetailViewController()
        let presenter = PhotoDetailPresenter(view: view, image: image)
        view.presenter = presenter
        return view
    }
}
