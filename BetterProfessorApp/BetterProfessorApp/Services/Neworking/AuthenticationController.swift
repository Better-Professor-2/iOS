//
//  AuthenticationController.swift
//  BetterProfessorApp
//
//  Created by Cody Morley on 4/29/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation
import UIKit

class AuthenticationController {
    //MARK: - Enums & Type Aliases -
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    enum NetworkError: Error {
        case failedRegister
        case failedLogIn
        case noData
        case noEncode
        case noDecode
        case badResponse
        
    }
    
    typealias CompletionHandler = (Result<Bool, NetworkError>) -> Void
    
    
    //MARK: - Properties -
    private var baseURL = URL(string: "https://better-professor-karavil.herokuapp.com/auth")!
    
    private lazy var registerURL = baseURL.appendingPathComponent("/register/")
    private lazy var loginURL = baseURL.appendingPathComponent("/login/")
    
    private lazy var jsonEncoder = JSONEncoder()
    private lazy var jsonDecoder = JSONDecoder()
    
    var id: Int?
    var authToken: Token?
    static let shared = AuthenticationController()
    
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
                
                guard let response = response as? HTTPURLResponse,
                    response.statusCode == 201 else {
                        NSLog("Error - Bad Response. Registration Unsucessful: \(error) \(error?.localizedDescription)")
                        return completion(.failure(.badResponse))
                }
                
                guard let data = data else {
                    NSLog("Error - No data recieved")
                    return completion(.failure(.noData))
                }
                
                do {
                    self.id = try self.jsonDecoder.decode(ProfessorID.self, from: data).id
                    completion(.success(true))
                    print(data)
                } catch {
                    NSLog("Error - Error decoding data from source: \(error) \(error.localizedDescription)")
                    return completion(.failure(.noDecode))
                }
            }.resume()
        } catch {
            NSLog("Error - Error encoding user credentials. \(error) \(error.localizedDescription)")
            return completion(.failure(.noEncode))
        }
        
    }
    
    func login(login: Login, completion: @escaping CompletionHandler) {
        var request = postRequest(for: loginURL)
        
        do {
            let jsonData = try jsonEncoder.encode(login)
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    NSLog("Error - Not logged in: \(error) \(error.localizedDescription)")
                    return completion(.failure(.failedLogIn))
                }
                
                guard let response = response as? HTTPURLResponse,
                    response.statusCode == 200
                    else {
                        NSLog("Error - Sign in was unsuccessful, bad response. \(error)")
                        return completion(.failure(.failedLogIn))
                }
                
                guard let data = data else {
                    NSLog("Error - Sign in unsuccessful, no data recieved. \(error)")
                    return completion(.failure(.noData))
                }
                
                do {
                    self.authToken = try self.jsonDecoder.decode(Token.self, from: data)
                    completion(.success(true))
                } catch {
                    NSLog("Error - Sign in unsuccessful. Error Decoding token. \(error)")
                    return completion(.failure(.noDecode))
                }
            }
        .resume()
        } catch {
            NSLog("Error - Sign in unsuccessful. Error encoding user info to database. \(error)")
            return completion(.failure(.noEncode))
        }
        
        
        
    }
    
    
    //MARK: - Helper Functions -
    private func postRequest(for url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    
}


