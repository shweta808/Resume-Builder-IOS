//
//  ProfileViewController.swift
//  Resume Builder
//
//  Created by Shweta Shahane on 12/17/17.
//  Copyright © 2017 Rutvik Desai. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController, UITextFieldDelegate {

    var ref: DatabaseReference!
    @IBOutlet weak var techSkillsText: UITextView!
    @IBOutlet weak var profSummaryText: UITextView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designUI()
        techSkillsText.delegate = self as? UITextViewDelegate
        profSummaryText.delegate = self as? UITextViewDelegate
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
                        let proffSummary  = userObject?["Professional Summary"]
                        let techSkills = userObject?["Technical Skills"]
                        self.setProfileDetails(proffSummary:proffSummary as! String ,techSkills:techSkills as! String)
                    }
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
        cancelBtn.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        cancelBtn.layer.borderWidth = 2
        cancelBtn.layer.cornerRadius = 5.0
        cancelBtn.layer.masksToBounds = true
    }

    public func setProfileDetails(proffSummary:String,techSkills:String){
        self.profSummaryText.text = proffSummary
        self.techSkillsText.text = techSkills
    }
    
    @IBAction func backgroundTap(_ sender: UIControl) {
        hideKeyboard()
    }
    
    func hideKeyboard() {
        view.endEditing(false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }
        return false
    }

}
