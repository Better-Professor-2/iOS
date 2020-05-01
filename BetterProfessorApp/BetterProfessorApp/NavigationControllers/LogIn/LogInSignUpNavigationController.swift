//
//  LogInSignUpNavigationController.swift
//  BetterProfessorApp
//
//  Created by Lambda_School_Loaner_268 on 4/29/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import UIKit

class LogInSignUpNavigationController: UINavigationController {
    
    public let netController = NetworkController()
    public let authControlller = AuthenticationController()
    
    public let profController = ProfessorController()
    public let deadlineController = DeadlineController()
    public let notificationController = NotificationController()
    public let studentController = StudentController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
