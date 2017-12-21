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

    @IBOutlet weak var edueYear: UIButton!
    @IBOutlet weak var edusYear: UIButton!
    @IBOutlet weak var departmentBtn: UIButton!
    @IBOutlet weak var degreeBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var univName: UITextField!
    @IBOutlet weak var gpa: UITextField!
    var ref:DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        designUI()
        fetchData()
        // Do any additional setup after loading the view.
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
                    self.setText(value: userObject?["University Name"] as! String, sender: self.univName)
                    self.setText(value: userObject?["GPA"] as! String, sender: self.gpa)
                    }}
            }
        })
    }
    
    func designUI() {
        univName.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        gpa.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        univName.layer.cornerRadius = 5.0
        univName.layer.masksToBounds = true
        univName.layer.borderWidth = 2.0
        gpa.layer.cornerRadius = 5.0
        gpa.layer.masksToBounds = true
        editBtn.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        editBtn.layer.borderWidth = 2
        editBtn.layer.cornerRadius = 5.0
        editBtn.layer.masksToBounds = true
        degreeBtn.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        degreeBtn.layer.borderWidth = 2
        degreeBtn.layer.cornerRadius = 5.0
        degreeBtn.layer.masksToBounds = true
        departmentBtn.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        departmentBtn.layer.borderWidth = 2
        departmentBtn.layer.cornerRadius = 5.0
        departmentBtn.layer.masksToBounds = true
        edueYear.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        edueYear.layer.borderWidth = 2
        edueYear.layer.cornerRadius = 5.0
        edueYear.layer.masksToBounds = true
        edusYear.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        edusYear.layer.borderWidth = 2
        edusYear.layer.cornerRadius = 5.0
        edusYear.layer.masksToBounds = true
    }

    public func setText(value:String , sender : UITextField){
        sender.text = value
    }

}
