//
//  NotificationRepresentation.swift
//  BetterProfessorApp
//
//  Created by Cody Morley on 4/28/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation

class NotificationRepresentation: Codable {
    //MARK: - Enums and Type Aliases -
    enum CodingKeys: String, CodingKey {
        case id, message
        case notifyTime = "notify_time"
    }
    
    let id: Int64
    let message: String
    let notifyTime: Date
    let deadlineID: Int64
}


