//
//  ProfileController.swift
//  FaniaChallenge
//
//  Created by BobbyPhtr on 22/04/19.
//  Copyright © 2019 BobbyPhtr. All rights reserved.
//

import UIKit
import Contacts

class ProfileController: UIViewController {

    @IBOutlet weak var swipeView: UIView!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var arrowView: UIImageView!
    
    @IBOutlet weak var getKnowMeView: UIView!
    @IBOutlet weak var pictureArrowView: UIView!
    
    @IBOutlet weak var waButton: UIButton!
    @IBOutlet weak var instaButton: UIButton!
    
    var store = CNContactStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
        
        getKnowMeView.transform = CGAffineTransform(translationX: 270, y: 0)
        
        waButton.layer.cornerRadius = 0.12 * waButton.bounds.size.width
        instaButton.layer.cornerRadius = 0.12 * instaButton.bounds.size.width
    }
    @IBAction func waClicked(_ sender: Any) {
        
        if CNContactStore.authorizationStatus(for: .contacts) == .notDetermined {
            store.requestAccess(for: .contacts, completionHandler: { (authorized: Bool, error: Error?) -> Void in
                if authorized {
                    self.createContact()
                }
                })
        } else if CNContactStore.authorizationStatus(for: .contacts) == .authorized {
            self.createContact()
        }
    }
    @IBAction func instaClicked(_ sender: Any) {
        if let url = URL(string: "https://instagram.com/faniaacecillia") {
            UIApplication.shared.open(url)
        }
    }
    
    func createContact() -> Void {
        let contact = CNMutableContact()
        contact.givenName = "Fania"
        contact.birthday = DateComponents(calendar: Calendar.current, year: 1998, month: 4, day: 7)
        contact.familyName = "Cecillia"
        
        if let img = UIImage(named: "line_65633763737704"),
            let data = img.pngData(){
            contact.imageData = data
        }
        
        let workPhone = CNLabeledValue(label: CNLabelWork,
                                       value: CNPhoneNumber(stringValue: " +6287854252250"))
        contact.phoneNumbers = [workPhone]
        
        let workEmail = CNLabeledValue(label: CNLabelWork, value: "faniacecillia0@gmail.com" as NSString)
        contact.emailAddresses = [workEmail]
        
        let request = CNSaveRequest()
        request.add(contact, toContainerWithIdentifier: nil)
        do{
            try store.execute(request)
            print("Successfully stored the contact")
            let alert = UIAlertController(title: "Add Successful", message: "My Contact is automatically added to your contacts! Call me :)", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        } catch let err{
            print("Failed to save the contact. \(err)")
        }
    }

}

extension ProfileController: swipeGestureDelegate {
    func didSwipe(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.pictureArrowView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.contentView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.arrowView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.arrowView.transform = CGAffineTransform(rotationAngle: 0)
                self.getKnowMeView.transform = CGAffineTransform(translationX: 270, y: 0)
            }) { (_) in
                //Completion code
            }
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.left {

            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.pictureArrowView.transform = CGAffineTransform(translationX: -240, y: 0)
                //                self.photoView.transform = CGAffineTransform(translationX: -270, y: 0)
                self.contentView.transform = CGAffineTransform(translationX: -270, y: 0)
                self.arrowView.transform = CGAffineTransform(rotationAngle: .pi)
                self.getKnowMeView.transform = CGAffineTransform(translationX: 0, y: 0)
                //                self.arrowView.transform = CGAffineTransform(translationX: -270, y: 0)
                
                
            }) { (_) in
                //Completion code
            }
        }
    }
}
