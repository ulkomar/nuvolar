//
//  MainSearchViewModel.swift
//  nuvolar
//
//  Created by Developer on 6.06.24.
//

import Combine
import UIKit

protocol MainSearchViewModelLogic: AnyObject {
    var state: AnyPublisher<MainSearchModels.State, Never> { get }
    var event: AnyPublisher<MainSearchModels.Event, Never> { get }
    
    func sendSearchRequestForPaging(currentVisibleIndex index: Int)
    func searchingFieldStatedChanged(isFocused: Bool)
    func sendSearchRequest(for userName: String, page: Int)
    func tapped(at index: Int)
    func cancellSearchButtonTapped()
}

final class MainSearchViewModel: ViewModel {
    
    // MARK: - Private properties
    
    private let stateSubject = CurrentValueSubject<MainSearchModels.State, Never>(.emptyViewShowing)
    private let eventSubject = PassthroughSubject<MainSearchModels.Event, Never>()
    
    private var users = [GitHubUsersModel.Item]()
    private var userModels = [UserModel]()
    private var page = 0
    private var requestString = ""
    private var isLoading = false
}

// MARK: - MainSearchViewModelLogic

extension MainSearchViewModel: MainSearchViewModelLogic {
    
    // MARK: - Public properties
    
    var state: AnyPublisher<MainSearchModels.State, Never> {
        self.stateSubject.eraseToAnyPublisher()
    }
    
    var event: AnyPublisher<MainSearchModels.Event, Never> {
        self.eventSubject.eraseToAnyPublisher()
    }
    
    // MARK: - Public protocol methods
    
    func searchingFieldStatedChanged(isFocused: Bool) {
        stateSubject.send(isFocused ? .searchingModeShowing : .emptyViewShowing)
    }
    
    func tapped(at index: Int) {
        guard let user = users.get(by: index) else { return }
        eventSubject.send(.tappedUser(user))
    }
    
    func cancellSearchButtonTapped() {
        users = []
        page = 0
        stateSubject.send(.updateModels(users.map({ $0.domain })))
    }
    
    func sendSearchRequest(for userName: String, page: Int = 0) {
        isLoading = true
        Task { @MainActor in
            let request = GitHubUsersModel(name: userName.lowercased(), page: page)
            do {
                self.requestString = userName
                let response = try await netServices.send(request: request)
                if page == 0 {
                    self.users = response.items
                } else {
                    self.users.append(contentsOf: response.items)
                }
                let models = self.users.map({ $0.domain })
                userModels = self.users.map({ $0.domain })
                self.stateSubject.send(.updateModels(models))
                self.isLoading = false
            } catch {
                print(error)
                self.isLoading = false
            }
        }
    }
    
    func sendSearchRequestForPaging(currentVisibleIndex index: Int) {
        guard index >= users.count - 1 && users.count > 15 && !isLoading else { return }
        page += 1
        sendSearchRequest(for: requestString, page: page)
    }
}
