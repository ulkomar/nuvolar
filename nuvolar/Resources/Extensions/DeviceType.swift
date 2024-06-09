//
//  DeviceType.swift
//  nuvolar
//
//  Created by Developer on 9.06.24.
//

import UIKit

struct Device {
    static var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
}
