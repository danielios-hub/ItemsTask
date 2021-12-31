//
//  ErrorViewModel.swift
//  SomeCompanyTask
//
//  Created by Daniel Gallego Peralta on 17/12/21.
//

import Foundation

public struct ErrorViewModel {
    private(set) public var message: String?
    
    public static var noError: ErrorViewModel {
        return ErrorViewModel(message: nil)
    }
    
    public static func error(message: String) -> ErrorViewModel {
        return ErrorViewModel(message: message)
    }
}
