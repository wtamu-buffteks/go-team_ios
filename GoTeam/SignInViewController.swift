//
//  SignInViewController.swift
//  GoTeam
//
//  Created by Brett Ponder on 2/17/17.
//  Copyright © 2017 BuffTeks. All rights reserved.
//

import UIKit
import Parse

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInButtonClicked(_ sender: Any) {
        if self.emailTextField.text! != "" || self.passwordTextField.text! != "" {
            PFUser.logInWithUsername(inBackground: self.emailTextField.text!, password: self.passwordTextField.text!) { (user: PFUser?, error: Error?) in
                if error == nil {
                    self.dismiss(animated: true, completion: {
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "signedIn"), object: nil)
                    })
                } else {
                    let alert = UIAlertController(title: "Error", message:"\((error?.localizedDescription)!)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
                    self.present(alert, animated: true){}
                }
            }
        } else {
            
        }
    }
    
    @IBAction func forgotPasswordButtonClicked(_ sender: Any) {
        
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        
    }

    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
