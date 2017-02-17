//
//  SignUpViewController.swift
//  GoTeam
//
//  Created by Brett Ponder on 2/17/17.
//  Copyright © 2017 BuffTeks. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var cPasswordTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        if self.firstNameTextField.text! != "" && self.lastNameTextField.text! != "" && self.emailTextField.text! != "" && self.passwordTextField.text! != "" && self.cPasswordTextField.text! != "" && self.phoneNumberTextField.text! != "" {
            if self.passwordTextField.text! == self.cPasswordTextField.text! {
                let user = PFUser()
                user.username = self.emailTextField.text!
                user.email = self.emailTextField.text!
                user.password = self.passwordTextField.text!
                user[ParseConstants.User.FirstName] = self.firstNameTextField.text!
                user[ParseConstants.User.LastName] = self.lastNameTextField.text!
                user[ParseConstants.User.PhoneNumber] = self.phoneNumberTextField.text!
                user.signUpInBackground(block: { (success: Bool, error: Error?) in
                    if error == nil {
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        let alert = UIAlertController(title: "Error", message:"\((error?.localizedDescription)!)", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
                        self.present(alert, animated: true){}
                    }
                })
                //NotificationCenter.default.post(name: Notification.Name(rawValue: "moveEnd"), object: nil)
            } else {
                let alert = UIAlertController(title: "Error", message:"Your passwords do not make", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
                self.present(alert, animated: true){}
            }
        } else {
            let alert = UIAlertController(title: "Error", message:"Make sure that you fill out all of the fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
            self.present(alert, animated: true){}
        }
    }

    @IBAction func backButtonClicked(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "moveR"), object: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
