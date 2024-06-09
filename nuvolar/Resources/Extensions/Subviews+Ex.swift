//
//  Subviews+Ex.swift
//  nuvolar
//
//  Created by Developer on 8.06.24.
//

import UIKit

extension UIView {
    func addSubviews(_ array: [UIView]) {
        array.forEach({ addSubview($0) })
    }
}

extension UIStackView {
    func addArrangedSubviews(_ array: [UIView]) {
        array.forEach({ addArrangedSubview($0) })
    }
}
