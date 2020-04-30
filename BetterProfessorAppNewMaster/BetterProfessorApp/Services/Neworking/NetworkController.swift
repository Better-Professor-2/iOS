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
        case notLoggedIn
        case otherError
        case badResponse
        case noData
        case coreDataFail
        case noEncode
        case noDecode
    }
    
    typealias CompletionHandler = (Result<Bool, NetworkError>) -> Void
    
    
    //MARK: - Properties -
    static let shared = NetworkController()
    private let token: Token? = AuthenticationController.shared.authToken
    private var baseURL = URL(string: "https://better-professor-karavil.herokuapp.com/auth")!
    
    //TODO 3 URL combinations for server fetches
    private lazy var studentsURL = baseURL.appendingPathComponent("/students/")
    
    private lazy var jsonEncoder = JSONEncoder()
    private lazy var jsonDecoder = JSONDecoder()
    
    
    //MARK: - Network Methods -
    
    func getStudents(token: Token?, completion: @escaping CompletionHandler) {
        guard let tokenString = token?.token else {
            NSLog("Error - No token")
            return completion(.failure(.notLoggedIn)) }
        
        var request = getRequest(for: studentsURL)
        request.addValue(tokenString, forHTTPHeaderField: "Authoriztation")
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                NSLog("Error - Failed fetching students. \(error) \(error.localizedDescription)")
                return completion(.failure(.otherError))
            }
            
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                    NSLog("Error - Bad Response. Unable to fetch students. \(error) \(error?.localizedDescription)")
                    return completion(.failure(.badResponse))
            }
            
            guard let data = data else {
                NSLog("Error - No data recieved. Unable to fetch students \(error) \(error?.localizedDescription)")
                return completion(.failure(.noData))
            }
            
            do {
                let studentReps = try self.jsonDecoder.decode([StudentRepresentation].self, from: data)
                for student in studentReps {
                    Student(representation: student)
                }
                
                do {
                    try CoreDataStack.shared.mainContext.save()
                    return completion(.success(true))
                } catch {
                    NSLog("Error - Error saving students to core data. \(error)")
                    return completion(.failure(.coreDataFail))
                }
                
            } catch {
                NSLog("Error - Error decoding student representations. \(error)")
                return completion(.failure(.noDecode))
            }
        }.resume()
    }
    
   func getUserData()
    
    
    
    
    
    
    
    //MARK: - Helper Methods -
    
    private func getRequest(for url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    
}
