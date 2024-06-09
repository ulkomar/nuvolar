//
//  DetailedSearchUser.swift
//  nuvolar
//
//  Created by Developer on 9.06.24.
//

import UIKit

enum DetailedSearchUser {
    enum State {
        case initial(user: GitHubUsersModel.Item)
        case updatedUserProfile(UIImage?)
        case updatingFollowers([String]?)
        case updatingFollowings([String]?)
        case updatingRepos([String]?)
        case updatingUserInfo(_ info: (name: String?, company: String?, createdAt: String, updatedAt: String)?)
    }
    
    enum Event {
    }
}
