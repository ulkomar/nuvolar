//
//  AvatarCellConfiguration.swift
//  nuvolar
//
//  Created by Developer on 6.06.24.
//

import UIKit

struct AvatarCellConfiguration: UIContentConfiguration {
    // MARK: - Properties

    let image: UIImage?
    let name: String

    // MARK: - Open methods

    func makeContentView() -> UIView & UIContentView {
        AvatarCellContentView(configuration: self)
    }

    func updated(for state: UIConfigurationState) -> AvatarCellConfiguration {
        return self
    }
}
