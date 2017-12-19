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

        // Do any additional setup after loading the view.
        fetchData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                }
            }
        })
    }

    public func setText(value:String , sender : UITextField){
        sender.text = value
    }

    public func setTextView(value:String , sender : UITextView){
        sender.text = value
    }

    

}
