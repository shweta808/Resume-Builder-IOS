//
//  SignUp.swift
//  Resume Builder
//
//  Created by MyBook on 12/15/17.
//  Copyright © 2017 Rutvik Desai. All rights reserved.
//

import UIKit
import Firebase
class SignUp: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var fullAddress: UITextField!
    @IBOutlet weak var contactNumber: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var profSummary: UITextField!
    @IBOutlet weak var uniName: UITextField!
    @IBOutlet weak var gpa: UITextField!
    @IBOutlet weak var nextSectionView: UIView!
    @IBOutlet weak var degreePicker: UIPickerView!
    @IBOutlet weak var departmentPicker: UIPickerView!
    @IBOutlet weak var yearPicker: UIPickerView!
    var fName = ""; var fAddress = ""; var cNumber = ""; var emailValue = ""; var passwordValue = ""; var pSummary = ""
    var uName = ""; var uGPA = ""; var department = ""; var degree = ""; var sYear = ""; var eYear = ""
    var allData: Dictionary<String, Array<String>>?
    var allItems:Array<String>?
    var years:Array<String> = ["Select Year"]
    var deparments:Array<String> = ["Select Department"]
    var degrees:Array<String> = ["Select Degree"]
    @IBOutlet weak var degreeBtn: UIButton!
    @IBOutlet weak var departmentBtn: UIButton!
    @IBOutlet weak var sYearBtn: UIButton!
    @IBOutlet weak var eYearBtn: UIButton!
    @IBOutlet weak var nextSecBtn: UIButton!
    @IBOutlet weak var goLoginBtn: UIButton!
    var sYearSelected: Int?
    var eYearSelected: Int?
    var yFlag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextSectionView.isHidden = true
        designUI()
        // Getting data from info file.
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Setting up pickerView.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case yearPicker: return years.count
        case departmentPicker: return deparments.count
        case degreePicker: return degrees.count
            default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case yearPicker: return years[row]
        case departmentPicker: return deparments[row]
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
                    let temp = Int((eYearBtn.titleLabel?.text)!.suffix(4))
                    if temp != nil {
                        if sYearSelected! > temp! {
                            AlertController.displayAlert(self, title: "Alert", message: "Start year can not be after End year!")
                            sYearBtn.setTitle("Select Start Year", for: .normal)
                        }
                        else {
                            sYearBtn.setTitle("Start Year:" + (years[row]), for: .normal)
                        }
                    }
                    else {
                        sYearBtn.setTitle("Start Year:" + (years[row]), for: .normal)
                    }
                }
                else {
                    sYearBtn.setTitle("Select Start Year", for: .normal)
                }
            }
            else {
                if years[row] != "Select Year"{
                    eYearSelected = Int((years[row]))
                    if sYearSelected! > eYearSelected! {
                        AlertController.displayAlert(self, title: "Alert", message: "End year can not be before Start year!")
                        eYearBtn.setTitle("Select End Year", for: .normal)
                    }
                    else {
                        eYearBtn.setTitle("End Year: " + (years[row]), for: .normal)
                    }
                }
                else {
                    eYearBtn.setTitle("Select End Year", for: .normal)
                }
            }
            yearPicker.isHidden = true
        case departmentPicker:
            if deparments[row] != "Select Department"{
                departmentBtn.setTitle(deparments[row], for: .normal)
            }
            else {
                departmentBtn.setTitle("Select Department", for: .normal)
            }
            departmentPicker.isHidden = true
        case degreePicker:
            if years[row] != "Select Degree"{
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
        departmentPicker.selectRow(0, inComponent: 0, animated: true)
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var data: String = ""
        var title: NSAttributedString?
        switch pickerView {
        case yearPicker:
            data = years[row]
        case departmentPicker:
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
    
    // Hide keyboard and picker when user taps on the screen.
    @IBAction func backgroupTap(_ sender: UIControl) {
        hideKeyboard()
        hidePicker()
    }
    
    // Validations and going to the next section.
    @IBAction func nextSectionPressed(_ sender: UIButton) {
        hideKeyboard()
        hidePicker()
        if fullName.text == "" {
            AlertController.displayAlert(self, title: "Alert", message: "Full Name Required!")
        }
        else if fullAddress.text == "" {
            AlertController.displayAlert(self, title: "Alert", message: "Full Address Required!")
        }
        else if contactNumber.text == "" {
            AlertController.displayAlert(self, title: "Alert", message: "Contact Number Required!")
        }
        else if !numberValid(contactNumber.text!) {
            AlertController.displayAlert(self, title: "Alert", message: "Enter valid contact number!")
        }
        else if email.text == "" {
            AlertController.displayAlert(self, title: "Alert", message: "Email Required!")
        }
        else if !emailValid(email.text!) {
            AlertController.displayAlert(self, title: "Alert", message: "Enter valid email!")
        }
        else if password.text == "" {
            AlertController.displayAlert(self, title: "Alert", message: "Password Required!")
        }
        else if (password.text?.count)! < 6 {
            AlertController.displayAlert(self, title: "Alert", message: "Password should have atleast 6 characters!")
        }
        else if degreeBtn.titleLabel?.text == "Select Degree" {
            AlertController.displayAlert(self, title: "Alert", message: "Degree Required!")
        }
        else if departmentBtn.titleLabel?.text == "Select Department" {
            AlertController.displayAlert(self, title: "Alert", message: "Department Required!")
        }
        else if uniName.text == "" {
            AlertController.displayAlert(self, title: "Alert", message: "University Name Required!")
        }
        else if gpa.text == "" {
            AlertController.displayAlert(self, title: "Alert", message: "GPA Required!")
        }
        else if sYearBtn.titleLabel?.text == "Select Start Year" {
            AlertController.displayAlert(self, title: "Alert", message: "Start Year Required!")
        }
        else if eYearBtn.titleLabel?.text == "Select End Year" {
            AlertController.displayAlert(self, title: "Alert", message: "End Year Required!")
        }
        else {
            fName = fullName.text!
            fAddress = fullAddress.text!
            cNumber = contactNumber.text!
            emailValue = email.text!
            passwordValue = password.text!
            pSummary = profSummary.text!
            uName = uniName.text!
            uGPA = gpa.text!
            department = (departmentBtn.titleLabel?.text)!
            degree = (degreeBtn.titleLabel?.text)!
            sYear = (sYearBtn.titleLabel?.text)!
            eYear = (eYearBtn.titleLabel?.text)!
            nextSectionView.isHidden = false
        }
    }
    
    @IBAction func degreePressed(_ sender: UIButton) {
        hideKeyboard()
        degreePicker.isHidden = false
    }
    
    @IBAction func departmentPressed(_ sender: UIButton) {
        hideKeyboard()
        departmentPicker.isHidden = false
    }
    
    @IBAction func startYearPressed(_ sender: UIButton) {
        hideKeyboard()
        yFlag = 0
        yearPicker.isHidden = false
    }
    
    @IBAction func endYearPressed(_ sender: UIButton) {
        hideKeyboard()
        if sYearBtn.titleLabel?.text == "Select Start Year" {
            AlertController.displayAlert(self, title: "Alert", message: "Please select start year first!")
        }
        else {
            yFlag = 1
            yearPicker.isHidden = false
        }
    }
    
    // Hiding keyboard.
    func hideKeyboard() {
        view.endEditing(false)
    }
    
    // Hiding picker.
    func hidePicker() {
        yearPicker.isHidden = true
        degreePicker.isHidden = true
        departmentPicker.isHidden = true
    }
    
    // Validating email.
    func emailValid(_ email: String) -> Bool {
        let regex = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", regex)
        return emailTest.evaluate(with: email)
    }
    
    // Validating contact number.
    func numberValid(_ number: String) -> Bool {
        let regex = "^\\d{3}\\d{3}\\d{4}$"
        let numberTest = NSPredicate(format: "SELF MATCHES %@", regex)
        return numberTest.evaluate(with: number)
    }
    
    // Modifying view so that keyboard does not hide textFields.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 6:
            moveTextField(textField: textField, moveDistance: -70, up: true)
        case 7:
            moveTextField(textField: textField, moveDistance: -80, up: true)
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 6:
            moveTextField(textField: textField, moveDistance: -70, up: false)
        case 7:
            moveTextField(textField: textField, moveDistance: -80, up: false)
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
    
    // Design for textFields and buttons.
    func designUI() {
        fullName.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        fullAddress.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        contactNumber.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        email.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        password.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        profSummary.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        uniName.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        gpa.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        fullName.layer.cornerRadius = 5.0
        fullName.layer.masksToBounds = true
        fullName.layer.borderWidth = 2.0
        fullAddress.layer.cornerRadius = 5.0
        fullAddress.layer.masksToBounds = true
        fullAddress.layer.borderWidth = 2.0
        contactNumber.layer.cornerRadius = 5.0
        contactNumber.layer.masksToBounds = true
        contactNumber.layer.borderWidth = 2.0
        email.layer.cornerRadius = 5.0
        email.layer.masksToBounds = true
        email.layer.borderWidth = 2.0
        password.layer.cornerRadius = 5.0
        password.layer.masksToBounds = true
        password.layer.borderWidth = 2.0
        profSummary.layer.cornerRadius = 5.0
        profSummary.layer.masksToBounds = true
        profSummary.layer.borderWidth = 2.0
        uniName.layer.cornerRadius = 5.0
        uniName.layer.masksToBounds = true
        uniName.layer.borderWidth = 2.0
        gpa.layer.cornerRadius = 5.0
        gpa.layer.masksToBounds = true
        gpa.layer.borderWidth = 2.0
        degreeBtn.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        degreeBtn.layer.borderWidth = 2
        degreeBtn.layer.cornerRadius = 5.0
        degreeBtn.layer.masksToBounds = true
        departmentBtn.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        departmentBtn.layer.borderWidth = 2
        departmentBtn.layer.cornerRadius = 5.0
        departmentBtn.layer.masksToBounds = true
        sYearBtn.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        sYearBtn.layer.borderWidth = 2
        sYearBtn.layer.cornerRadius = 5.0
        sYearBtn.layer.masksToBounds = true
        eYearBtn.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        eYearBtn.layer.borderWidth = 2
        eYearBtn.layer.cornerRadius = 5.0
        eYearBtn.layer.masksToBounds = true
        goLoginBtn.layer.borderColor = UIColor(red: 198/255, green: 0, blue: 0, alpha: 1.0).cgColor
        goLoginBtn.layer.borderWidth = 2
        goLoginBtn.layer.cornerRadius = 5.0
        goLoginBtn.layer.masksToBounds = true
        nextSecBtn.layer.borderColor = UIColor(red: 82/255, green: 170/255, blue: 0, alpha: 1.0).cgColor
        nextSecBtn.layer.borderWidth = 2
        nextSecBtn.layer.cornerRadius = 5.0
        nextSecBtn.layer.masksToBounds = true
        degreePicker.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        degreePicker.layer.borderWidth = 2
        degreePicker.layer.cornerRadius = 5.0
        degreePicker.layer.masksToBounds = true
        departmentPicker.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        departmentPicker.layer.borderWidth = 2
        departmentPicker.layer.cornerRadius = 5.0
        departmentPicker.layer.masksToBounds = true
        yearPicker.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        yearPicker.layer.borderWidth = 2
        yearPicker.layer.cornerRadius = 5.0
        yearPicker.layer.masksToBounds = true
    }
    
    // Hide picker when clicked on textFields.
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        hidePicker()
        return true
    }
    
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
    
}
