//
//  AuthenticationController.swift
//  BetterProfessorApp
//
//  Created by Cody Morley on 4/29/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation
import UIKit

struct AuthenticationController {
    //MARK: - Enums & Type Aliases -
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    enum NetworkError {
        case failedRegister
        case noData
        case noEncode
        case noDecode
        
    }
    
    typealias CompletionHandler = (Result<Bool, NetworkError>) -> Void
    
    
    //MARK: - Properties -
    private let baseURL = URL(string: "https://better-professor-karavil.herokuapp.com/auth")!
    
    private lazy var registerURL = baseURL.appendingPathComponent("/register/")
    private lazy var loginURL = baseURL.appendingPathComponent("/login/")
    
    private lazy var jsonEncoder = JSONEncoder()
    private lazy var jsonDecoder = JSONDecoder()
    
    private var id: Int?
    
    
    //MARK: - Network Functions -
    func register(with credentials: UserCredentials, completion: @escaping CompletionHandler) {
        var request = postRequest(for: registerURL)
        
        do {
            let jsonData = try jsonEncoder.encode(credentials)
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    NSLog("Error - failed to register new user: \(error) \(error.localizedDescription)")
                    completion(.failure(.failedRegister))
                    return
                }
                
                guard let response = response as? HTTPPURLResponse,
                    response.statusCode == 201 else {
                        NSLog("Error - Bad Response: Registration Unsucessful: "  + String(describing: response.statusCode))
                        return completion(.failure(.failedRegister))
                }
                
                guard let data = data else {
                    NSLog("Error - No data recieved")
                    return completion(.failure(.noData))
                }
                
                do {
                    let self.id = try self.jsonDecoder.decode(id.self, from: data)
                    completion(.success(true))
                } catch {
                    NSLog("Error - Error decoding data from source: \(error) \(error.localizedDescription)")
                    return completion(.failure(.noDecode))
                }
            } catch {
                NSLog("Error - Error encoding user credentials. \(error) \(error.localizedDescription)")
                return completion(.failure(.noEncode))
            }
        
    }
    
    
    
    
}
