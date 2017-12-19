//
//  ProfileViewController.swift
//  Resume Builder
//
//  Created by Shweta Shahane on 12/17/17.
//  Copyright © 2017 Rutvik Desai. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    var ref: DatabaseReference!
    @IBOutlet weak var techSkillsText: UITextView!
    @IBOutlet weak var profSummaryText: UITextView!
    @IBOutlet weak var editBtn: UIButton!
    
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
        ref = Database.database().reference().child("Resume Data")
        //observing the data changes
        ref.observe(DataEventType.value, with: { (snapshot) in
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                //iterating through all the values
                for user in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let userObject = user.value as? [String: AnyObject]
                    let proffSummary  = userObject?["Professional Summary"]
                    let techSkills = userObject?["Technical Skills"]
                    self.setProfileDetails(proffSummary:proffSummary as! String ,techSkills:techSkills as! String)
                }
            }
        })
    }
    
    func designUI() {
        profSummaryText.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        techSkillsText.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        profSummaryText.layer.cornerRadius = 5.0
        profSummaryText.layer.masksToBounds = true
        profSummaryText.layer.borderWidth = 2.0
        techSkillsText.layer.cornerRadius = 5.0
        techSkillsText.layer.masksToBounds = true
        techSkillsText.layer.borderWidth = 2.0
        editBtn.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        editBtn.layer.borderWidth = 2
        editBtn.layer.cornerRadius = 5.0
        editBtn.layer.masksToBounds = true
    }

    public func setProfileDetails(proffSummary:String,techSkills:String){
        self.profSummaryText.text = proffSummary
        self.techSkillsText.text = techSkills
    }

}
