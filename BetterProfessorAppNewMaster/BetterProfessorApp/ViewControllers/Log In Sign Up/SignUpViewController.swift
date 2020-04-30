//
//  SignUpViewController.swift
//  BetterProfessorApp
//
//  Created by Lambda_School_Loaner_268 on 4/30/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    // MARK: - Professor Controller
    let professorController = ProfessorController()
    // MARK: - IBOutlets
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    // MARK: - IBActions
    @IBAction func createProfessorAccountButtonPressed(_ sender: Any) {
        let firstName: String
        let lastName: String
        let professor: Professor
        guard (fullNameTextField.text != nil),
            (passwordTextField.text != nil),
            (emailTextField.text != nil),
            confirmPasswordTextField.text != nil else {
                let alert = UIAlertController(title: "Submission Error!", message: "You left something blank", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true)
                NSLog("Field left blank")
                return
        }
        guard passwordTextField.text == confirmPasswordTextField.text else {
            let alert = UIAlertController(title: "Password Error!",
                                          message: "Your passwords didn't match and/or fit the criteria",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay",
                                          style: .default,
                                          handler: nil))
            self.present(alert, animated: true)
            NSLog("Field left blank")
            return
        }
        let names: [String]! = fullNameTextField.text?.components(separatedBy: " ")
        if names.count == 1 {
            firstName = names.first!
            lastName = ""
            professor = Professor(id: Int64(),
                                  email: emailTextField.text!,
                                  password: passwordTextField.text!,
                                  firstName: firstName,
                                  lastName: lastName,
                                  students: [])
        } else if names.count >= 2 {
            firstName = names.first!
            lastName = names.last!
            professor = Professor(id: Int64(),
                                  email: emailTextField.text!,
                                  password: passwordTextField.text!,
                                  firstName: firstName,
                                  lastName: lastName,
                                  students: [])
        } else {
            let alert = UIAlertController(title: "Name Error!",
                                          message: "Please enter your first and last name.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay",
                                          style: .default,
                                          handler: nil))
            self.present(alert, animated: true)
            NSLog("Invalid name entered.")
            self.dismiss(animated: true, completion: nil)
            return
        }
        self.professorController.updateProfessor(professor: professor,
                                                 representation: professor.professorRepresentation!)
        self.dismiss(animated: true,
                     completion: nil)
    }
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
