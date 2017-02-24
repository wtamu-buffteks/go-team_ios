//
//  UserProfileViewController.swift
//  GoTeam
//
//  Created by Brett Ponder on 2/24/17.
//  Copyright © 2017 BuffTeks. All rights reserved.
//

import UIKit
import MobileCoreServices
import Parse

class UserProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var profilePicView: UIView!
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var editPhotoButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        for parent in self.navigationController!.navigationBar.subviews {
            for childView in parent.subviews {
                if(childView is UIImageView && childView.bounds.size.width == self.navigationController!.navigationBar.frame.size.width &&
                    childView.bounds.size.height < 2) {
                    let hairView: UIImageView = childView as! UIImageView
                    hairView.isHidden = true
                }
            }
        }
        
        if let imageFile = PFUser.current()?[ParseConstants.User.Picture] as? PFFile {
            imageFile.getDataInBackground(block: { (data: Data?, error: Error?) in
                self.profilePicImageView.image = UIImage(data: data!)
            })
        }
        
        self.profilePicView.layer.cornerRadius = 40.0
        self.nameLabel.text = "\(PFUser.current()?[ParseConstants.User.FirstName] as! String) \(PFUser.current()?[ParseConstants.User.LastName] as! String)"
        self.emailLabel.text = (PFUser.current()?.email)!
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutButtonClicked(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func editButtonClicked(_ sender: Any) {
        let profilePicAvtion: UIAlertController = UIAlertController(title: "Upload Profile Picture", message: nil, preferredStyle: .actionSheet)
        let photoLibraryAction: UIAlertAction = UIAlertAction(title: "Photo Library", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
                print("Button capture")
                
                let imag = UIImagePickerController()
                imag.delegate = self
                imag.sourceType = UIImagePickerControllerSourceType.photoLibrary;
                imag.mediaTypes = [kUTTypeImage as String]
                imag.allowsEditing = false
                
                self.present(imag, animated: true, completion: nil)
            }
        })
        let takePhotoAction: UIAlertAction = UIAlertAction(title: "Take Photo", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
                print("Button capture")
                
                let imag = UIImagePickerController()
                imag.delegate = self
                imag.sourceType = UIImagePickerControllerSourceType.camera;
                imag.mediaTypes = [kUTTypeImage as String]
                imag.allowsEditing = false
                
                self.present(imag, animated: true, completion: nil)
            }
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (alert: UIAlertAction!) -> Void in
            
        })
        profilePicAvtion.addAction(photoLibraryAction)
        profilePicAvtion.addAction(takePhotoAction)
        profilePicAvtion.addAction(cancelAction)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            profilePicAvtion.modalPresentationStyle = .popover
//            let popOver = profilePicAvtion.popoverPresentationController
            self.present(profilePicAvtion, animated: true, completion: nil)
        } else {
            self.present(profilePicAvtion, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.profilePicImageView.image = image
        self.uploadImage(image: image)
        dismiss(animated: true, completion: nil)
    }
    
    func uploadImage(image: UIImage) {
        let imageData = UIImageJPEGRepresentation(image, 0.7)
        let imageFile = PFFile(name: "\(randomStringWithLength(15)).jpg", data: imageData!)
        PFUser.current()?[ParseConstants.User.Picture] = imageFile
        PFUser.current()?.saveInBackground()
    }
    
    func randomStringWithLength (_ len : Int) -> NSString {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for _: Int in 0 ..< len {
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
        }
        
        return randomString
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
