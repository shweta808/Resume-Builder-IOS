//
//  ProjectsViewController.swift
//  Resume Builder
//
//  Created by Shweta Shahane on 12/17/17.
//  Copyright © 2017 Rutvik Desai. All rights reserved.
//

import UIKit
import Firebase

class ProjectsViewController: UIViewController, UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate {

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
    @IBOutlet weak var yearPicker: UIPickerView!

    var allData: Dictionary<String, Array<String>>?
    var allItems:Array<String>?
    var years:Array<String> = ["Select Year"]

    var sYearSelected: Int?
    var eYearSelected: Int?
    var yFlag = 0
    var e1sYearSelected: Int?
    var e1eYearSelected: Int?
    var e2sYearSelected: Int?
    var e2eYearSelected: Int?
    var e3sYearSelected: Int?
    var e3eYearSelected: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        yearPicker.isHidden = true
        projectDesc1.delegate = self
        projectDesc2.delegate = self
        projectDesc3.delegate = self
        psYear1.isUserInteractionEnabled = false
        peYear1.isUserInteractionEnabled = false
        psYear2.isUserInteractionEnabled = false
        peYear2.isUserInteractionEnabled = false
        psYear3.isUserInteractionEnabled = false
        peYear3.isUserInteractionEnabled = false

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

