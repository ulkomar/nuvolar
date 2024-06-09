//
//  UserModel.swift
//  nuvolar
//
//  Created by Developer on 6.06.24.
//

import UIKit

struct UserModel: Identifiable, Hashable {
    var id: String = UUID().uuidString
    let name: String
    let url: String
}
