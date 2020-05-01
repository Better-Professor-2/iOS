//
//  LogInViewController.swift
//  BetterProfessorApp
//
//  Created by Lambda_School_Loaner_268 on 4/30/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    let authController = AuthenticationController()
    let netController = NetworkController()
    
    
    
    @IBOutlet weak var enterEmailTextField: UITextField!
    
    @IBOutlet weak var enterPasswordTextField: UITextField!
    @IBAction func loginButtonPressed(_ sender: Any) {
        guard enterEmailTextField.text != nil, enterEmailTextField.text != nil else {
            NSLog("Nil Authentication")
            let alert = UIAlertController(title: "Error!", message: "Enter your email and password!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
            
        }
        let email = enterPasswordTextField.text!
        let password = enterPasswordTextField.text!
        let login: Login = Login(email: email,
                                 password: password)
        authController.login(login: login) { ( _ ) in
        }
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 


}
