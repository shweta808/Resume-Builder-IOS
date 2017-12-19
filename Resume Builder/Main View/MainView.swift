//
//  MainView.swift
//  Resume Builder
//
//  Created by MyBook on 12/15/17.
//  Copyright © 2017 Rutvik Desai. All rights reserved.
//

import UIKit
import Firebase

class MainView: UIViewController {


    @IBOutlet weak var superView: UIView!
    var subViews:[UIView]!

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var contactText: UITextField!

    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        nameText.isUserInteractionEnabled = false
        emailText.isUserInteractionEnabled = false
        contactText.isUserInteractionEnabled = false
        
        subViews = [UIView]()
        subViews.append(ProfileViewController().view)
        subViews.append(ExperienceViewController().view)
        subViews.append(ProjectsViewController().view)
        subViews.append(EducationViewController().view)

        for v in subViews {
           superView.addSubview(v)
        }
        superView.bringSubview(toFront: subViews[0])

        //Fetch name, email-id and position from database
        fetchData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func logoutPressed(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "signoutSegue", sender: nil)
        }
        catch{
            print("Error")
        }
    }

    @IBAction func switchViews(_ sender: UISegmentedControl) {
        self.superView.bringSubview(toFront: subViews[sender.selectedSegmentIndex])
    }

    public func fetchData() {
        ref = Database.database().reference().child("Resume Data")
        //observing the data changes
        ref.observe(DataEventType.value, with: { (snapshot) in
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                //iterating through all the values
                for user in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let userObject = user.value as? [String: AnyObject]
                    let Name  = userObject?["Name"]
                    let Email = userObject?["Email"]
                    let Contact = userObject?["Contact"]
                    self.setProfile(Name:Name as! String ,Email:Email as! String,Contact:Contact as! String)
                    //creating artist object with model and fetched values
                    //appending it to list
                }
            }
        })
    }

    public func setProfile(Name:String , Email:String ,Contact:String){
        self.nameText.text = Name
        self.emailText.text = Email
        self.contactText.text = Contact
    }

}
