//
//  ClubDetialTableViewController.swift
//  GoTeam
//
//  Created by Brett Ponder on 3/3/17.
//  Copyright © 2017 BuffTeks. All rights reserved.
//

import UIKit
import Parse

class ClubDetialTableViewController: UITableViewController {

    @IBOutlet weak var clubBackgroundImageView: UIImageView!
    @IBOutlet weak var clubLogoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var meetingTimeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var clubObject: PFObject!
    var clubBackgroundImage: UIImage!
    var clubLogoImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.clubLogoImageView.layer.borderWidth = 2.0
        self.clubLogoImageView.layer.borderColor = UIColor.white.cgColor
        
        self.nameLabel.text = "\(clubObject[ParseConstants.Club.ClubName] as! String)"
        self.meetingTimeLabel.text = "\(clubObject[ParseConstants.Club.MeetingTime] as! String)"
        self.descriptionLabel.text = "\(clubObject[ParseConstants.Club.Description] as! String)"
        
        self.clubBackgroundImageView.image = self.clubBackgroundImage
        self.clubLogoImageView.image = self.clubLogoImage
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    */

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
