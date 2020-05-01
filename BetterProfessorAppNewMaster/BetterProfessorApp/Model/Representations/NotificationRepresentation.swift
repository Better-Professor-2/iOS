//
//  NotificationRepresentation.swift
//  BetterProfessorApp
//
//  Created by Cody Morley on 4/28/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation

struct NotificationRepresentation: Codable {
    //MARK: - Enums and Type Aliases -
    enum CodingKeys: String, CodingKey {
        case id, message, deadlineID
        case notifyTime = "notify_time"
    }
    
    //MARK: - Properties -
    var id: Int64
    var message: String
    var notifyTime: Date
    let deadlineID: Int64
}


