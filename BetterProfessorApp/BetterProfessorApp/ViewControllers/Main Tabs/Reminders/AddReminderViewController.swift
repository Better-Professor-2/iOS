//
//  AddReminderViewController.swift
//  BetterProfessorApp
//
//  Created by Lambda_School_Loaner_268 on 4/29/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import UIKit

class AddReminderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var studentNameTextFeield: UITextField!
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var reminderTimeTF: UITextField!
    
    @IBOutlet weak var reminderMessageTextView: UITextView!
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        let studentName = studentNameTextFeield.text
       
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
