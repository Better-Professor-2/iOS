//
//  NetworkController.swift
//  BetterProfessorApp
//
//  Created by Cody Morley on 4/30/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class NetworkController {
    //MARK: - Enums and Type Aliases -
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    enum NetworkError: Error {
        
    }
    
    typealias CompletionHandler = (Result<Bool, NetworkError>) -> Void
    
    
    //MARK: - Properties -
    let token = AuthenticationController.shared.authToken
    
    
    
    //MARK: - Network Methods -
    
    
    
    
    
    
    //MARK: - Helper Methods -
    
    
    
    
}
