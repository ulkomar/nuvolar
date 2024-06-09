//
//  InfoTitleBodyLabel.swift
//  nuvolar
//
//  Created by Developer on 8.06.24.
//

import UIKit

final class ImageTextView: UIStackView {
    
    // MARK: - GUI
    
    private lazy var logoView = UIImageView()
    private lazy var labelView = UILabel()
    
    // MARK: - Public API property
    
    var label: String? {
        get {
            labelView.text
        }
        set {
            labelView.text = newValue
        }
    }
    
    var image: UIImage? {
        get {
            logoView.image
        }
        set {
            logoView.image = newValue
        }
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        logoView.layer.cornerRadius = logoView.frame.width / 2
    }
    
    // MARK: - Setter
    
    func set(image: UIImage, text: String) {
        self.logoView.image = image
        labelView.text = text
    }
}

extension ImageTextView: LayoutConfigurableView {
    func configureViewProperties() {
        axis = .vertical
        alignment = .center
        spacing = 20
    }
    
    func configureSubviews() {
        addArrangedSubviews([logoView, labelView])
        
        logoView.clipsToBounds = true
        logoView.contentMode = .scaleAspectFill
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.layer.borderColor = UIColor.separator.withAlphaComponent(0.2).cgColor
        logoView.layer.borderWidth = 1
        
        labelView.font = UIFont.preferredFont(forTextStyle: .headline).withSize(16)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            logoView.widthAnchor.constraint(equalToConstant: 150),
            logoView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
}
