//
//  CoordinatorProtocol.swift
//  nuvolar
//
//  Created by Developer on 6.06.24.
//

import Combine

protocol CoordinatorProtocol: AnyObject {
    var cancellables: Set<AnyCancellable> { get set }
}
