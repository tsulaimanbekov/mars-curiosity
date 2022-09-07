//
//  SelectionView.swift
//  Mars-Curiosity
//
//  Created by Tilek Sulaymanbekov on 5/9/22.
//

import UIKit
import SnapKit
import DropDown

enum ViewType {
    case cameraView
    case dateView
}

class SelectionView: UIView {
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 300, height: 60)
    }
    
    var viewType: ViewType!
    var cameras = CameraType.allCases
    var onDateViewTapped: ((UIDatePicker) -> Void)!
    var onCameraTapped: ((CameraType) -> Void)!
    private lazy var icon = UIImageView()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Dosis-Regular", size: 18)
        label.textColor = .black
        label.isUserInteractionEnabled = true
        return label
    }()
    
    fileprivate lazy var dropdown: DropDown = {
        let dropdown = DropDown(anchorView: self)
        dropdown.width = self.frame.width
        dropdown.cornerRadius = 10
        dropdown.textFont = UIFont(name: "Dosis-Regular", size: 18)!
        dropdown.dataSource = cameras.map { $0.title }
        dropdown.selectionAction = { [weak self] index, value in
            guard let self = self else { return }
            self.titleLabel.text = value
            self.onCameraTapped(self.cameras[index])
        }
        return dropdown
    }()
    
    convenience init(viewType: ViewType, frame: CGRect) {
        self.init(frame: frame)
        self.viewType = viewType
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    fileprivate func setup() {
        backgroundColor = .white
        layer.cornerRadius = 10
        addSubview(titleLabel)
        addSubview(self.icon)
        configureConstraints()
    }
    
    func setupFields() {
        switch viewType {
        case .dateView:
            configureDatePicker()
            icon.image = UIImage(named: "icon-calendar")
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd"
            let dateString = dateFormatter.string(from: Date())
            titleLabel.text = dateString
        case .cameraView:
            configureDropdown()
            icon.image = UIImage(named: "icon-dropdown")
            titleLabel.text = cameras.first.map { $0.title }
        default: break
        }
    }
    
    fileprivate func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(16)
            make.right.equalTo(self.snp.right).offset(-32)
            make.centerY.equalToSuperview()
        }
        
        icon.snp.makeConstraints { make in
            make.right.equalTo(self.snp.right).offset(-16)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(24)
        }
    }
    
    fileprivate func configureDropdown() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapCameraView))
        titleLabel.addGestureRecognizer(gesture)
    }
    
    fileprivate func configureDatePicker() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapDateView))
        titleLabel.addGestureRecognizer(gesture)
    }
    
    @objc func didTapCameraView() {
        dropdown.show()
    }
    
    @objc func didTapDateView() {
        onDateViewTapped(openDatePicker())
    }
    
    fileprivate func openDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.date = Date()
        datePicker.locale = .current
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        return datePicker
    }
}
