//
//  MainSearchViewModel.swift
//  nuvolar
//
//  Created by Developer on 6.06.24.
//

import Combine
import UIKit

protocol MainSearchViewModelLogic: AnyObject {
    var users: [GitHubUsersModel.Item] { get }
    
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
    
    private(set) var users = [GitHubUsersModel.Item]()
    private var page = 0
    private var requestString = ""
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
        stateSubject.send(.updateModels(users.map({ $0.domain })))
    }
    
    func sendSearchRequest(for userName: String, page: Int = 0) {
        Task { @MainActor in
            let request = GitHubUsersModel(name: userName.lowercased(), page: page)
            do {
                self.requestString = userName
                let response = try await netServices.send(request: request)
                users = response.items
                let models = response.items.map({ $0.domain })
                stateSubject.send(.updateModels(models))
            } catch {
                print(error)
            }
        }
    }
    
    func sendSearchRequestForPaging(currentVisibleIndex index: Int) {
        guard index >= users.count - 1 && users.count > 15 else { return }
        page += 1
        sendSearchRequest(for: requestString, page: page)
    }
}
