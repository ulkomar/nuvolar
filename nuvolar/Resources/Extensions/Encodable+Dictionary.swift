//
//  Encodable+Dictionary.swift
//  nuvolar
//
//  Created by Developer on 6.06.24.
//

import Foundation

extension Encodable {
    func toDictionary() -> [String: String]? {
        do {
            let data = try JSONEncoder().encode(self)
            if let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                var dictionary = [String: String]()
                for (key, value) in jsonObject {
                    if let stringValue = value as? String {
                        dictionary[key] = stringValue
                    } else if let numberValue = value as? NSNumber {
                        dictionary[key] = numberValue.stringValue
                    }
                }
                return dictionary
            }
        } catch {
            print("Error encoding to dictionary: \(error)")
        }
        return nil
    }
}
