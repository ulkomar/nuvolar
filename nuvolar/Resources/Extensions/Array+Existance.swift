//
//  Array+Existance.swift
//  nuvolar
//
//  Created by Developer on 8.06.24.
//

extension Array {
    func get(by index: Int) -> Element? {
        if self.indices.contains(index) {
            self[index]
        } else {
            nil
        }
    }
}
