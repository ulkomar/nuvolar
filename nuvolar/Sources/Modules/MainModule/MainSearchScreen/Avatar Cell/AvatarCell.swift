//
//  AvatarCell.swift
//  nuvolar
//
//  Created by Developer on 6.06.24.
//

import UIKit

final class UserCell: UICollectionViewListCell {
    
    // MARK: - Properties
    
    private var userImage = UIImage()
    private var userName = String()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        accessories = [
            .disclosureIndicator()
        ]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - COnfigurations
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
        backgroundConfiguration = UserCell.getBackgroundConfiguration(for: state)
        contentConfiguration = AvatarCellConfiguration(image: userImage, name: userName)
    }
    
    // MARK: -Setter
    
    func set(userImage: UIImage, userName: String) {
        self.userName = userName
        self.userImage = userImage
    }
    
    // MARK: - Configurations
    
    static func getBackgroundConfiguration(for state: UICellConfigurationState) -> UIBackgroundConfiguration {
        var bgConfig = UIBackgroundConfiguration.listPlainCell()
        bgConfig.cornerRadius = 20
        return bgConfig
    }    
}

