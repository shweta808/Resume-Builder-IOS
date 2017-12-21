//
//  EducationViewController.swift
//  Resume Builder
//
//  Created by Shweta Shahane on 12/17/17.
//  Copyright © 2017 Rutvik Desai. All rights reserved.
//

import UIKit
import Firebase

class EducationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var edueYear: UIButton!
    @IBOutlet weak var edusYear: UIButton!
    @IBOutlet weak var departmentBtn: UIButton!
    @IBOutlet weak var degreeBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var univName: UITextField!
    @IBOutlet weak var gpa: UITextField!
    @IBOutlet weak var cancelBtn: UIButton!
    var ref:DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()

        univName.isUserInteractionEnabled = false
        gpa.isUserInteractionEnabled = false
        cancelBtn.isHidden = true

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
        gpa.layer.borderWidth = 2.0
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
        cancelBtn.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        cancelBtn.layer.borderWidth = 2
        cancelBtn.layer.cornerRadius = 5.0
        cancelBtn.layer.masksToBounds = true
    }
    
    // Modifying view so that keyboard does not hide textFields.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1:
            moveTextField(textField: textField, moveDistance: -60, up: true)
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1:
            moveTextField(textField: textField, moveDistance: -60, up: false)
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
    
    @IBAction func backgroundTap(_ sender: Any) {
        hideKeyboard()
    }
    
    func hideKeyboard() {
        view.endEditing(false)
    }

    public func setText(value:String , sender : UITextField){
        sender.text = value
    }

    //Edit and Save button
    @IBAction func editDetails(_ sender: UIButton) {
        if editBtn.currentTitle == "Save" {
            let eUnivname = univName.text
            let eGpa = gpa.text

            let user = Auth.auth().currentUser
            let current_user = user?.email

            ref.queryOrdered(byChild: "Email").queryEqual(toValue: current_user)
                .observe(.value, with: { snapshot in
                    if ( snapshot.value is NSNull ) {
                        print("Email not found")
                    } else {
                        for child in snapshot.children {
                            let key = (child as AnyObject).key as String
                            self.ref.child(key).updateChildValues(["University Name": eUnivname as Any])
                            self.ref.child(key).updateChildValues(["GPA": eGpa as Any])
                        }
                    }
                })

            self.editBtn.setTitle("Edit", for: UIControlState.normal)
            univName.isUserInteractionEnabled = false
            gpa.isUserInteractionEnabled = false
            cancelBtn.isHidden = true
        }
        else{
            self.editBtn.setTitle("Save", for: UIControlState.normal)
            univName.isUserInteractionEnabled = true
            gpa.isUserInteractionEnabled = true
            cancelBtn.isHidden = false
        }

    }

    @IBAction func cancelEdit(_ sender: UIButton) {
        fetchData()
    }

}
