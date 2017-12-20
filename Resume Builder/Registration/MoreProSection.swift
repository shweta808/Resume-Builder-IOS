//
//  MoreEduSection.swift
//  Resume Builder
//
//  Created by MyBook on 12/16/17.
//  Copyright © 2017 Rutvik Desai. All rights reserved.
//

import UIKit

class MoreProSection: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var p1Name: UITextField!
    @IBOutlet weak var p1Desc: UITextField!
    @IBOutlet weak var p1Tech: UITextField!
    @IBOutlet weak var p1Org: UITextField!
    @IBOutlet weak var p2Name: UITextField!
    @IBOutlet weak var p2Desc: UITextField!
    @IBOutlet weak var p2Tech: UITextField!
    @IBOutlet weak var p2Org: UITextField!
    @IBOutlet weak var p1sYearBtn: UIButton!
    @IBOutlet weak var p1eYearBtn: UIButton!
    @IBOutlet weak var p2sYearBtn: UIButton!
    @IBOutlet weak var p2eYearBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var yearPicker: UIPickerView!
    var yFlag = 0
    var p1sYearSelected: Int?
    var p1eYearSelected: Int?
    var p2sYearSelected: Int?
    var p2eYearSelected: Int?
    var allData: Dictionary<String, Array<String>>?
    var allItems:Array<String>?
    var years:Array<String> = ["Select Year"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designUI()
        // Getting data from info file.
        let data = Bundle.main
        let dataList:String? = data.path(forResource: "DataList", ofType: "plist")
        if dataList != nil {
            allData = (NSDictionary.init(contentsOfFile: dataList!) as! Dictionary)
            allItems = allData?.keys.sorted()
            let tempY = (allData!["Year"]?.sorted())!
            years = years + tempY
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Validation while saving data.
    @IBAction func save(_ sender: UIButton) {
        hideKeyboard()
        hidePicker()
        let parent = self.parent as! NextSection1
        if p1Name.text == "", p1Desc.text == "", p1Tech.text == "", p1Org.text == "" {}
        else {
            if p1Name.text == "" {
                AlertController.displayAlert(self, title: "Alert", message: "Project2 Name is required!")
            }
            else{
                parent.p1Name = p1Name.text!
                parent.p1Desc = p1Desc.text!
                parent.p1Tech = p1Tech.text!
                parent.p1Org = p1Org.text!
                if p1sYearBtn.titleLabel?.text == "Select Start Year" {
                    parent.p1sYear = ""
                }
                else {
                    parent.p1sYear = (p1sYearBtn.titleLabel?.text)!
                }
                if p1eYearBtn.titleLabel?.text == "Select End Year"{
                    parent.p1eYear = ""
                }
                else {
                    parent.p1eYear = (p1eYearBtn.titleLabel?.text)!
                }
            }
        }
        if p2Name.text == "", p2Desc.text == "", p2Tech.text == "", p2Org.text == "" {}
        else {
            if p2Name.text == "" {
                AlertController.displayAlert(self, title: "Alert", message: "Project3 Name is required!")
            }
            else {
                parent.p2Name = p2Name.text!
                parent.p2Desc = p2Desc.text!
                parent.p2Tech = p2Tech.text!
                parent.p2Org = p2Org.text!
                if p2sYearBtn.titleLabel?.text == "Select Start Year" {
                    parent.p2sYear = ""
                }
                else {
                    parent.p2sYear = (p2sYearBtn.titleLabel?.text)!
                }
                if p2eYearBtn.titleLabel?.text == "Select End Year"{
                    parent.p2eYear = ""
                }
                else {
                    parent.p2eYear = (p2eYearBtn.titleLabel?.text)!
                }
            }
        }
        hideView()
    }
    
    // Navigating back and clearing data.
    @IBAction func cancelPressed(_ sender: UIButton) {
        hideKeyboard()
        hidePicker()
        clearData()
        hideView()
    }
    
    // Setting up pickerView.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return years.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return years[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch yFlag {
        case 0:
            if years[row] != "Select Year"{
                p1sYearSelected = Int((years[row]))
                let temp = Int((p1eYearBtn.titleLabel?.text)!.suffix(4))
                if temp != nil {
                    if p1sYearSelected! > temp! {
                        AlertController.displayAlert(self, title: "Alert", message: "Start year can not be after End year!")
                        p1sYearBtn.setTitle("Select Start Year", for: .normal)
                    }
                    else {
                        p1sYearBtn.setTitle("Start Year:" + (years[row]), for: .normal)
                    }
                }
                else {
                    p1sYearBtn.setTitle("Start Year:" + (years[row]), for: .normal)
                }
            }
            else {
                p1sYearBtn.setTitle("Select Start Year", for: .normal)
            }
        case 1:
            if years[row] != "Select Year"{
                p1eYearSelected = Int((years[row]))
                if p1sYearSelected! > p1eYearSelected! {
                    AlertController.displayAlert(self, title: "Alert", message: "End year can not be before Start year!")
                    p1eYearBtn.setTitle("Select End Year", for: .normal)
                }
                else {
                    p1eYearBtn.setTitle("End Year: " + (years[row]), for: .normal)
                }
            }
            else {
                p1eYearBtn.setTitle("Select End Year", for: .normal)
            }
        case 2:
            if years[row] != "Select Year"{
                p2sYearSelected = Int((years[row]))
                let temp = Int((p2eYearBtn.titleLabel?.text)!.suffix(4))
                if temp != nil {
                    if p2sYearSelected! > temp! {
                        AlertController.displayAlert(self, title: "Alert", message: "Start year can not be after End year!")
                        p2sYearBtn.setTitle("Select Start Year", for: .normal)
                    }
                    else {
                        p2sYearBtn.setTitle("Start Year:" + (years[row]), for: .normal)
                    }
                }
                else {
                    p2sYearBtn.setTitle("Start Year:" + (years[row]), for: .normal)
                }
            }
            else {
                p2sYearBtn.setTitle("Select Start Year", for: .normal)
            }
        case 3:
            if years[row] != "Select Year"{
                p2eYearSelected = Int((years[row]))
                if p2sYearSelected! > p2eYearSelected! {
                    AlertController.displayAlert(self, title: "Alert", message: "End year can not be before Start year!")
                    p2eYearBtn.setTitle("Select End Year", for: .normal)
                }
                else {
                    p2eYearBtn.setTitle("End Year: " + (years[row]), for: .normal)
                }
            }
            else {
                p2eYearBtn.setTitle("Select End Year", for: .normal)
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

    // Hiding view when cancel pressed.
    func hideView() {
        let parent = self.parent as! NextSection1
        parent.moreProjView.isHidden = true
    }
    
    @IBAction func p1sYearPressed(_ sender: UIButton) {
        hideKeyboard()
        yearPicker.isHidden = false
        yFlag = 0
    }
    
    @IBAction func p1eYearPressed(_ sender: UIButton) {
        if p1sYearBtn.titleLabel?.text == "Select Start Year" {
            AlertController.displayAlert(self, title: "Alert", message: "Please select start year first!")
        }
        else {
            yearPicker.isHidden = false
            yFlag = 1
        }
        hideKeyboard()
    }
    
    @IBAction func p2sYearPressed(_ sender: UIButton) {
        hideKeyboard()
        yFlag = 2
        yearPicker.isHidden = false
    }
    
    @IBAction func p2eYearPressed(_ sender: UIButton) {
        if p2sYearBtn.titleLabel?.text == "Select Start Year" {
            AlertController.displayAlert(self, title: "Alert", message: "Please select start year first!")
        }
        else {
            yFlag = 3
            yearPicker.isHidden = false
        }
        hideKeyboard()
    }
    
    // Hide keyboard and picker when user taps on the screen.
    @IBAction func backgroundTap(_ sender: UIControl) {
        hideKeyboard()
        hidePicker()
    }
    
    // Hiding keyboard.
    func hideKeyboard() {
        view.endEditing(false)
    }
    
    // Hiding picker.
    func hidePicker() {
        yearPicker.isHidden = true
    }
    
    // Function to clear data.
    func clearData() {
        p1Name.text=""
        p1Desc.text=""
        p1Tech.text=""
        p1Org.text=""
        p2Name.text=""
        p2Desc.text=""
        p2Tech.text=""
        p2Org.text=""
        p1sYearBtn.setTitle("Select Start Year", for: .normal)
        p1eYearBtn.setTitle("Select End Year", for: .normal)
        p2sYearBtn.setTitle("Select Start Year", for: .normal)
        p2eYearBtn.setTitle("Select End Year", for: .normal)
    }
    
    // Modifying view so that keyboard does not hide textFields.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 4:
            moveTextField(textField: textField, moveDistance: -80, up: true)
        case 5:
            moveTextField(textField: textField, moveDistance: -90, up: true)
        case 6:
            moveTextField(textField: textField, moveDistance: -100, up: true)
        case 7:
            moveTextField(textField: textField, moveDistance: -110, up: true)
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 4:
            moveTextField(textField: textField, moveDistance: -80, up: false)
        case 5:
            moveTextField(textField: textField, moveDistance: -90, up: false)
        case 6:
            moveTextField(textField: textField, moveDistance: -100, up: false)
        case 7:
            moveTextField(textField: textField, moveDistance: -110, up: false)
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
        p1Name.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        p1Desc.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        p1Tech.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        p1Org.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        p2Name.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        p2Desc.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        p2Tech.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        p2Org.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        p1Name.layer.cornerRadius = 5.0
        p1Name.layer.masksToBounds = true
        p1Name.layer.borderWidth = 2.0
        p1Desc.layer.cornerRadius = 5.0
        p1Desc.layer.masksToBounds = true
        p1Desc.layer.borderWidth = 2.0
        p1Tech.layer.cornerRadius = 5.0
        p1Tech.layer.masksToBounds = true
        p1Tech.layer.borderWidth = 2.0
        p1Org.layer.cornerRadius = 5.0
        p1Org.layer.masksToBounds = true
        p1Org.layer.borderWidth = 2.0
        p2Name.layer.cornerRadius = 5.0
        p2Name.layer.masksToBounds = true
        p2Name.layer.borderWidth = 2.0
        p2Desc.layer.cornerRadius = 5.0
        p2Desc.layer.masksToBounds = true
        p2Desc.layer.borderWidth = 2.0
        p2Tech.layer.cornerRadius = 5.0
        p2Tech.layer.masksToBounds = true
        p2Tech.layer.borderWidth = 2.0
        p2Org.layer.cornerRadius = 5.0
        p2Org.layer.masksToBounds = true
        p2Org.layer.borderWidth = 2.0
        p1sYearBtn.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        p1sYearBtn.layer.borderWidth = 2
        p1sYearBtn.layer.cornerRadius = 5.0
        p1sYearBtn.layer.masksToBounds = true
        p1eYearBtn.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        p1eYearBtn.layer.borderWidth = 2
        p1eYearBtn.layer.cornerRadius = 5.0
        p1eYearBtn.layer.masksToBounds = true
        p2sYearBtn.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        p2sYearBtn.layer.borderWidth = 2
        p2sYearBtn.layer.cornerRadius = 5.0
        p2sYearBtn.layer.masksToBounds = true
        p2eYearBtn.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        p2eYearBtn.layer.borderWidth = 2
        p2eYearBtn.layer.cornerRadius = 5.0
        p2eYearBtn.layer.masksToBounds = true
        cancelBtn.layer.borderColor = UIColor(red: 198/255, green: 0, blue: 0, alpha: 1.0).cgColor
        cancelBtn.layer.borderWidth = 2
        cancelBtn.layer.cornerRadius = 5.0
        cancelBtn.layer.masksToBounds = true
        saveBtn.layer.borderColor = UIColor(red: 82/255, green: 170/255, blue: 0, alpha: 1.0).cgColor
        saveBtn.layer.borderWidth = 2
        saveBtn.layer.cornerRadius = 5.0
        saveBtn.layer.masksToBounds = true
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
