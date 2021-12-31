//
//  HTTPURLResponse+isOK.swift
//  SomeCompanyTask
//
//  Created by Daniel Gallego Peralta on 16/12/21.
//

import Foundation

public extension HTTPURLResponse {
    
    func isOK() -> Bool {
        return (200...299).contains(statusCode)
    }
    
}
