//
//  PhotoListViewController.swift
//  Mars-Curiosity
//
//  Created by Tilek Sulaymanbekov on 6/9/22.
//

import UIKit

class PhotoListViewController: UIViewController, AlertTrait {

    //MARK: - UI Components
 
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = UIColor(named: "background-color")
        return collectionView
    }()
    
    fileprivate lazy var navBarTitleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.font = UIFont(name: "Dosis-Regular", size: 18)
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        return label
    }()
    
    //MARK: - Variables
    
    var images = [ImageSourceModel]()
    
    //MARK: - Dependencies
    
    var presenter: PhotoListViewPresenterProtocol!
    private var dataSource: PhotoCollectionViewDataSource!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.makeRequest()
        setupUI()
    }
    
    private func setupUI() {
        setupTitle()
        view.addSubview(collectionView)
        setupConstraints()
    }
    
    private func setupCollectionView() {
        dataSource = PhotoCollectionViewDataSource(images: images)
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "photoCell")
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
        collectionView.reloadData()
        setupActions()
    }
    
    private func setupTitle() {
        let title = presenter.setupTitle()
        let date = presenter.setupTitleDate()
        navBarTitleLabel.text = "\(title)\n\(date)"
        self.navigationItem.titleView = navBarTitleLabel
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupActions() {
        dataSource.onImageTapped = {[weak self] image in
            self?.presenter.showDetailScreen(image: image)
        }
    }
}

extension PhotoListViewController: PhotoListViewInputPresenter {

    func didGetData(images: [ImageSourceModel]) {
        self.images = images
        if self.images.count == 0 {
            showErrorAlert(message: "There is no data, please change requirements", completion: { [weak self] _ in
                self?.presenter.popToRootVC()
            })
        } else {
            setupCollectionView()
        }
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
        self.showErrorAlert(message: error.localizedDescription)
    }
}

