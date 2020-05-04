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
        XCTAssertNotNil(prof.students)
}
    func testAccessProfStudents() {
        let prof = Professor(id: 99,
                             email: "bigEmail@gmail.com",
                             password: "aA12345!",
                             firstName: "Big",
                             lastName: "Email",
                             students: [])
        let student = Student(id: 80,
                              firstName: "Dan",
                              lastName: "Harmon", email: "RickAndMorty@gmail.com",
                              phoneNumber: "8009990000",
                              professor: prof, deadlines: [],
                              context: CoreDataStack.shared.mainContext)
        prof.addToStudents(student)
        XCTAssertNotNil(prof.students)
    }
    func testMakeDeadline() {
        let prof = Professor(id: 1111,
                             email: "hello@gmail.com",
                             password: "aA12345!",
                             firstName: "Hector",
                             lastName: "Salamanca",
                             students: [], context: CoreDataStack.shared.mainContext)
        let student = Student(id: 111,
                                     firstName: "Henry",
                                     lastName: "Cavill",
                                     email: "thewitcher@gmail.com",
                                     phoneNumber: "9008880000",
                                     professor: prof, deadlines: [],
                                     context: CoreDataStack.shared.mainContext)
        let deadline: () = deadCon.createDeadline(for: student,
                                                  name: "I hate deadlines!",
                                                   dueDate: Date(),
                                                   notes: "Notes!",
                                                   context: CoreDataStack.shared.mainContext)
    }
    func testDelProf() {
        let prof = Professor(id: 99,
                             email: "bigdaddy@gmail.com",
                             password: "aA12345!",
                             firstName: "Big",
                             lastName: "Daddy",
                             students: [],
                             context: CoreDataStack.shared.mainContext)
        XCTAssertNotNil(profController.fetchProfessor(context: CoreDataStack.shared.mainContext, id: 99))
        profController.deleteProfessor(professor: prof)
        XCTAssertNil(profController.fetchProfessor(context: CoreDataStack.shared.mainContext, id: 99))
    }
    func testFetchprod() {
        let prof = Professor(id: 100,
                             email: "lalilulelo",
                             password: "aA12345!",
                             firstName: "Richard",
                             lastName: "Ames",
                             students: [],
                             context: CoreDataStack.shared.mainContext)
        XCTAssertNotNil(profController.fetchProfessor(context: CoreDataStack.shared.mainContext, id: 100))
    }
    func testUpdateProf() {
        let prof = Professor(id: 100,
                             email: "lalilulelo",
                             password: "aA12345!",
                             firstName: "Richard",
                             lastName: "Ames",
                             students: [],
                             context: CoreDataStack.shared.mainContext)
        let profID = prof.id
        var profRep = prof.professorRepresentation
        profRep?.id = 44
        profController.updateProfessor(professor: prof, representation: profRep!)
        XCTAssert(prof.id == 44)
    }

    func testUpdateDeadline() {
        let prof = Professor(id: 1111,
                             email: "hello@gmail.com",
                             password: "aA12345!",
                             firstName: "Hector",
                             lastName: "Salamanca",
                             students: [],
                             context: CoreDataStack.shared.mainContext)
        let student = Student(id: 111,
                              firstName: "Henry",
                              lastName: "Cavill",
                              email: "thewitcher@gmail.com",
                              phoneNumber: "9008880000",
                              professor: prof,
                              deadlines: [],
                              context: CoreDataStack.shared.mainContext)
            deadCon.createDeadline(for: student,
                                              name: "I hate deadlines!",
                                              dueDate: Date(),
                                              notes: "Notes!")
        XCTAssertNotNil(student.deadlines)
        _ = student.deadlines
        let deadline: Deadline = Deadline(id: 44,
                                          name: "I hate deadlines",
                                          dueDate: Date(),
                                          notes: "Hellloooo!",
                                          studentID: 111,
                                          student: student)
        let deadlineRep: DeadlineRepresentation = DeadlineRepresentation(id: 44,
                                                                         name: "redo",
                                                                         dueDate: Date(),
                                                                         notes: "Now I have more notes",
                                                                         studentID: 55,
                                                                         notifications: [])
        deadCon.updateDeadline(deadline: deadline,
                               representation: deadlineRep)
        let newDeadLine = deadCon.fetchDeadline(context: CoreDataStack.shared.mainContext, id: 44)
        XCTAssertNotNil(newDeadLine)
    }
    func testDelete() {
        let context = CoreDataStack.shared.mainContext
        let deadCon = DeadlineController()
        let prof = Professor(id: 1111,
                             email: "hello@gmail.com",
                             password: "aA12345!",
                             firstName: "Hector",
                             lastName: "Salamanca",
                             students: [], context: CoreDataStack.shared.mainContext)
        let student = Student(id: 111,
                              firstName: "Henry",
                              lastName: "Cavill",
                              email: "thewitcher@gmail.com",
                              phoneNumber: "9008880000",
                              professor: prof,
                              deadlines: [],
                              context: CoreDataStack.shared.mainContext)
        let deadToDelete = Deadline(id: 44,
                                    name: "I hate deadlines!",
                                    dueDate: Date(),
                                    notes: "NOOOOOOOOTes",
                                    studentID: 111, student: student,
                                    notifications: [],
                                    context: context)
        deadCon.deleteDeadline(deadline: deadToDelete)
        XCTAssertNil(deadCon.fetchDeadline(context: context, id: 44))
    }
}
