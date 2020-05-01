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

//MARK: - NOTES
/// Keep in mind: The prefix 'get' is used for server tasks while 'fetch' is used for core data tasks to avoid overlap in syntax.

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
    private lazy var professorURL = baseURL.appendingPathComponent("/profile")
    
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
    
    func getUserData(token: Token?, completion: @escaping CompletionHandler) {
        guard let tokenString = token?.token else {
            NSLog("Error - No token")
            return completion(.failure(.notLoggedIn))
        }
        
        var request = getRequest(for: professorURL)
        request.addValue(tokenString, forHTTPHeaderField: "Authoriztation")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                NSLog("Error - Something went wrong fetching your profile information. \(error) \(error.localizedDescription)")
                return completion(.failure(.otherError))
            }
            
            guard let response = response as? HTTPURLResponse,
            response.statusCode == 200 else {
                    NSLog("Error - Bad Response while fetching profile information. \(error) \(error?.localizedDescription)")
                    return completion(.failure(.badResponse))
            }
            
            guard let data = data else {
                NSLog("Error - No professor object returned. \(error) \(error?.localizedDescription)")
                return completion(.failure(.noData))
            }
            
            do {
                let professorRep = try self.jsonDecoder.decode(ProfessorRepresentation.self, from: data)
                Professor(representation: professorRep)
                
                do {
                    try CoreDataStack.shared.mainContext.save()
                    return completion(.success(true))
                } catch {
                    NSLog("Error - Error saving professor to core data. \(error)")
                    return completion(.failure(.coreDataFail))
                }
                
            } catch {
                NSLog("Error - Error decoding professor representation. \(error)")
                return completion(.failure(.noDecode))
            }
        }.resume()
    }
    
    func getDeadlines(token: Token?, studentID: Int, completion: @escaping CompletionHandler) {
        guard let tokenString = token?.token else {
            NSLog("Error - No Token.")
            return completion(.failure(.notLoggedIn))
        }
        
        var request = getRequest(for: makeDeadlineURL(studentID: studentID))
        request.addValue(tokenString, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                NSLog("Error - Error fetching deadlines: \(error) \(error.localizedDescription)")
                return completion(.failure(.otherError))
            }
            
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                    NSLog("Error - Bad response fetching deadlines: \(error) \(error?.localizedDescription)")
                    return completion(.failure(.badResponse))
            }
            
            guard let data = data else {
                NSLog("Error - No data returned from deadline fetch. \(error) \(error?.localizedDescription)")
                return completion(.failure(.noData))
            }
            
            do {
                let deadlineReps = try self.jsonDecoder.decode([DeadlineRepresentation].self, from: data)
                for deadline in deadlineReps {
                    Deadline(representation: deadline)
                }
                
                do {
                    try CoreDataStack.shared.mainContext.save()
                    return completion(.success(true))
                } catch {
                    NSLog("Error - Error saving deadlines to core data. \(error)")
                    return completion(.failure(.coreDataFail))
                }
                
            } catch {
                NSLog("Error - Error decoding deadline representation. \(error) \(error.localizedDescription)")
                return completion(.failure(.noDecode))
            }
        }.resume()
    }
    
    func getNotifications(token: Token?, studentID: Int, deadlineID: Int, completion: @escaping CompletionHandler) {
        
        guard let tokenString = token?.token else {
            NSLog("Error - No Token.")
            return completion(.failure(.notLoggedIn))
        }
        
        var request = getRequest(for: makeNotificationURL(studentID: studentID, deadlineID: deadlineID))
        request.addValue(tokenString, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                NSLog("Error - Error fetching notifications: \(error) \(error.localizedDescription)")
                return completion(.failure(.otherError))
            }
            
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                    NSLog("Error - Bad Response fetching notifications: \(error) \(error?.localizedDescription)")
                    return completion(.failure(.badResponse))
            }
            
            guard let data = data else {
                NSLog("Error - No data returnedfrom notification fetch. \(error) \(error.localizedDescription)")
                return completion(.failure(.noData))
            }
            
            do {
                let notificationReps = try jsonDecoder.decode([NotificationRepresentation].self, from: data)
                for notification in notificationReps {
                    Notification(representation: notification)
                }
                
                do {
                    try CoreDataStack.shared.mainContext.save()
                    return completion(.success(true))
                } catch {
                    NSLog("Error - Error saving notifications to core data: \(error) \(error.localizedDescription)")
                }
                
            } catch {
                NSLog("Error - Error decoding notifications: \(error) \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func postStudent(token: Token?, representation: StudentRepresentation, completion: @escaping CompletionHandler) {
        guard let tokenString = token?.token else {
                   NSLog("Error - No token")
                   return completion(.failure(.notLoggedIn))
        }
        
        var request = postRequest(for: studentsURL)
        request.addValue(tokenString, forHTTPHeaderField: "Authorization")
        
        do {
            request.httpBody = try self.jsonEncoder.encode(representation)
        } catch {
            NSLog("Error - Error encoding student representation " + String(describing: error) + " " + String(describing: error?.localizedDescription))
            return completion (.failure(.noEncode))
        }
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                NSLog("Error - Error posting student: \(error) \(error.localizedDescription)")
                return (.failure(.otherError))
            }
            
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 201 else {
                    NSLog("Error - Bad response when posting student: " + String(describing: error) + " " + String(describing: error.localizedDescription))
                    return completion(.failure(.badResponse))
            }
            return completion(.success(true))
        }.resume()
    }
    
    func postDeadline(token: Token?, representation: DeadlineRepresentation, studentID: Int, completion: @escaping CompletionHandler) {
        guard let tokenString = token?.token else {
                   NSLog("Error - No token")
                   return completion(.failure(.notLoggedIn))
        }
        
        var request = postRequest(for: makeDeadlineURL(studentID: studentID))
        request.addValue(tokenString, forHTTPHeaderField: "Authorization")
        
        do {
            request.httpBody = try self.jsonEncoder.encode(representation)
        } catch {
            NSLog("Error - Error encoding deadline representation " + String(describing: error) + " " + String(describing: error.localizedDescription))
        }
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                NSLog("Error - Error posting deadline: " + String(describing: error) + " " + String(describing: error.localizedDescription))
                return completion(.failure(.otherError))
            }
            
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 201 else {
                    NSLog("Error - Bad response when posting deadline")
                    return completion(.failure(.badResponse))
            }
            return completion(.success(true))
        }.resume()
    }
    
    func postNotification(token: Token?, representation: NotificationRepresentation, studentID: Int, deadlineID: Int, completion: @escaping CompletionHandler) {
        
    }
    
    func deleteStudent() {
        
    }
    
    func deleteDeadline() {
        
    }
    
    func deleteNotification() {
        
    }
    
    
    
    //MARK: - Helper Methods -
    
    private func getRequest(for url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    private func postRequest(for url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    private func makeDeadlineURL(studentID: Int) -> URL {
        let studentsURL = self.studentsURL
        let stringID = String(describing: studentID)
        let deadlineURL = studentsURL.appendingPathComponent("/\(stringID)/deadlines")
        return deadlineURL
    }
    
    private func makeNotificationURL(studentID: Int, deadlineID: Int) -> URL {
        let deadlineURL = makeDeadlineURL(studentID: studentID)
        let stringDeadlineID = String(describing: deadlineID)
        let notificationURL = deadlineURL.appendingPathComponent("/\(deadlineID)/notifications")
        return notificationURL
    }
    
}
