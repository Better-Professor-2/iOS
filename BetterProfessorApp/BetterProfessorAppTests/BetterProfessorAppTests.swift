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
    
    let netcontroller = BetterProfessorApp.NetworkController()
    let profController = BetterProfessorApp.ProfessorController()
    let studentCon = BetterProfessorApp.StudentController()
    let notCont = BetterProfessorApp.NotificationController()
    let deadCon = BetterProfessorApp.DeadlineController()
    
    // Test Log On
    func testLogOn() {
        let authContoller = BetterProfessorApp.AuthenticationController()
       
        var token: Token?
        let login = Login(email: "jonbash@gmail.com", password: "aA12345!")
        XCTAssertTrue(login.email == "jonbash@gmail.com")
        authContoller.login(login: login) { (_) in
        }
    }
    
    /// Feed new Creds to  run test.
    func testSignUp() {
        let creds = UserCredentials(firstName: "Randy",
                                    lastName: "Savage",
                                    email: "machaMan@gmail.com",
                                    password: "aA12345!")
        let authController = AuthenticationController()
        authController.register(with: creds) { (_) in
        }
        let log = Login(email: "Randy", password: "Savage")
        authController.login(login: log) { (_) in
        }
        XCTAssertNil(authController.auth)
    }
    func testCreateStudent() {
        let prof = Professor(id: 44,
                             email: "emailgmail@gmail.com", password: "aA12345!",
                             firstName: "John",
                             lastName: "Rambo",
                             students: [])
        XCTAssertNotNil(prof)
        studentCon.createStudent(for: prof,
                                 firstName: "Silly",
                                 lastName: "String",
                                 email: "silliestString@gmail.com",
                                 phoneNumber: "7409926748")
        let student = studentCon.fetchStudent(id: 44)
        XCTAssertNotNil(student)
        
        
}
}
