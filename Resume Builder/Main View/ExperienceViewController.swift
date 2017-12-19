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


    @IBOutlet weak var eeYear1: UIButton!
    @IBOutlet weak var esYear1: UIButton!
    @IBOutlet weak var eeYear2: UIButton!
    @IBOutlet weak var esYear2: UIButton!
    @IBOutlet weak var eeYear3: UIButton!
    @IBOutlet weak var esYear3: UIButton!
    @IBOutlet weak var editBtn: UIButton!
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
        designUI()
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
    
    func designUI() {
        companyName1.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        companyAddr1.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        companyPosition1.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        resp1.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        companyName2.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        companyAddr2.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        companyPosition2.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        resp2.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        companyName3.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        companyAddr3.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        companyPosition3.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        resp3.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        companyName1.layer.cornerRadius = 5.0
        companyName1.layer.masksToBounds = true
        companyName1.layer.borderWidth = 2.0
        companyAddr1.layer.cornerRadius = 5.0
        companyAddr1.layer.masksToBounds = true
        companyAddr1.layer.borderWidth = 2.0
        companyPosition1.layer.cornerRadius = 5.0
        companyPosition1.layer.masksToBounds = true
        companyPosition1.layer.borderWidth = 2.0
        resp1.layer.cornerRadius = 5.0
        resp1.layer.masksToBounds = true
        resp1.layer.borderWidth = 2.0
        companyName2.layer.cornerRadius = 5.0
        companyName2.layer.masksToBounds = true
        companyName2.layer.borderWidth = 2.0
        companyAddr2.layer.cornerRadius = 5.0
        companyAddr2.layer.masksToBounds = true
        companyAddr2.layer.borderWidth = 2.0
        companyPosition2.layer.cornerRadius = 5.0
        companyPosition2.layer.masksToBounds = true
        companyPosition2.layer.borderWidth = 2.0
        resp2.layer.cornerRadius = 5.0
        resp2.layer.masksToBounds = true
        resp2.layer.borderWidth = 2.0
        companyName3.layer.cornerRadius = 5.0
        companyName3.layer.masksToBounds = true
        companyName3.layer.borderWidth = 2.0
        companyAddr3.layer.cornerRadius = 5.0
        companyAddr3.layer.masksToBounds = true
        companyAddr3.layer.borderWidth = 2.0
        companyPosition3.layer.cornerRadius = 5.0
        companyPosition3.layer.masksToBounds = true
        companyPosition3.layer.borderWidth = 2.0
        resp3.layer.cornerRadius = 5.0
        resp3.layer.masksToBounds = true
        resp3.layer.borderWidth = 2.0
        editBtn.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        editBtn.layer.borderWidth = 2
        editBtn.layer.cornerRadius = 5.0
        editBtn.layer.masksToBounds = true
        esYear1.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        esYear1.layer.borderWidth = 2
        esYear1.layer.cornerRadius = 5.0
        esYear1.layer.masksToBounds = true
        eeYear1.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        eeYear1.layer.borderWidth = 2
        eeYear1.layer.cornerRadius = 5.0
        eeYear1.layer.masksToBounds = true
        esYear2.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        esYear2.layer.borderWidth = 2
        esYear2.layer.cornerRadius = 5.0
        esYear2.layer.masksToBounds = true
        eeYear2.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        eeYear2.layer.borderWidth = 2
        eeYear2.layer.cornerRadius = 5.0
        eeYear2.layer.masksToBounds = true
        esYear3.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        esYear3.layer.borderWidth = 2
        esYear3.layer.cornerRadius = 5.0
        esYear3.layer.masksToBounds = true
        eeYear3.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        eeYear3.layer.borderWidth = 2
        eeYear3.layer.cornerRadius = 5.0
        eeYear3.layer.masksToBounds = true
    }

    public func setText(value:String , sender : UITextField){
        sender.text = value
    }

    public func setTextView(value:String , sender : UITextView){
        sender.text = value
    }
}
