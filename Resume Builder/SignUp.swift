//
//  SignUp.swift
//  Resume Builder
//
//  Created by MyBook on 12/15/17.
//  Copyright © 2017 Rutvik Desai. All rights reserved.
//

import UIKit
import Firebase
class SignUp: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
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
    var sYearSelected: Int?
    var eYearSelected: Int?
    var yFlag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextSectionView.isHidden = true
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
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
                    sYearBtn.setTitle("Start Year:" + (years[row]), for: .normal)
                }
                else {
                    sYearBtn.setTitle("Select Start Year", for: .normal)
                }
            }
            else {
                if years[row] != "Select Year"{
                    eYearSelected = Int((years[row]))
                    eYearBtn.setTitle("End Year: " + (years[row]), for: .normal)
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
    
    @IBAction func backgroupTap(_ sender: UIControl) {
        hideKeyboard()
        hidePicker()
    }
    
    @IBAction func nextSectionPressed(_ sender: UIButton) {
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
            nextSectionView.isHidden = false
        }
    }
    @IBAction func degreePressed(_ sender: UIButton) {
        degreePicker.isHidden = false
    }
    @IBAction func departmentPressed(_ sender: UIButton) {
        departmentPicker.isHidden = false
    }
    @IBAction func startYearPressed(_ sender: UIButton) {
        yFlag = 0
        yearPicker.isHidden = false
    }
    @IBAction func endYearPressed(_ sender: UIButton) {
        yFlag = 1
        yearPicker.isHidden = false
    }
    
    func hideKeyboard() {
        view.endEditing(false)
    }
    
    func hidePicker() {
        yearPicker.isHidden = true
        degreePicker.isHidden = true
        departmentPicker.isHidden = true
    }
    
    func emailValid(_ email: String) -> Bool {
        let regex = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", regex)
        return emailTest.evaluate(with: email)
    }
    
    func numberValid(_ number: String) -> Bool {
        let regex = "^\\d{3}\\d{3}\\d{4}$"
        let numberTest = NSPredicate(format: "SELF MATCHES %@", regex)
        return numberTest.evaluate(with: number)
    }
    
}
