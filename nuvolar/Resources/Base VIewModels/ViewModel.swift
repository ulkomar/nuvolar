//
//  ViewModel.swift
//  nuvolar
//
//  Created by Developer on 6.06.24.
//

import Combine

protocol IViewModel: ObservableObject {
    var netServices: NetServiceProtocol { get }
    var coordinator: CoordinatorProtocol? { get set }
}

class ViewModel: IViewModel {
    var netServices: NetServiceProtocol
    
    init(netServices: NetServiceProtocol = Net()) {
        self.netServices = netServices
    }
    
    var cancellables: Set<AnyCancellable> = []
    var coordinator: CoordinatorProtocol?
}
