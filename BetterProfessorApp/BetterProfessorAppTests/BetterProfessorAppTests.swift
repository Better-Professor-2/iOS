//
//  BetterProfessorAppTests.swift
//  BetterProfessorAppTests
//
//  Created by Lambda_School_Loaner_268 on 4/27/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import XCTest
@testable import BetterProfessorApp

class BetterProfessorAppTests: XCTestCase {
    let authContoller = BetterProfessorApp.AuthenticationController()
    let netcontroller = BetterProfessorApp.NetworkController()
    let profController = BetterProfessorApp.ProfessorController()
    let studentCon = BetterProfessorApp.StudentController()
    let notCont = BetterProfessorApp.NotificationController()
    let deadCon = BetterProfessorApp.DeadlineController()
    func testLogOn() {
        var token = authContoller.authToken
        XCTAssertNil(token)
        
    }
}
