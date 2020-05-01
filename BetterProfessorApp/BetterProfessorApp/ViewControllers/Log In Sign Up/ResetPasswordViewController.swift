//
//  ResetPasswordViewController.swift
//  BetterProfessorApp
//
//  Created by Lambda_School_Loaner_268 on 4/30/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import UIKit
import MessageUI

// MARK: - Public NFMailComposeResult Enum
public enum NFMailComposeResult: Int {
    case cancelled = 0
    case saved = 1
    case sent = 2
    case failed = 3
}

class ResetPasswordViewController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // MARK: - Outlets And IBActions
    @IBOutlet weak var passwordResetEmail: UITextField!
    @IBAction func submitEmailPressed(_ sender: Any) {
        if passwordResetEmail.text != nil {
            sendEmail(passwordResetEmail.text!)
            self.dismiss(animated: true, completion: nil)
        } else {
            showEmailNilAlert()
        }
    }
    @IBOutlet weak var resetPasswordSubmitButton: UIButton!
    // MARK: - Alert Method
    func showEmailNilAlert() {
        let alert = UIAlertController(title: "No Email!.",
                                      message: "Please enter an email address.",
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Okay",
                                      style: .default,
                                      handler: nil))

        self.present(alert, animated: true)
    }
    // MARK: - MessageUI Method
    func sendEmail(_ email: String) {
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setToRecipients([email])
        mail.setMessageBody("<p>Here is a hypothetical email " +
            "that would allow you to reset your Better Professor password.</p>",
                            isHTML: true)
        if MFMailComposeViewController.canSendMail() {
                present(mail, animated: true)
        } else {
            let emailFailureAlert = UIAlertController(title: "Error!",
                                                      message: "Your email couldn't be sent.",
                                                      preferredStyle: .alert)
            emailFailureAlert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            mail.present(emailFailureAlert, animated: true)
            mailComposeController(mail, didFinishWith: .failed, error: nil)
            NSLog("Error sending email")
        }
        let emailSentAlert = UIAlertController(title: "Email sent", message: nil, preferredStyle: .alert)
        emailSentAlert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        mail.present(emailSentAlert, animated: true)
        mailComposeController(mail, didFinishWith: .sent, error: nil)
    }
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult,
                               error: Error?) {
        controller.dismiss(animated: true)
    }
}
