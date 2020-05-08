//
//  ResponseCodes.swift
//  TempbuddyV2Tests
//
//  Created by Joyce Rosario on 31/03/2020.
//  Copyright © 2020 TempBuddy. All rights reserved.
//

import Foundation

enum ResponseCode: Int {
       
    case success = 200
    case serverError = 500
    case badRequest = 400
    case notFound = 404
    case unauthorized = 401
    
    func intValue() -> Int {
        return self.rawValue
    }
}
