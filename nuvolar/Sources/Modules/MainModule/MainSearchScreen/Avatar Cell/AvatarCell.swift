//
//  AvatarCell.swift
//  nuvolar
//
//  Created by Developer on 6.06.24.
//

import UIKit
import Combine

final class UserCell: UICollectionViewListCell {
    
    // MARK: - Properties
    
    private var userName = String()
    private let viewModel = AvatarCellViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        accessories = [
            .disclosureIndicator()
        ]
        configureBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - COnfigurations
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
        backgroundConfiguration = UserCell.getBackgroundConfiguration(for: state)
        contentConfiguration = AvatarCellConfiguration(image: viewModel.imageObserver, name: userName)
    }
    
    // MARK: - Setter
    
    func set(imageUrl: String, userName: String) {
        self.userName = userName
        viewModel.fetchImage(urlString: imageUrl)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel.prepareForReuse()
    }
    
    // MARK: - Configurations
    
    static func getBackgroundConfiguration(for state: UICellConfigurationState) -> UIBackgroundConfiguration {
        let bgConfig = UIBackgroundConfiguration.clear()
        return bgConfig
    }    
}

// MARK: - BindingConfigurableView

extension UserCell: BindingConfigurableView {
    func bindInner() {
        viewModel.$imageObserver
            .compactMap { $0 }
            .sink { [weak self] image in
                self?.setNeedsUpdateConfiguration()
            }
            .store(in: &cancellables)
    }
}

