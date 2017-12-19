//
//  EducationViewController.swift
//  Resume Builder
//
//  Created by Shweta Shahane on 12/17/17.
//  Copyright © 2017 Rutvik Desai. All rights reserved.
//

import UIKit
import Firebase

class EducationViewController: UIViewController {

    @IBOutlet weak var univName: UITextField!
    @IBOutlet weak var gpa: UITextField!
    var ref:DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        // Do any additional setup after loading the view.
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
                    self.setText(value: userObject?["University Name"] as! String, sender: self.univName)
                    self.setText(value: userObject?["GPA"] as! String, sender: self.gpa)
                }
            }
        })
    }

    public func setText(value:String , sender : UITextField){
        sender.text = value
    }

}
