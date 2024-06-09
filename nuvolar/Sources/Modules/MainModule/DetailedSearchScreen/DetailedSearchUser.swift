//
//  DetailedSearchUser.swift
//  nuvolar
//
//  Created by Developer on 9.06.24.
//

import Foundation

enum DetailedSearchUser {
    enum State {
        case initial(user: GitHubUsersModel.Item)
        case updatingFollowers([String])
        case updatingFollowings([String])
        case updatingRepos([String])
        case updatingUserInfo(_ info: (name: String?, company: String?, createdAt: String, updatedAt: String))
    }
    
    enum Event {
    }
}
