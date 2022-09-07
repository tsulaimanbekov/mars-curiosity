//
//  ViewController.swift
//  Mars-Curiosity
//
//  Created by Tilek Sulaymanbekov on 5/9/22.
//

import UIKit
import SnapKit
import DropDown

class MainViewController: BaseViewController, MainViewPresenterInputProtocol {
    
//MARK: - UI Components
    
    fileprivate lazy var mainBackgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background-main")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Camera and Date"
        label.textColor = .black
        label.font = UIFont(name: "Dosis-SemiBold", size: 18)
        return label
    }()
    
    fileprivate lazy var cameraTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Rover Camera"
        label.textColor = .black
        label.font = UIFont(name: "Dosis-Regular", size: 14)
        return label
    }()
    
    fileprivate lazy var dateTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.textColor = .black
        label.font = UIFont(name: "Dosis-Regular", size: 14)
        return label
    }()
    
    fileprivate lazy var selectionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cameraTitleLabel, selectCameraView, dateTitleLabel, selectDateView])
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    fileprivate lazy var selectCameraView: SelectionView = {
        let view = SelectionView(viewType: .cameraView, frame: .zero)
        view.setupFields()
        return view
    }()
    
    fileprivate lazy var selectDateView: SelectionView = {
        let view = SelectionView(viewType: .dateView, frame: .zero)
        view.setupFields()
        return view
    }()
    
    fileprivate lazy var button: BaseButton = {
        let button = BaseButton()
        return button
    }()
    
    fileprivate lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [selectionStackView, button])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 32
        return stackView
    }()
    
    fileprivate weak var datePicker: UIDatePicker?
    
    //MARK: - Variables
    
    private var camera: String = ""
       
    private var date: String = "" {
        didSet {
            selectDateView.titleLabel.text = date
        }
    }
    
    private var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter
    }()
    
    //MARK: - Dependencies
    
    var presenter: MainViewPresenterProtocol!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        configureConstraints()
        setupDefaultValue()
        setupActions()
    }
    
    //MARK: - Setup
    
    fileprivate func setupDefaultValue() {
        let cameraType = CameraType.allCases
        camera = cameraType.first!.key
        let date = Date()
        self.date = dateFormatter.string(from: date)
    }
    
    fileprivate func addViews() {
        view.addSubview(mainBackgroundView)
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        stackView.addSubview(selectionStackView)
    }
    
    //MARK: - Setup Constraints
    
    fileprivate func datePickerConstraints() {
        datePicker?.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(250)
            make.width.equalTo(300)
        }
    }
    
    fileprivate func configureConstraints() {
        mainBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(46)
            make.top.equalTo(view).offset(100)
            make.centerX.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(view.snp.left).offset(24)
            make.right.equalTo(view.snp.right).offset(-24)
        }
    }
    
    //MARK: - Setup actions (camera and date selections)
    
    fileprivate func setupActions() {
        selectDateView.onDateViewTapped = {[weak self] datePicker in
            guard let self = self else { return }
            self.datePicker = datePicker
            self.view.addSubview(self.datePicker!)
            self.datePickerConstraints()
            self.datePicker?.addTarget(self, action: #selector(self.dateDidChanged), for: .valueChanged)
        }
        
        selectCameraView.onCameraTapped = { [weak self] camera in
            self?.camera = camera.key
        }
        
        button.addTarget(self, action: #selector(exploreButtonDidTap), for: .touchUpInside)
    }
    
    @objc func dateDidChanged(sender: UIDatePicker) {
        let dateString = dateFormatter.string(from: sender.date)
        self.date = dateString
        datePicker?.isHidden = true
    }
    
    @objc func exploreButtonDidTap() {
        let data = CameraModel(camera: camera, date: date)
        presenter.getToNextScreen(data: data)
    }
}
