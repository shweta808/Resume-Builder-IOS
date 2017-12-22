//
//  EducationViewController.swift
//  Resume Builder
//
//  Created by Shweta Shahane on 12/17/17.
//  Copyright © 2017 Rutvik Desai. All rights reserved.
//

import UIKit
import Firebase

class EducationViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var edueYear: UIButton!
    @IBOutlet weak var edusYear: UIButton!
    @IBOutlet weak var departmentBtn: UIButton!
    @IBOutlet weak var degreeBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var univName: UITextField!
    @IBOutlet weak var gpa: UITextField!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var degreePicker: UIPickerView!
    @IBOutlet weak var yearPicker: UIPickerView!
    @IBOutlet weak var deptPicker: UIPickerView!

    var sYearSelected: Int?
    var eYearSelected: Int?
    var deptSelected: String?
    var degSelected: String?
    var yFlag = 0

    var allData: Dictionary<String, Array<String>>?
    var allItems:Array<String>?
    var years:Array<String> = ["Select Year"]
    var deparments:Array<String> = ["Select Department"]
    var degrees:Array<String> = ["Select Degree"]


    var ref:DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        yearPicker.isHidden = true
        deptPicker.isHidden = true
        degreePicker.isHidden = true

        edueYear.isUserInteractionEnabled = false
        edusYear.isUserInteractionEnabled = false
        departmentBtn.isUserInteractionEnabled = false
        degreeBtn.isUserInteractionEnabled = false

        univName.isUserInteractionEnabled = false
        gpa.isUserInteractionEnabled = false
        cancelBtn.isHidden = true

        let data = Bundle.main
        let dataList:String? = data.path(forResource: "DataList", ofType: "plist")
        if dataList != nil {
            allData = (NSDictionary.init(contentsOfFile: dataList!) as! Dictionary)
            allItems = allData?.keys.sorted()
            let tempY = (allData!["Year"]?.sorted())!
            let tempDep = (allData!["Department"]?.sorted())!
            let tempDeg = (allData!["Degree"]?.sorted())!
            years = years + tempY
            deparments = deparments + tempDep
            degrees = degrees + tempDeg
        }

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
                        if userObject?["Education Start Year"] as! String != "" {
                            self.setButtonTitle(value: userObject?["Education Start Year"] as! String, sender: self.edusYear)
                        }
                        else {
                            self.edusYear.setTitle("Start Year", for: .normal)
                        }
                        if userObject?["Education End Year"] as! String != "" {
                            self.setButtonTitle(value: userObject?["Education End Year"] as! String, sender: self.edueYear)
                        }
                        else {
                            self.edueYear.setTitle("End Year", for: .normal)
                        }
                        if userObject?["Education Department"] as! String != "" {
                            self.setButtonTitle(value: userObject?["Education Department"] as! String, sender: self.departmentBtn)
                        }
                        if userObject?["Education Degree"] as! String != "" {
                            self.setButtonTitle(value: userObject?["Education Degree"] as! String, sender: self.degreeBtn)
                        }
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
        degreePicker.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        degreePicker.layer.borderWidth = 2
        degreePicker.layer.cornerRadius = 5.0
        degreePicker.layer.masksToBounds = true
        deptPicker.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        deptPicker.layer.borderWidth = 2
        deptPicker.layer.cornerRadius = 5.0
        deptPicker.layer.masksToBounds = true
        yearPicker.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        yearPicker.layer.borderWidth = 2
        yearPicker.layer.cornerRadius = 5.0
        yearPicker.layer.masksToBounds = true
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
        hidePicker()
        hideKeyboard()
    }
    
    func hideKeyboard() {
        view.endEditing(false)
    }

    public func setText(value:String , sender : UITextField){
        sender.text = value
    }
    public func setButtonTitle(value:String , sender : UIButton){
        sender.setTitle(value, for: UIControlState.normal)
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
                            if self.sYearSelected != nil {
                                self.ref.child(key).updateChildValues(["Education Start Year": "Start Year:\(String(describing: self.sYearSelected!))"])
                            }
                            if self.eYearSelected != nil {
                                self.ref.child(key).updateChildValues(["Education End Year": "End Year:\(String(describing: self.eYearSelected!))"])
                            }
                            if self.deptSelected != nil {
                                self.ref.child(key).updateChildValues(["Education Department": self.deptSelected!])
                            }
                            if self.degSelected != nil {
                                self.ref.child(key).updateChildValues(["Education Degree": self.degSelected!])
                            }

                        }
                    }
                })

            self.editBtn.setTitle("Edit", for: UIControlState.normal)
            univName.isUserInteractionEnabled = false
            gpa.isUserInteractionEnabled = false
            degreeBtn.isUserInteractionEnabled = false
            departmentBtn.isUserInteractionEnabled = false
            edusYear.isUserInteractionEnabled = false
            edueYear.isUserInteractionEnabled = false
            cancelBtn.isHidden = true
        }
        else{
            self.editBtn.setTitle("Save", for: UIControlState.normal)
            univName.isUserInteractionEnabled = true
            gpa.isUserInteractionEnabled = true
            cancelBtn.isHidden = false
            degreeBtn.isUserInteractionEnabled = true
            departmentBtn.isUserInteractionEnabled = true
            edusYear.isUserInteractionEnabled = true
            edueYear.isUserInteractionEnabled = true
        }
    }

    @IBAction func cancelEdit(_ sender: UIButton) {
        self.editBtn.setTitle("Edit", for: UIControlState.normal)
        univName.isUserInteractionEnabled = false
        gpa.isUserInteractionEnabled = false
        degreeBtn.isUserInteractionEnabled = false
        departmentBtn.isUserInteractionEnabled = false
        edusYear.isUserInteractionEnabled = false
        edueYear.isUserInteractionEnabled = false
        cancelBtn.isHidden = true
        fetchData()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case yearPicker: return years.count
        case deptPicker: return deparments.count
        case degreePicker: return degrees.count
        default: return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case yearPicker: return years[row]
        case deptPicker: return deparments[row]
        case degreePicker: return degrees[row]
        default: return ""
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case yearPicker:
            if yFlag == 0 {
                if years[row] != "Select Year"{
                    sYearSelected = Int((years[row]))
                    let temp = Int((edueYear.titleLabel?.text)!.suffix(4))
                    if temp != nil {
                        if sYearSelected! > temp! {
                            AlertController.displayAlert(self, title: "Alert", message: "Start year can not be after End year!")
                            edusYear.setTitle("Select Start Year", for: .normal)
                        }
                        else {
                            edusYear.setTitle("Start Year:" + (years[row]), for: .normal)
                        }
                    }
                    else {
                        edusYear.setTitle("Start Year:" + (years[row]), for: .normal)
                    }
                }
                else {
                    edusYear.setTitle("Select Start Year", for: .normal)
                }
            }
            else {
                if years[row] != "Select Year"{
                    eYearSelected = Int((years[row]))
                    if sYearSelected! > eYearSelected! {
                        AlertController.displayAlert(self, title: "Alert", message: "End year can not be before Start year!")
                        edueYear.setTitle("Select End Year", for: .normal)
                    }
                    else {
                        edueYear.setTitle("End Year: " + (years[row]), for: .normal)
                    }
                }
                else {
                    edueYear.setTitle("Select End Year", for: .normal)
                }
            }
            yearPicker.isHidden = true
        case deptPicker:
            if deparments[row] != "Select Department"{
                deptSelected = deparments[row]
                departmentBtn.setTitle(deparments[row], for: .normal)
            }
            else {
                departmentBtn.setTitle("Select Department", for: .normal)
            }
            deptPicker.isHidden = true
        case degreePicker:
            if years[row] != "Select Degree"{
                degSelected = degrees[row]
                degreeBtn.setTitle(degrees[row], for: .normal)
            }
            else{
                degreeBtn.setTitle("Select Degree", for: .normal)
            }
            degreePicker.isHidden = true
        default:
            break
        }
        yearPicker.selectRow(0, inComponent: 0, animated: true)
        degreePicker.selectRow(0, inComponent: 0, animated: true)
        deptPicker.selectRow(0, inComponent: 0, animated: true)
    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var data: String = ""
        var title: NSAttributedString?
        switch pickerView {
        case yearPicker:
            data = years[row]
        case deptPicker:
            data = deparments[row]
        case degreePicker:
            data = degrees[row]
        default:
            break
        }
        title = NSAttributedString(string: data, attributes: [NSAttributedStringKey.foregroundColor:UIColor.white])
        return title
    }
    // pickerView setup end.

    @IBAction func degreePressed(_ sender: UIButton) {
        hideKeyboard()
        degreePicker.isHidden = false
    }

    @IBAction func departmentPressed(_ sender: UIButton) {
        hideKeyboard()
        deptPicker.isHidden = false
    }

    @IBAction func startYearPressed(_ sender: UIButton) {
        hideKeyboard()
        yFlag = 0
        yearPicker.isHidden = false
    }

    @IBAction func endYearPressed(_ sender: UIButton) {
        hideKeyboard()
        if edusYear.titleLabel?.text == "Select Start Year" || edusYear.titleLabel?.text == "Start Year" {
            AlertController.displayAlert(self, title: "Alert", message: "Please select start year first!")
        }
        else {
            yFlag = 1
            yearPicker.isHidden = false
        }
    }

    // Hiding picker.
    func hidePicker() {
        yearPicker.isHidden = true
        degreePicker.isHidden = true
        deptPicker.isHidden = true
    }
    
    // Hide picker when clicked on textFields.
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        hidePicker()
        return true
    }

}
