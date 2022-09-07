//
//  Router.swift
//  Mars-Curiosity
//
//  Created by Tilek Sulaymanbekov on 6/9/22.
//

import Foundation
import UIKit

protocol BaseRouterProtocol: AnyObject {
    var navigationController: UINavigationController? { get set }
    var builder: BuilderProtocol? { get set }
}

protocol RouterProtocol: BaseRouterProtocol {
    func initialViewController()
    func showPhotosVC(data: CameraModel)
    func showDetailPhotoVC(image: String)
    func popToRoot()
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var builder: BuilderProtocol?
    
    init(navigationController: UINavigationController, builder: BuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func initialViewController() {
        if let navC = navigationController {
            guard let mainVC = builder?.createMainVC(router: self) else { return }
            navC.viewControllers = [mainVC]
        }
    }
    
    func showPhotosVC(data: CameraModel) {
        if let navC = navigationController {
            guard let photosVC = builder?.createPhotosView(router: self, data: data) else { return }
            navC.pushViewController(photosVC, animated: true)
        }
    }
    
    func showDetailPhotoVC(image: String) {
        if let navC = navigationController {
            guard let detailPhotoVC = builder?.createPhotoDetailView(image: image) else { return }
            navC.pushViewController(detailPhotoVC, animated: true)
        }
    }
    
    func popToRoot() {
        if let navC = navigationController {
            navC.popViewController(animated: true)
        }
    }
}
