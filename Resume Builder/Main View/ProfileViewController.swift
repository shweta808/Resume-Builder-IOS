//
//  ProfileViewController.swift
//  Resume Builder
//
//  Created by Shweta Shahane on 12/17/17.
//  Copyright © 2017 Rutvik Desai. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    var ref: DatabaseReference!
    @IBOutlet weak var techSkillsText: UITextView!
    @IBOutlet weak var profSummaryText: UITextView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profSummaryText.isUserInteractionEnabled = false
        techSkillsText.isUserInteractionEnabled = false
        cancelBtn.isHidden = true
        designUI()
        techSkillsText.delegate = self
        profSummaryText.delegate = self
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
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        let textField = UITextField()
        if textView.tag == 1 {
            moveTextField(textField: textField, moveDistance: -250, up: true)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        let textField = UITextField()
        if textView.tag == 1 {
            moveTextField(textField: textField, moveDistance: -250, up: false)
        }
    }
    func moveTextField(textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance: -moveDistance)
        UIView.beginAnimations("animateTF", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = (self.view.frame).offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
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

    //edit and save changes

    @IBAction func editDetails(_ sender: UIButton) {
        if editBtn.currentTitle == "Save" {
            let eProffSummary = profSummaryText.text
            let eTechSkill = techSkillsText.text

            let user = Auth.auth().currentUser
            let current_user = user?.email

            ref.queryOrdered(byChild: "Email").queryEqual(toValue: current_user)
                .observe(.value, with: { snapshot in
                    if ( snapshot.value is NSNull ) {
                        print("Email not found")
                    } else {
                        for child in snapshot.children {
                            let key = (child as AnyObject).key as String
                            self.ref.child(key).updateChildValues(["Professional Summary": eProffSummary as Any])
                            self.ref.child(key).updateChildValues(["Technical Skills": eTechSkill as Any])
                        }
                    }
                })
            self.editBtn.setTitle("Edit", for: UIControlState.normal)
            profSummaryText.isUserInteractionEnabled = false
            techSkillsText.isUserInteractionEnabled = false
            cancelBtn.isHidden = true
        }
        else{
            self.editBtn.setTitle("Save", for: UIControlState.normal)
            profSummaryText.isUserInteractionEnabled = true
            techSkillsText.isUserInteractionEnabled = true
            cancelBtn.isHidden = false
        }
    }

    @IBAction func cancelEdit(_ sender: UIButton) {
        self.editBtn.setTitle("Edit", for: UIControlState.normal)
        profSummaryText.isUserInteractionEnabled = false
        techSkillsText.isUserInteractionEnabled = false
        cancelBtn.isHidden = true
        fetchData()
    }

}
