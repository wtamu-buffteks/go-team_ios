//
//  CalendarViewController.swift
//  GoTeam
//
//  Created by Brett Ponder on 12/2/16.
//  Copyright © 2016 BuffTeks. All rights reserved.
//

import UIKit
import Parse

class CalendarViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        for parent in self.navigationController!.navigationBar.subviews {
            for childView in parent.subviews {
                if(childView is UIImageView && childView.bounds.size.width == self.navigationController!.navigationBar.frame.size.width &&
                    childView.bounds.size.height < 2) {
                    let hairView: UIImageView = childView as! UIImageView
                    hairView.isHidden = true
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "userProfileSegue" {
            if PFUser.current() != nil {
                return true
            } else {
                let signInAction: UIAlertController = UIAlertController(title: "Hello", message: "You need to sign in or sign up first.", preferredStyle: .alert)
                let okButton: UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: { (alert: UIAlertAction!) -> Void in
                    
                })
                let signInButton: UIAlertAction = UIAlertAction(title: "Sign In", style: .default, handler: { (alert: UIAlertAction!) -> Void in
                    let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signNav") as! SignInUpNavViewController
                    self.present(controller, animated: true, completion: nil)
                })
                let signUpButton: UIAlertAction = UIAlertAction(title: "Sign Up", style: .default, handler: { (alert: UIAlertAction!) -> Void in
                    let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signNav") as! SignInUpNavViewController
                    self.present(controller, animated: true, completion: nil)
                })
                signInAction.addAction(okButton)
                signInAction.addAction(signInButton)
                signInAction.addAction(signUpButton)
                
                self.present(signInAction, animated: true, completion: nil)
                
                return false
            }
        } else {
            return true
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
