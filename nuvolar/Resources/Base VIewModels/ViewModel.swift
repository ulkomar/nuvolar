//
//  ViewModel.swift
//  nuvolar
//
//  Created by Developer on 6.06.24.
//

import Combine

protocol IViewModel: ObservableObject {
    var netServices: Net { get }
    var coordinator: CoordinatorProtocol? { get set }
}

extension IViewModel {
    var netServices: Net {
        Net()
    }
}

class ViewModel: IViewModel {
    var cancellables: Set<AnyCancellable> = []
    var coordinator: CoordinatorProtocol?
}
