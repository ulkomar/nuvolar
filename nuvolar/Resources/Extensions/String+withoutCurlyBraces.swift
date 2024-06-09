//
//  String+withoutCurlyBraces.swift
//  nuvolar
//
//  Created by Developer on 9.06.24.
//

import Foundation

extension String {
    func withoutCurlyBraces() -> String {
        self.replacingOccurrences(of: #"\{.*\}"#,
                                              with: "",
                             options: .regularExpression)
            .trimmingCharacters(in: .whitespaces)
    }
}
