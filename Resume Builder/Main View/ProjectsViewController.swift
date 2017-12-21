//
//  ProjectsViewController.swift
//  Resume Builder
//
//  Created by Shweta Shahane on 12/17/17.
//  Copyright © 2017 Rutvik Desai. All rights reserved.
//

import UIKit
import Firebase

class ProjectsViewController: UIViewController {

    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var psYear1: UIButton!
    @IBOutlet weak var peYear1: UIButton!
    @IBOutlet weak var psYear2: UIButton!
    @IBOutlet weak var peYear2: UIButton!
    @IBOutlet weak var psYear3: UIButton!
    @IBOutlet weak var peYear3: UIButton!
    var ref:DatabaseReference!
    @IBOutlet weak var org1: UITextField!
    @IBOutlet weak var projectDesc2: UITextView!
    @IBOutlet weak var tech2: UITextField!
    @IBOutlet weak var org2: UITextField!

    @IBOutlet weak var projName2: UITextField!
    @IBOutlet weak var tech1: UITextField!
    @IBOutlet weak var projectDesc1: UITextView!
    @IBOutlet weak var projectName1: UITextField!

    @IBOutlet weak var projectDesc3: UITextView!
    @IBOutlet weak var projectName3: UITextField!
    @IBOutlet weak var tech3: UITextField!
    @IBOutlet weak var org3: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        designUI()
        // Do any additional setup after loading the view.
        fetchData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func fetchData() {
        let user = Auth.auth().currentUser
        let current_user = user?.email
        ref = Database.database().reference().child("Resume Data")
        //observing the data changes
        ref.observe(DataEventType.value, with: { (snapshot) in
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                //iterating through all the values
                for user in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let userObject = user.value as? [String: AnyObject]
                    if userObject?["Email"] as? String == current_user {
                    self.setText(value: userObject?["Project 1 Name"] as! String, sender: self.projectName1)
                    self.setTextView(value: userObject?["Project 1 Description"] as! String, sender: self.projectDesc1)
                    self.setText(value: userObject?["Project 1 Organization"] as! String, sender: self.org1)
                    self.setText(value: userObject?["Project 1 Technologies"] as! String, sender: self.tech1)
                    self.setText(value: userObject?["Project 2 Name"] as! String, sender: self.projName2)
                    self.setTextView(value: userObject?["Project 2 Description"] as! String, sender: self.projectDesc2)
                    self.setText(value: userObject?["Project 2 Organization"] as! String, sender: self.org2)
                    self.setText(value: userObject?["Project 2 Technologies"] as! String, sender: self.tech2)
                    self.setText(value: userObject?["Project 3 Name"] as! String, sender: self.projectName3)
                    self.setTextView(value: userObject?["Project 3 Description"] as! String, sender: self.projectDesc3)
                    self.setText(value: userObject?["Project 3 Organization"] as! String, sender: self.org3)
                    self.setText(value: userObject?["Project 3 Technologies"] as! String, sender: self.tech3)
                    }}
            }
        })
    }
    
    func designUI() {
        projectName1.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        projectDesc1.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        org1.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        tech1.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        projName2.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        projectDesc2.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        org2.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        tech2.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        projectName3.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        projectDesc3.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        org3.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        tech3.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        projectName1.layer.cornerRadius = 5.0
        projectName1.layer.masksToBounds = true
        projectName1.layer.borderWidth = 2.0
        projectDesc1.layer.cornerRadius = 5.0
        projectDesc1.layer.masksToBounds = true
        projectDesc1.layer.borderWidth = 2.0
        org1.layer.cornerRadius = 5.0
        org1.layer.masksToBounds = true
        org1.layer.borderWidth = 2.0
        tech1.layer.cornerRadius = 5.0
        tech1.layer.masksToBounds = true
        tech1.layer.borderWidth = 2.0
        projName2.layer.cornerRadius = 5.0
        projName2.layer.masksToBounds = true
        projName2.layer.borderWidth = 2.0
        projectDesc2.layer.cornerRadius = 5.0
        projectDesc2.layer.masksToBounds = true
        projectDesc2.layer.borderWidth = 2.0
        org2.layer.cornerRadius = 5.0
        org2.layer.masksToBounds = true
        org2.layer.borderWidth = 2.0
        tech2.layer.cornerRadius = 5.0
        tech2.layer.masksToBounds = true
        tech2.layer.borderWidth = 2.0
        projectDesc3.layer.cornerRadius = 5.0
        projectDesc3.layer.masksToBounds = true
        projectDesc3.layer.borderWidth = 2.0
        projectName3.layer.cornerRadius = 5.0
        projectName3.layer.masksToBounds = true
        projectName3.layer.borderWidth = 2.0
        org3.layer.cornerRadius = 5.0
        org3.layer.masksToBounds = true
        org3.layer.borderWidth = 2.0
        tech3.layer.cornerRadius = 5.0
        tech3.layer.masksToBounds = true
        tech3.layer.borderWidth = 2.0
        editBtn.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        editBtn.layer.borderWidth = 2
        editBtn.layer.cornerRadius = 5.0
        editBtn.layer.masksToBounds = true
        psYear1.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        psYear1.layer.borderWidth = 2
        psYear1.layer.cornerRadius = 5.0
        psYear1.layer.masksToBounds = true
        peYear1.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        peYear1.layer.borderWidth = 2
        peYear1.layer.cornerRadius = 5.0
        peYear1.layer.masksToBounds = true
        psYear2.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        psYear2.layer.borderWidth = 2
        psYear2.layer.cornerRadius = 5.0
        psYear2.layer.masksToBounds = true
        peYear2.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        peYear2.layer.borderWidth = 2
        peYear2.layer.cornerRadius = 5.0
        peYear2.layer.masksToBounds = true
        psYear3.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        psYear3.layer.borderWidth = 2
        psYear3.layer.cornerRadius = 5.0
        psYear3.layer.masksToBounds = true
        peYear3.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        peYear3.layer.borderWidth = 2
        peYear3.layer.cornerRadius = 5.0
        peYear3.layer.masksToBounds = true
    }

    public func setText(value:String , sender : UITextField){
        sender.text = value
    }

    public func setTextView(value:String , sender : UITextView){
        sender.text = value
    }

    

}
