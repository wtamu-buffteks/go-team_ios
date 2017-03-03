//
//  MemberTableViewController.swift
//  GoTeam
//
//  Created by Brett Ponder on 3/3/17.
//  Copyright © 2017 BuffTeks. All rights reserved.
//

import UIKit
import Parse

class MemberTableViewController: UITableViewController {
    
    var memberObjects: [PFObject]!

    override func viewDidLoad() {
        super.viewDidLoad()

        getMembers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getMembers() {
        let query = PFUser.query()
        query?.order(byDescending: ParseConstants.User.LastName)
        query?.findObjectsInBackground(block: { (objects: [PFObject]?, error: Error?) in
            if error == nil {
                if (objects?.count)! > 0 {
                    self.memberObjects = objects
                    self.tableView.reloadData()
                }
            }
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.memberObjects == nil {
            return 0
        } else {
            return self.memberObjects.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath) as! MemberTableViewCell

        let memberObject = memberObjects[indexPath.row]
        
        cell.nameLabel.text = "\(memberObject[ParseConstants.User.FirstName] as! String) \(memberObject[ParseConstants.User.LastName] as! String)"
        cell.setImage(object: memberObject)
        
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "memberDSegue" {
            let controller = segue.destination as! UserProfileViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let cell = tableView.cellForRow(at: indexPath) as! MemberTableViewCell
            let object = self.memberObjects[indexPath.row]
            controller.memberObject = object
            controller.profileImage = cell.profilePicImageView.image
            controller.isNotEditable = true
        }
    }

}
