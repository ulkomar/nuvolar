//
//  NetworkErrors.swift
//  nuvolar
//
//  Created by Developer on 7.06.24.
//

import Foundation

enum NetworkErrors: Error {
    case badURL
    case requestFailed
    case decodingFailed
}
