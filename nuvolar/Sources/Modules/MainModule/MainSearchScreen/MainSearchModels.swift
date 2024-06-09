//
//  MainSearchModels.swift
//  nuvolar
//
//  Created by Developer on 6.06.24.
//

enum MainSearchModels {
    enum State {
        case emptyViewShowing
        case searchingModeShowing
        case updateModels([UserModel])
    }
    
    enum Event {
        case tappedUser(GitHubUsersModel.Item)
    }
}
