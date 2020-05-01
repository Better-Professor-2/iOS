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
    func testAuthRegister() {
        let credentials = UserCredentials(firstName: "Dick",
                                          lastName: "Head",
                                          email: "asshole@wildblue.net",
                                          password: "aAB134&353afneeg359&5f5")
        
        XCTAssertTrue(credentials.firstName == "Dick")
        
        authContoller.register(with: credentials) { (_) in
        }
        
    }
}
