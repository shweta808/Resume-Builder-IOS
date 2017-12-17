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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        fetchData()
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
                    let company1 = user.value as? [String: AnyObject]
                    if !(company1?.isEmpty)!{
//                        self.setText(value: String(describing: company1), sender: self.companyName1)
                    }
                }
            }
        })
    }

    public func setText(value:String , sender : UITextView){
        sender.text = value
    }
}
