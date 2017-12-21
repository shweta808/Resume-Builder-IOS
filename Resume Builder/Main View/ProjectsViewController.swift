//
//  ProjectsViewController.swift
//  Resume Builder
//
//  Created by Shweta Shahane on 12/17/17.
//  Copyright © 2017 Rutvik Desai. All rights reserved.
//

import UIKit
import Firebase

class ProjectsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var cancelBtn: UIButton!
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

        projectName1.isUserInteractionEnabled = false
        projectDesc1.isUserInteractionEnabled = false
        org1.isUserInteractionEnabled = false
        tech1.isUserInteractionEnabled = false

        projName2.isUserInteractionEnabled = false
        projectDesc2.isUserInteractionEnabled = false
        org2.isUserInteractionEnabled = false
        tech2.isUserInteractionEnabled = false

        projectName3.isUserInteractionEnabled = false
        projectDesc3.isUserInteractionEnabled = false
        org3.isUserInteractionEnabled = false
        tech3.isUserInteractionEnabled = false
        cancelBtn.isHidden = true
        
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
        cancelBtn.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        cancelBtn.layer.borderWidth = 2
        cancelBtn.layer.cornerRadius = 5.0
        cancelBtn.layer.masksToBounds = true
    }
    
    // Modifying view so that keyboard does not hide textFields.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 3:
            moveTextField(textField: textField, moveDistance: -190, up: true)
        case 4:
            moveTextField(textField: textField, moveDistance: -210, up: true)
        case 5:
            moveTextField(textField: textField, moveDistance: -230, up: true)
        case 6:
            moveTextField(textField: textField, moveDistance: -250, up: true)
        case 7:
            moveTextField(textField: textField, moveDistance: -270, up: true)
        case 8:
            moveTextField(textField: textField, moveDistance: -290, up: true)
        case 9:
            moveTextField(textField: textField, moveDistance: -310, up: true)
        case 10:
            moveTextField(textField: textField, moveDistance: -330, up: true)
        case 11:
            moveTextField(textField: textField, moveDistance: -350, up: true)
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 3:
            moveTextField(textField: textField, moveDistance: -190, up: false)
        case 4:
            moveTextField(textField: textField, moveDistance: -210, up: false)
        case 5:
            moveTextField(textField: textField, moveDistance: -230, up: false)
        case 6:
            moveTextField(textField: textField, moveDistance: -250, up: false)
        case 7:
            moveTextField(textField: textField, moveDistance: -270, up: false)
        case 8:
            moveTextField(textField: textField, moveDistance: -290, up: false)
        case 9:
            moveTextField(textField: textField, moveDistance: -310, up: false)
        case 10:
            moveTextField(textField: textField, moveDistance: -330, up: false)
        case 11:
            moveTextField(textField: textField, moveDistance: -350, up: false)
        default:
            break
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
    // Modifying view ends.
    
    // For navigating through textFields.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    @IBAction func backgroundTap(_ sender: UIControl) {
        hideKeyboard()
    }
    
    func hideKeyboard() {
        view.endEditing(false)
    }
    
    public func setText(value:String , sender : UITextField){
        sender.text = value
    }

    public func setTextView(value:String , sender : UITextView){
        sender.text = value
    }

    //Edit and save data

    @IBAction func editDetails(_ sender: UIButton) {
        if editBtn.currentTitle == "Save" {
            let eProjectName1 = projectName1.text
            let eProjectOrg1 = org1.text
            let eProjectTech1 = tech1.text
            let eProjectDesc1 = projectDesc1.text

            let eProjectName2 = projName2.text
            let eProjectOrg2 = org2.text
            let eProjectTech2 = tech2.text
            let eProjectDesc2 = projectDesc2.text

            let eProjectName3 = projectName3.text
            let eProjectOrg3 = org3.text
            let eProjectTech3 = tech3.text
            let eProjectDesc3 = projectDesc3.text

            let user = Auth.auth().currentUser
            let current_user = user?.email

            ref.queryOrdered(byChild: "Email").queryEqual(toValue: current_user)
                .observe(.value, with: { snapshot in
                    if ( snapshot.value is NSNull ) {
                        print("Email not found")
                    } else {
                        for child in snapshot.children {
                            let key = (child as AnyObject).key as String
                            self.ref.child(key).updateChildValues(["Project 1 Description": eProjectDesc1 as Any])
                            self.ref.child(key).updateChildValues(["Project 1 Name": eProjectName1 as Any])
                            self.ref.child(key).updateChildValues(["Project 1 Technologies": eProjectTech1 as Any])
                            self.ref.child(key).updateChildValues(["Project 1 Organization": eProjectOrg1 as Any])

                            self.ref.child(key).updateChildValues(["Project 2 Description": eProjectDesc2 as Any])
                            self.ref.child(key).updateChildValues(["Project 2 Name": eProjectName2 as Any])
                            self.ref.child(key).updateChildValues(["Project 2 Technologies": eProjectTech2 as Any])
                            self.ref.child(key).updateChildValues(["Project 2 Organization": eProjectOrg2 as Any])

                            self.ref.child(key).updateChildValues(["Project 3 Description": eProjectDesc3 as Any])
                            self.ref.child(key).updateChildValues(["Project 3 Name": eProjectName3 as Any])
                            self.ref.child(key).updateChildValues(["Project 3 Technologies": eProjectTech3 as Any])
                            self.ref.child(key).updateChildValues(["Project 3 Organization": eProjectOrg3 as Any])
                        }
                    }
                })

            self.editBtn.setTitle("Edit", for: UIControlState.normal)
            projectName1.isUserInteractionEnabled = false
            projectDesc1.isUserInteractionEnabled = false
            org1.isUserInteractionEnabled = false
            tech1.isUserInteractionEnabled = false

            projName2.isUserInteractionEnabled = false
            projectDesc2.isUserInteractionEnabled = false
            org2.isUserInteractionEnabled = false
            tech2.isUserInteractionEnabled = false

            projectName3.isUserInteractionEnabled = false
            projectDesc3.isUserInteractionEnabled = false
            org3.isUserInteractionEnabled = false
            tech3.isUserInteractionEnabled = false
            cancelBtn.isHidden = true
        }
        else{
            self.editBtn.setTitle("Save", for: UIControlState.normal)
            projectName1.isUserInteractionEnabled = true
            projectDesc1.isUserInteractionEnabled = true
            org1.isUserInteractionEnabled = true
            tech1.isUserInteractionEnabled = true

            projName2.isUserInteractionEnabled = true
            projectDesc2.isUserInteractionEnabled = true
            org2.isUserInteractionEnabled = true
            tech2.isUserInteractionEnabled = true

            projectName3.isUserInteractionEnabled = true
            projectDesc3.isUserInteractionEnabled = true
            org3.isUserInteractionEnabled = true
            tech3.isUserInteractionEnabled = true
            cancelBtn.isHidden = false
        }

    }

    @IBAction func cancelEdit(_ sender: UIButton) {
        fetchData()
    }

}
