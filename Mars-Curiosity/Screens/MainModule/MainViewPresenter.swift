//
//  MainViewPresenter.swift
//  Mars-Curiosity
//
//  Created by Tilek Sulaymanbekov on 6/9/22.
//

import Foundation
import UIKit

protocol MainViewPresenterInputProtocol: AnyObject {}

protocol MainViewPresenterProtocol: MainViewPresenterInputProtocol {
    
    init(view: MainViewPresenterInputProtocol, network: RequestManager, router: RouterProtocol)
    
    func getToNextScreen(data: CameraModel)
}

class MainViewPresenter: MainViewPresenterProtocol {

    private weak var view: MainViewPresenterInputProtocol?
    private var router: RouterProtocol?
    private var network: RequestManager?
    
    required init(view: MainViewPresenterInputProtocol, network: RequestManager, router: RouterProtocol) {
        self.view = view
        self.network = network
        self.router = router
    }
    
    func getToNextScreen(data: CameraModel) {
        router?.showPhotos(data: data)
    }
}
