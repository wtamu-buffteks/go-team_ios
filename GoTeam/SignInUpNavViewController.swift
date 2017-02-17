//
//  SignInUpNavViewController.swift
//  GoTeam
//
//  Created by Brett Ponder on 2/17/17.
//  Copyright © 2017 BuffTeks. All rights reserved.
//

import UIKit

class SignInUpNavViewController: UIViewController {
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottumConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        widthConstraint.constant = self.view.frame.size.width
        
        NotificationCenter.default.addObserver(self, selector:#selector(SignInUpNavViewController.moveViewToTheRight), name: NSNotification.Name(rawValue: "moveR"), object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(SignInUpNavViewController.moveViewToTheLeft), name: NSNotification.Name(rawValue: "moveL"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)

        // Do any additional setup after loading the view.
    }
    
    func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration: TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve: UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.bottumConstraint.constant = 0.0
                UIView.animate(withDuration: duration,
                               delay: TimeInterval(0),
                               options: animationCurve,
                               animations: { self.view.layoutIfNeeded() })
                { (success: Bool) in }
            } else {
                self.bottumConstraint.constant = (endFrame?.size.height)!
                UIView.animate(withDuration: duration,
                               delay: TimeInterval(0),
                               options: animationCurve,
                               animations: { self.view.layoutIfNeeded() })
                { (success: Bool) in }
            }
        }
    }
    
    func moveViewToTheRight() {
        
        self.leadConstraint.constant = 0
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    func moveViewToTheLeft() {
        
        self.leadConstraint.constant = self.view.frame.width * -1
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
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
