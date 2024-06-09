//
//  GitHubUserInfoModel+Domain.swift
//  nuvolar
//
//  Created by Developer on 9.06.24.
//

import Foundation

extension GitHubUserInfoModel.Reponse: DomainMappable {
    var domain: (name: String?, company: String?, createdAt: String, updatedAt: String) {
        (name: name, company: company, createdAt: createdAt, updatedAt: updatedAt)
    }
}
