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
    
    @IBOutlet weak var fullName: UIView!
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
    var allData: Dictionary<String, Array<String>>?
    var allItems:Array<String>?
    var years:Array<String>?
    var deparments:Array<String>?
    var degrees:Array<String>?
    @IBOutlet weak var degreeBtn: UIButton!
    @IBOutlet weak var departmentBtn: UIButton!
    @IBOutlet weak var sYearBtn: UIButton!
    @IBOutlet weak var eYearBtn: UIButton!
    var yFlag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextSectionView.isHidden = true
        let data = Bundle.main
        let dataList:String? = data.path(forResource: "DataList", ofType: "plist")
        if dataList != nil {
            allData = (NSDictionary.init(contentsOfFile: dataList!) as! Dictionary)
            allItems = allData?.keys.sorted()
            years = allData!["Year"]?.sorted()
            deparments = allData!["Department"]?.sorted()
            degrees = allData!["Degree"]?.sorted()
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
        guard (years != nil) && deparments != nil && degrees != nil else {return 0}
        switch pickerView {
            case yearPicker: return years!.count
            case departmentPicker: return deparments!.count
            case degreePicker: return degrees!.count
            default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard (years != nil) && deparments != nil && degrees != nil else {return ""}
        switch pickerView {
        case yearPicker: return years![row]
        case departmentPicker: return deparments![row]
        case degreePicker: return degrees![row]
        default: return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard (years != nil) && deparments != nil && degrees != nil else {return}
        switch pickerView {
        case yearPicker:
            if yFlag == 0 {
                sYearBtn.setTitle(years?[row], for: .normal)
            }
            else {
                eYearBtn.setTitle(years?[row], for: .normal)
            }
            yearPicker.isHidden = true
        case departmentPicker:
            departmentBtn.setTitle(deparments?[row], for: .normal)
            departmentPicker.isHidden = true
        case degreePicker:
            degreeBtn.setTitle(degrees?[row], for: .normal)
            degreePicker.isHidden = true
        default:
            break
        }
    }
    @IBAction func backgroupTap(_ sender: UIControl) {
        hideKeyboard()
        hidePicker()
    }
    
    @IBAction func nextSectionPressed(_ sender: UIButton) {
        
        nextSectionView.isHidden = false
//        guard let email = email.text,
//        email != "",
//        let password = password.text,
//        password != ""
//        else {
//            AlertController.displayAlert(self, title: "Error", message: "Please fill all the fields!")
//            return
//        }
//        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
//
//            guard error == nil else{
//                AlertController.displayAlert(self, title: "Error", message: error!.localizedDescription)
//                return
//            }
//            guard let user = user else { return }
//            self.performSegue(withIdentifier: "signupSegue", sender: nil)
//        }
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
    
}
