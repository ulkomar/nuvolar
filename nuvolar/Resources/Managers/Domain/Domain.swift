//
//  Domain.swift
//  nuvolar
//
//  Created by Developer on 7.06.24.
//

public protocol DomainMappable {
    associatedtype DomainModel

    var domain: DomainModel { get }
}

extension Optional: DomainMappable where Wrapped: DomainMappable {
    public var domain: Wrapped.DomainModel? {
        switch self {
        case .none:
            return nil
        case let .some(wrapped):
            return wrapped.domain
        }
    }
}

extension Array: DomainMappable where Element: DomainMappable {
    public var domain: [Element.DomainModel] {
        return map(\.domain)
    }
}

