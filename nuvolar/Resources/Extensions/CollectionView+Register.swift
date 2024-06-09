//
//  CollectionView+Register.swift
//  nuvolar
//
//  Created by Developer on 6.06.24.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(cellType: T.Type) {
        self.register(cellType, forCellWithReuseIdentifier: cellType.identifier)
    }
}
