//
//  DetailedSearchUserViewModel.swift
//  nuvolar
//
//  Created by Developer on 9.06.24.
//

import Combine
import UIKit

protocol DetailedSearchUserViewModelLogic: AnyObject {
    var state: AnyPublisher<DetailedSearchUser.State, Never> { get }
    var event: AnyPublisher<DetailedSearchUser.Event, Never> { get }

    func prepareForDisplayint()
}

final class DetailedSearchUserViewModel: ViewModel {
    
    // MARK: - Private properties
    
    private let stateSubject: CurrentValueSubject<DetailedSearchUser.State, Never>
    private let eventSubject = PassthroughSubject<DetailedSearchUser.Event, Never>()
    private let user: GitHubUsersModel.Item
    
    // MARK: - Initialization

    init(user: GitHubUsersModel.Item) {
        self.user = user
        stateSubject = .init(.initial(user: user))
    }
}

// MARK: - MainSearchViewModelLogic

extension DetailedSearchUserViewModel: DetailedSearchUserViewModelLogic {
    
    // MARK: - Public properties
    
    var state: AnyPublisher<DetailedSearchUser.State, Never> {
        self.stateSubject.eraseToAnyPublisher()
    }
    
    var event: AnyPublisher<DetailedSearchUser.Event, Never> {
        self.eventSubject.eraseToAnyPublisher()
    }
    
    func prepareForDisplayint() {
        getchUserInfo()
        fetchFollowers()
        fetchFollowing()
        fetchRepos()
    }
    
    // MARK: - Public protocol methods
    
    private func getchUserInfo() {
        Task { @MainActor in
            do {
                let userInfoRequest = GitHubUserInfoModel()
                let userInfo = try await netServices.send(request: userInfoRequest, url: user.url)
                stateSubject.send(.updatingUserInfo(userInfo.domain))
            } catch {
                stateSubject.send(.updatingUserInfo(nil))
                print("getchUserInfo error: ", error.localizedDescription, " || ", error)
            }
        }
    }
    
    private func fetchFollowers() {
        Task { @MainActor in
            do {
                let followersRequest = GitHubUserFollowersModel()
                let followers = try await netServices.send(request: followersRequest, url: user.followersUrl)
                stateSubject.send(.updatingFollowers(followers.domain))
            } catch {
                stateSubject.send(.updatingFollowers(nil))
                print("fetchFollowers error: ", error.localizedDescription, " || ", error)
            }
        }
    }
    
    private func fetchFollowing() {
        Task { @MainActor in
            do {
                let followingRequest = GitHubUserFollowingModel()
                let followings = try await netServices.send(request: followingRequest, url: user.followingUrl.withoutCurlyBraces())
                stateSubject.send(.updatingFollowings(followings.domain))
            } catch {
                stateSubject.send(.updatingFollowings(nil))
                print("fetchFollowing error: ", error.localizedDescription, " || ", error)
            }
        }
    }
    
    private func fetchRepos() {
        Task { @MainActor in
            do {
                let repoRequest = GitHubUserReposModel()
                let repos = try await netServices.send(request: repoRequest, url: user.reposUrl)
                stateSubject.send(.updatingRepos(repos.domain))
            } catch {
                stateSubject.send(.updatingRepos(nil))
                print("fetchRepos error: ", error.localizedDescription, " || ", error)
            }
        }
    }
}
