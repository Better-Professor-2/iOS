//
//  UserCredentials.swift
//  BetterProfessorApp
//
//  Created by Cody Morley on 4/29/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation

struct UserCredentials: Codable {
    //// This helper object will create a codable data format for use on registration
    //MARK: Enums
    enum CodingKeys: String, CodingKey {
        case email, password
        case firstName = "first_name"
        case lastName = "last_name"
        
    }
    
    //MARK: - Properties -
    let firstName: String
    let lastName: String
    let email: String
    let password: String
}
