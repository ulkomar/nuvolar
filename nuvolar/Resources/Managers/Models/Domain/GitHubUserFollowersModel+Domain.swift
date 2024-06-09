//
//  GitHubUserFollowersModel+Domain.swift
//  nuvolar
//
//  Created by Developer on 9.06.24.
//

import UIKit

extension GitHubUserFollowersModel.Follower: DomainMappable {
    public var domain: String {
        login
    }
}

