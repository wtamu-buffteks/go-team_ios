//
//  EventTableViewController.swift
//  GoTeam
//
//  Created by Brett Ponder on 12/2/16.
//  Copyright © 2016 BuffTeks. All rights reserved.
//

import UIKit
import Parse

class EventTableViewController: UITableViewController {
    
    var eventObjects: [PFObject]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.getEvents()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getEvents() {
        let query = PFQuery(className:ParseConstants.Event.ClassName)
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if error == nil {
                self.eventObjects = objects
                print(self.eventObjects.count)
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.eventObjects == nil {
            return 0
        } else {
            return eventObjects.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EventTableViewCell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventTableViewCell

        // Configure the cell...
        
        let eventObject = eventObjects[indexPath.row]
        cell.eventTitleLabel.text = "\(eventObject[ParseConstants.Event.EventName] as! String)"
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy h:mm a"
        cell.dateLabel.text = formatter.string(from: eventObject[ParseConstants.Event.Date] as! Date)
        let eventImageFile = eventObject[ParseConstants.Event.Picture] as! PFFile
        eventImageFile.getDataInBackground { (imageData: Data?, error: Error?) in
            if error == nil {
                cell.eventImageView.image = UIImage(data: imageData!)
            }
        }
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
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
        if segue.identifier == "eventDSegue" {
            let controller = segue.destination as! EventDetailTableViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let cell = tableView.cellForRow(at: indexPath) as! EventTableViewCell
            let object = self.eventObjects[indexPath.row]
            controller.eventObject = object
            controller.eventImage = cell.eventImageView.image
        }
    }

}
