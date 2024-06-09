//
//  AvatarCellContentView.swift
//  nuvolar
//
//  Created by Developer on 6.06.24.
//

import SwiftUI

final class AvatarCellContentView: UIView, UIContentView {
    
    // MARK: - Configuration
    
    var configuration: UIContentConfiguration {
        didSet {
            if let config = configuration as? AvatarCellConfiguration {
                apply(configuration: config)
            }
        }
    }
    
    // MARK: - Properties
    
    private let iconSize: CGFloat = 60
    
    // MARK: - GUI
    
    private lazy var commonHStack = UIStackView()
    private lazy var avatarView = UIImageView(frame: CGRect(x: 0, y: 0, width: iconSize, height: iconSize))
    private lazy var userName = UILabel()
    
    // MARK: - Initialization
    
    init(configuration: AvatarCellConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        configureView()
        apply(configuration: configuration)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configurations
    
    private func apply(configuration: AvatarCellConfiguration) {
        avatarView.image = configuration.image
        userName.text = configuration.name
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarView.layer.cornerRadius = iconSize / 2
    }
}

// MARK: - LayoutConfigurableView

extension AvatarCellContentView: LayoutConfigurableView {
    func configureSubviews() {
        addSubview(commonHStack)
        commonHStack.translatesAutoresizingMaskIntoConstraints = false
        commonHStack.addArrangedSubview(avatarView)
        commonHStack.addArrangedSubview(userName)
        commonHStack.spacing = 10
        commonHStack.alignment = .center
        // Set up constraints for avatarView
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.contentMode = .scaleAspectFill
        avatarView.backgroundColor = .separator
        
        avatarView.clipsToBounds = true
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.font = UIFont.preferredFont(forTextStyle: .title3)
        userName.adjustsFontForContentSizeCategory = true
        
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            commonHStack.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            commonHStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            commonHStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            commonHStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            avatarView.widthAnchor.constraint(equalToConstant: iconSize),
            avatarView.heightAnchor.constraint(equalToConstant: iconSize),
        ])
    }
}
