//
//  GitHubUsersModel+Domain.swift
//  nuvolar
//
//  Created by Developer on 7.06.24.
//

import UIKit

extension GitHubUsersModel.Item: DomainMappable {
    var domain: UserModel {
        UserModel(name: login, image: UIImage())
    }
}