        // Getting data from info file.
        let data = Bundle.main
        let dataList:String? = data.path(forResource: "DataList", ofType: "plist")
        if dataList != nil {
            allData = (NSDictionary.init(contentsOfFile: dataList!) as! Dictionary)
            allItems = allData?.keys.sorted()
            let tempY = (allData!["Year"]?.sorted())!
            years = years + tempY
        }

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
                        if userObject?["Project 1 Start Year"] as! String != "" {
                            self.setButtonTitle(value: userObject?["Project 1 Start Year"] as! String, sender: self.psYear1)
                        }
                        else {
                            self.psYear1.setTitle("Start Year", for: .normal)
                        }
                        if userObject?["Project 1 End Year"] as! String != "" {
                            self.setButtonTitle(value: userObject?["Project 1 End Year"] as! String, sender: self.peYear1)
                        }
                        else {
                            self.peYear1.setTitle("End Year", for: .normal)
                        }
                        self.setText(value: userObject?["Project 2 Name"] as! String, sender: self.projName2)
                        self.setTextView(value: userObject?["Project 2 Description"] as! String, sender: self.projectDesc2)
                        self.setText(value: userObject?["Project 2 Organization"] as! String, sender: self.org2)
                        self.setText(value: userObject?["Project 2 Technologies"] as! String, sender: self.tech2)
                        if userObject?["Project 2 Start Year"] as! String != "" {
                            self.setButtonTitle(value: userObject?["Project 2 Start Year"] as! String, sender: self.psYear2)
                        }
                        else {
                            self.psYear2.setTitle("Start Year", for: .normal)
                        }
                        if userObject?["Project 2 End Year"] as! String != "" {
                            self.setButtonTitle(value: userObject?["Experience 2 End Year"] as! String, sender: self.peYear2)
                        }
                        else {
                            self.peYear2.setTitle("End Year", for: .normal)
                        }
                        self.setText(value: userObject?["Project 3 Name"] as! String, sender: self.projectName3)
                        self.setTextView(value: userObject?["Project 3 Description"] as! String, sender: self.projectDesc3)
                        self.setText(value: userObject?["Project 3 Organization"] as! String, sender: self.org3)
                        self.setText(value: userObject?["Project 3 Technologies"] as! String, sender: self.tech3)
                        if userObject?["Project 3 Start Year"] as! String != "" {
                            self.setButtonTitle(value: userObject?["Project 3 Start Year"] as! String, sender: self.psYear3)
                        }
                        else {
                            self.psYear3.setTitle("Start Year", for: .normal)
                        }
                        if userObject?["Project 3 End Year"] as! String != "" {
                            self.setButtonTitle(value: userObject?["Project 3 End Year"] as! String, sender: self.peYear3)
                        }
                        else {
                            self.peYear3.setTitle("End Year", for: .normal)
                        }
                    }}
            }
        })
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        let textField = UITextField()
        switch textView.tag {
        case 3:
            moveTextField(textField: textField, moveDistance: -190, up: true)
        case 7:
            moveTextField(textField: textField, moveDistance: -300, up: true)
        case 11:
            moveTextField(textField: textField, moveDistance: -250, up: true)
        default:
            break
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        let textField = UITextField()
        switch textView.tag {
        case 3:
            moveTextField(textField: textField, moveDistance: -190, up: false)
        case 7:
            moveTextField(textField: textField, moveDistance: -300, up: false)
        case 11:
            moveTextField(textField: textField, moveDistance: -250, up: false)
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
        yearPicker.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        yearPicker.layer.borderWidth = 2
        yearPicker.layer.cornerRadius = 5.0
        yearPicker.layer.masksToBounds = true
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
        hidePicker()
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
                            if self.e1sYearSelected != nil {
                                self.ref.child(key).updateChildValues(["Project 1 Start Year": "Start Year:\(String(describing: self.e1sYearSelected!))"])
                            }
                            if self.e1eYearSelected != nil {
                                self.ref.child(key).updateChildValues(["Project 1 End Year": "End Year:\(String(describing: self.e1eYearSelected!))"])
                            }
                            self.ref.child(key).updateChildValues(["Project 2 Description": eProjectDesc2 as Any])
                            self.ref.child(key).updateChildValues(["Project 2 Name": eProjectName2 as Any])
                            self.ref.child(key).updateChildValues(["Project 2 Technologies": eProjectTech2 as Any])
                            self.ref.child(key).updateChildValues(["Project 2 Organization": eProjectOrg2 as Any])
                            if self.e2sYearSelected != nil {
                                self.ref.child(key).updateChildValues(["Project 2 Start Year": "Start Year:\(String(describing: self.e2sYearSelected!))"])
                            }
                            if self.e2eYearSelected != nil {
                                self.ref.child(key).updateChildValues(["Project 2 End Year": "End Year:\(String(describing: self.e2eYearSelected!))"])
                            }
                            self.ref.child(key).updateChildValues(["Project 3 Description": eProjectDesc3 as Any])
                            self.ref.child(key).updateChildValues(["Project 3 Name": eProjectName3 as Any])
                            self.ref.child(key).updateChildValues(["Project 3 Technologies": eProjectTech3 as Any])
                            self.ref.child(key).updateChildValues(["Project 3 Organization": eProjectOrg3 as Any])
                            if self.e3sYearSelected != nil {
                                self.ref.child(key).updateChildValues(["Project 3 Start Year": "Start Year:\(String(describing: self.e3sYearSelected!))"])
                            }
                            if self.e3eYearSelected != nil {
                                self.ref.child(key).updateChildValues(["Project 3 End Year": "End Year:\(String(describing: self.e3eYearSelected!))"])
                            }
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

            psYear1.isUserInteractionEnabled = false
            peYear1.isUserInteractionEnabled = false
            psYear2.isUserInteractionEnabled = false
            peYear2.isUserInteractionEnabled = false
            psYear3.isUserInteractionEnabled = false
            peYear3.isUserInteractionEnabled = false
            yearPicker.isHidden = true

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

            psYear1.isUserInteractionEnabled = true
            peYear1.isUserInteractionEnabled = true
            psYear2.isUserInteractionEnabled = true
            peYear2.isUserInteractionEnabled = true
            psYear3.isUserInteractionEnabled = true
            peYear3.isUserInteractionEnabled = true
        }

    }

    @IBAction func cancelEdit(_ sender: UIButton) {
        fetchData()
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
        
        psYear1.isUserInteractionEnabled = false
        peYear1.isUserInteractionEnabled = false
        psYear2.isUserInteractionEnabled = false
        peYear2.isUserInteractionEnabled = false
        psYear3.isUserInteractionEnabled = false
        peYear3.isUserInteractionEnabled = false
        yearPicker.isHidden = true
        cancelBtn.isHidden = true
    }

    //Picker implementation

    //Date Picker implementation
    // Setting up pickerView.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return years.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return years[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch yFlag {
        case 0:
            if years[row] != "Select Year"{
                e1sYearSelected = Int((years[row]))
                let temp = Int((peYear1.titleLabel?.text)!.suffix(4))
                if temp != nil {
                    if e1sYearSelected! > temp! {
                        AlertController.displayAlert(self, title: "Alert", message: "Start year can not be after End year!")
                        psYear1.setTitle("Select Start Year", for: .normal)
                    }
                    else {
                        psYear1.setTitle("Start Year:" + (years[row]), for: .normal)
                    }
                }
                else {
                    psYear1.setTitle("Start Year:" + (years[row]), for: .normal)
                }
            }
            else {
                psYear1.setTitle("Select Start Year", for: .normal)
            }
        case 1:
            if years[row] != "Select Year"{
                e1eYearSelected = Int((years[row]))
                if e1sYearSelected! > e1eYearSelected! {
                    AlertController.displayAlert(self, title: "Alert", message: "End year can not be before Start year!")
                    peYear1.setTitle("Select End Year", for: .normal)
                }
                else {
                    peYear1.setTitle("End Year: " + (years[row]), for: .normal)
                }
            }
            else {
                peYear1.setTitle("Select End Year", for: .normal)
            }
        case 2:
            if years[row] != "Select Year"{
                e2sYearSelected = Int((years[row]))
                let temp = Int((peYear2.titleLabel?.text)!.suffix(4))
                if temp != nil {
                    if e2sYearSelected! > temp! {
                        AlertController.displayAlert(self, title: "Alert", message: "Start year can not be after End year!")
                        psYear2.setTitle("Select Start Year", for: .normal)
                    }
                    else {
                        psYear2.setTitle("Start Year:" + (years[row]), for: .normal)
                    }
                }
                else {
                    psYear2.setTitle("Start Year:" + (years[row]), for: .normal)
                }
            }
            else {
                psYear2.setTitle("Select Start Year", for: .normal)
            }
        case 3:
            if years[row] != "Select Year"{
                e2eYearSelected = Int((years[row]))
                if e2sYearSelected! > e2eYearSelected! {
                    AlertController.displayAlert(self, title: "Alert", message: "End year can not be before Start year!")
                    peYear2.setTitle("Select End Year", for: .normal)
                }
                else {
                    peYear2.setTitle("End Year: " + (years[row]), for: .normal)
                }
            }
            else {
                peYear2.setTitle("Select End Year", for: .normal)
            }
        case 4:
            if years[row] != "Select Year"{
                e3sYearSelected = Int((years[row]))
                let temp = Int((peYear3.titleLabel?.text)!.suffix(4))
                if temp != nil {
                    if e3sYearSelected! > temp! {
                        AlertController.displayAlert(self, title: "Alert", message: "Start year can not be after End year!")
                        psYear3.setTitle("Select Start Year", for: .normal)
                    }
                    else {
                        psYear3.setTitle("Start Year:" + (years[row]), for: .normal)
                    }
                }
                else {
                    psYear3.setTitle("Start Year:" + (years[row]), for: .normal)
                }
            }
            else {
                psYear3.setTitle("Select Start Year", for: .normal)
            }
        case 5:
            if years[row] != "Select Year"{
                e3eYearSelected = Int((years[row]))
                if e3sYearSelected! > e3eYearSelected! {
                    AlertController.displayAlert(self, title: "Alert", message: "End year can not be before Start year!")
                    peYear3.setTitle("Select End Year", for: .normal)
                }
                else {
                    peYear3.setTitle("End Year: " + (years[row]), for: .normal)
                }
            }
            else {
                peYear3.setTitle("Select End Year", for: .normal)
            }
        default:
            break
        }
        yearPicker.isHidden = true
        yearPicker.selectRow(0, inComponent: 0, animated: true)
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var title: NSAttributedString?
        let data = years[row]
        title = NSAttributedString(string: data, attributes: [NSAttributedStringKey.foregroundColor:UIColor.white])
        return title
    }

    // pickerView setup end.


    //buttons pressed
    @IBAction func e1sYearPressed(_ sender: UIButton) {
        hideKeyboard()
        yearPicker.isHidden = false
        yFlag = 0
        yearPicker.frame.origin.x = psYear1.frame.origin.x
        yearPicker.frame.origin.y = psYear1.frame.origin.y
    }

    @IBAction func e1eYearPressed(_ sender: UIButton) {
        if psYear1.titleLabel?.text == "Select Start Year" || psYear1.titleLabel?.text == "Start Year" {
            AlertController.displayAlert(self, title: "Alert", message: "Please select start year first!")
        }
        else {
            yearPicker.isHidden = false
            yFlag = 1
            yearPicker.frame.origin.x = psYear1.frame.origin.x
            yearPicker.frame.origin.y = psYear1.frame.origin.y
        }
        hideKeyboard()
    }

    @IBAction func e2sYearPressed(_ sender: UIButton) {
        hideKeyboard()
        yFlag = 2
        yearPicker.isHidden = false
        yearPicker.frame.origin.x = psYear2.frame.origin.x
        yearPicker.frame.origin.y = psYear2.frame.origin.y
    }

    @IBAction func e2eYearPressed(_ sender: UIButton) {
        if psYear2.titleLabel?.text == "Select Start Year" || psYear2.titleLabel?.text == "Start Year" {
            AlertController.displayAlert(self, title: "Alert", message: "Please select start year first!")
        }
        else {
            yFlag = 3
            yearPicker.isHidden = false
            yearPicker.frame.origin.x = psYear2.frame.origin.x
            yearPicker.frame.origin.y = psYear2.frame.origin.y
        }
        hideKeyboard()
    }

    @IBAction func e3sYearPressed(_ sender: UIButton) {
        hideKeyboard()
        yFlag = 4
        yearPicker.isHidden = false
        yearPicker.frame.origin.x = psYear2.frame.origin.x
        yearPicker.frame.origin.y = psYear2.frame.origin.y
    }

    @IBAction func e3eYearPressed(_ sender: UIButton) {
        if psYear3.titleLabel?.text == "Select Start Year" || psYear3.titleLabel?.text == "Start Year"{
            AlertController.displayAlert(self, title: "Alert", message: "Please select start year first!")
        }
        else {
            yFlag = 5
            yearPicker.isHidden = false
            yearPicker.frame.origin.x = psYear2.frame.origin.x
            yearPicker.frame.origin.y = psYear2.frame.origin.y
        }
        hideKeyboard()
    }
    // Hiding picker.
    func hidePicker() {
        yearPicker.isHidden = true
    }

    public func setButtonTitle(value:String , sender : UIButton){
        sender.setTitle(value, for: UIControlState.normal)
    }
    
    // Hide picker when clicked on textFields.
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        hidePicker()
        return true
    }
}

