//
//  CalendarViewController.swift
//  GoTeam
//
//  Created by Brett Ponder on 12/2/16.
//  Copyright © 2016 BuffTeks. All rights reserved.
//

import UIKit
import Parse

// MARK: - Extension for NSDate
extension Date {
    
    /// Gets the day of the week from a NSDate
    ///
    /// - returns: Int value between 1 -7
    func doyOfWeek() -> Int? {
        let comp = Calendar.current.component(.weekday, from: self)
        return comp
    }
    
    func hour() -> Int? {
        let comp = Calendar.current.component(.hour, from: self)
        return comp
    }
    
    func minute() -> Int? {
        let comp = Calendar.current.component(.minute, from: self)
        return comp
    }
    
    func day() -> Int? {
        let comp = Calendar.current.component(.day, from: self)
        return comp
    }
    
    func month() -> Int? {
        let comp = Calendar.current.component(.month, from: self)
        return comp
    }
    
    func year() -> Int? {
        let comp = Calendar.current.component(.year, from: self)
        return comp
    }
}

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    @IBOutlet weak var calendarView: FSCalendar!
    var eventClaendarObjects: [PFObject]!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.calendarView.delegate = self
        self.calendarView.dataSource = self
        
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
        
        getEvents()
        
    }
    
    func getEvents() {
        let query = PFQuery(className:ParseConstants.Calendar.ClassName)
        query.limit = 1000
        query.order(byDescending: ParseConstants.Calendar.Date)
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if objects!.count == 0 {
                    self.eventClaendarObjects = nil
                } else {
                    self.eventClaendarObjects = objects
                }
                self.calendarView.reloadData()
            } else {
                
            }
        }
    }
    
    func calendar(_ calendar: FSCalendar!, hasEventFor date: Date!) -> Bool {
        
        var thereIsSomething = false
        if self.eventClaendarObjects != nil {
            for object: PFObject in self.eventClaendarObjects {
                let eventdate: Date = object[ParseConstants.Calendar.Date] as! Date
                if date.year() == eventdate.year() && date.month() == eventdate.month() && date.day() == eventdate.day(){
                    thereIsSomething = true
                    break
                } else {
                    thereIsSomething = false
                }
            }
            return thereIsSomething
        } else {
            return thereIsSomething
        }
        
    }
    
    func calendar(_ calendar: FSCalendar!, didSelect date: Date!) {
        let startDate = self.getStartDate(date)
        let endDate = self.getEndDate(date)
        var theEventDateObjects = [PFObject]()
        if self.eventClaendarObjects != nil {
            for object: PFObject in self.eventClaendarObjects {
                let eventdate: Date = object[ParseConstants.Calendar.Date] as! Date
                if eventdate.timeIntervalSinceReferenceDate > startDate.timeIntervalSinceReferenceDate && eventdate.timeIntervalSinceReferenceDate < endDate.timeIntervalSinceReferenceDate {
                    theEventDateObjects.insert(object, at: 0)
                }else {
                    
                }
            }
            NotificationCenter.default.post(name: Notification.Name(rawValue: "updateDateTable"), object: nil, userInfo: ["events":theEventDateObjects])
        } else {
        }
    }
    
    // MARK: - Formate Date to Start and End of Day
    
    func getStartDate(_ theDate: Date) -> Date {
        print("date:  \(theDate)")
        let gregorianCalendar = Calendar(identifier: Calendar.Identifier.gregorian)
        var dateComonetnts = (gregorianCalendar as NSCalendar?)?.components([.day, .month, .year], from: theDate)
        dateComonetnts?.hour = 0
        dateComonetnts?.minute = 0
        dateComonetnts?.second = 0
        return (gregorianCalendar.date(from: dateComonetnts!))!
    }
    
    func getEndDate(_ theDate: Date) -> Date {
        print("date:  \(theDate)")
        let gregorianCalendar = Calendar(identifier: Calendar.Identifier.gregorian)
        var dateComonetnts = (gregorianCalendar as NSCalendar?)?.components([.day, .month, .year], from: theDate)
        dateComonetnts?.hour = 23
        dateComonetnts?.minute = 59
        dateComonetnts?.second = 59
        return (gregorianCalendar.date(from: dateComonetnts!))!
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
