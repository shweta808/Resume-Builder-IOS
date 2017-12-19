//
//  ExperienceViewController.swift
//  Resume Builder
//
//  Created by Shweta Shahane on 12/17/17.
//  Copyright © 2017 Rutvik Desai. All rights reserved.
//

import UIKit
import Firebase

class ExperienceViewController: UIViewController {


    @IBOutlet weak var companyName1: UITextField!
    @IBOutlet weak var companyAddr1: UITextField!
    @IBOutlet weak var companyPosition1: UITextField!
    @IBOutlet weak var resp1: UITextView!
    @IBOutlet weak var resp2: UITextView!
    @IBOutlet weak var companyPosition2: UITextField!
    @IBOutlet weak var companyAddr2: UITextField!
    @IBOutlet weak var companyName2: UITextField!
    @IBOutlet weak var companyName3: UITextField!
    @IBOutlet weak var companyAddr3: UITextField!
    @IBOutlet weak var companyPosition3: UITextField!
    @IBOutlet weak var resp3: UITextView!

    var ref: DatabaseReference!

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
                    self.setText(value: userObject?["Experience 1 Company Name"] as! String, sender: self.companyName1)
                    self.setText(value: userObject?["Experience 1 Company Address"] as! String, sender: self.companyAddr1)
                    self.setText(value: userObject?["Experience 1 Position"] as! String, sender: self.companyPosition1)
                    self.setTextView(value: userObject?["Experience 1 Responsibilities"] as! String, sender: self.resp1)

                    self.setText(value: userObject?["Experience 2 Company Name"] as! String, sender: self.companyName2)
                    //self.setText(value: userObject?["Experience 2 Company Address"] as! String, sender: self.companyAddr2)
                    self.setText(value: userObject?["Experience 2 Position"] as! String, sender: self.companyPosition2)
                    self.setTextView(value: userObject?["Experience 2 Responsibilities"] as! String, sender: self.resp2)

                    self.setText(value: userObject?["Experience 3 Company Name"] as! String, sender: self.companyName3)
                    self.setText(value: userObject?["Experience 3 Company Address"] as! String, sender: self.companyAddr3)
                    self.setText(value: userObject?["Experience 3 Position"] as! String, sender: self.companyPosition3)
                    self.setTextView(value: userObject?["Experience 3 Responsibilities"] as! String, sender: self.resp3)
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
