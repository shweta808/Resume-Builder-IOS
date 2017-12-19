//
//  MoreExpSection.swift
//  Resume Builder
//
//  Created by MyBook on 12/16/17.
//  Copyright © 2017 Rutvik Desai. All rights reserved.
//

import UIKit

class MoreExpSection: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var e1CName: UITextField!
    @IBOutlet weak var e1CAdd: UITextField!
    @IBOutlet weak var e1Position: UITextField!
    @IBOutlet weak var e1Res: UITextField!
    @IBOutlet weak var e2CName: UITextField!
    @IBOutlet weak var e2CAdd: UITextField!
    @IBOutlet weak var e2Position: UITextField!
    @IBOutlet weak var e2Res: UITextField!
    @IBOutlet weak var e1sYearBtn: UIButton!
    @IBOutlet weak var e1eYearBtn: UIButton!
    @IBOutlet weak var e2sYearBtn: UIButton!
    @IBOutlet weak var e2eYearBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var yearPicker: UIPickerView!
    var yFlag = 0
    var e1sYearSelected: Int?
    var e1eYearSelected: Int?
    var e2sYearSelected: Int?
    var e2eYearSelected: Int?
    var allData: Dictionary<String, Array<String>>?
    var allItems:Array<String>?
    var years:Array<String> = ["Select Year"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designUI()
        let data = Bundle.main
        let dataList:String? = data.path(forResource: "DataList", ofType: "plist")
        if dataList != nil {
            allData = (NSDictionary.init(contentsOfFile: dataList!) as! Dictionary)
            allItems = allData?.keys.sorted()
            let tempY = (allData!["Year"]?.sorted())!
            years = years + tempY
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(_ sender: UIButton) {
        hideKeyboard()
        hidePicker()
        let parent = self.parent as! NextSection1
        if e1CName.text == "", e1CAdd.text == "", e1Position.text == "", e1Res.text == "" {}
        else {
            if e1CName.text == "" {
                AlertController.displayAlert(self, title: "Alert", message: "Company2 Name is required!")
            }
            else{
                parent.e1CName = e1CName.text!
                parent.e1CAdd = e1CAdd.text!
                parent.e1Position = e1Position.text!
                parent.e1Res = e1Res.text!
                if e1sYearBtn.titleLabel?.text == "Select Start Year" {
                    parent.e1sYear = ""
                }
                else {
                    parent.e1sYear = (e1sYearBtn.titleLabel?.text)!
                }
                if e1eYearBtn.titleLabel?.text == "Select End Year"{
                    parent.e1eYear = ""
                }
                else {
                    parent.e1eYear = (e1eYearBtn.titleLabel?.text)!
                }
            }
        }
        if e2CName.text == "", e2CAdd.text == "", e2Position.text == "", e2Res.text == "" {}
        else {
            if e2CName.text == "" {
                AlertController.displayAlert(self, title: "Alert", message: "Company3 Name is required!")
            }
            else {
                parent.e2CName = e2CName.text!
                parent.e2CAdd = e2CAdd.text!
                parent.e2Position = e2Position.text!
                parent.e2Res = e2Res.text!
                if e2sYearBtn.titleLabel?.text == "Select Start Year" {
                    parent.e2sYear = ""
                }
                else {
                    parent.e2sYear = (e2sYearBtn.titleLabel?.text)!
                }
                if e2eYearBtn.titleLabel?.text == "Select End Year"{
                    parent.e2eYear = ""
                }
                else {
                    parent.e2eYear = (e2eYearBtn.titleLabel?.text)!
                }
            }
        }
        hideView()
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        hideKeyboard()
        hidePicker()
        clearData()
        hideView()
    }
    
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
                e1sYearSelected = Int((years[row]))
                e1sYearBtn.setTitle("Start Year:" + (years[row]), for: .normal)
            }
            else {
                e1sYearBtn.setTitle("Select Start Year", for: .normal)
            }
        case 1:
            if years[row] != "Select Year"{
                e1eYearSelected = Int((years[row]))
                e1eYearBtn.setTitle("End Year:" + (years[row]), for: .normal)
            }
            else {
                e1eYearBtn.setTitle("Select End Year", for: .normal)
            }
        case 2:
            if years[row] != "Select Year"{
                e2sYearSelected = Int((years[row]))
                e2sYearBtn.setTitle("Start Year:" + (years[row]), for: .normal)
            }
            else {
                e2sYearBtn.setTitle("Select Start Year", for: .normal)
            }
        case 3:
            if years[row] != "Select Year"{
                e2eYearSelected = Int((years[row]))
                e2eYearBtn.setTitle("End Year:" + (years[row]), for: .normal)
            }
            else {
                e2eYearBtn.setTitle("Select End Year", for: .normal)
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
    
    @IBAction func e1sYearPressed(_ sender: UIButton) {
        hideKeyboard()
        yearPicker.isHidden = false
        yFlag = 0
    }
    @IBAction func e1eYearPressed(_ sender: UIButton) {
        hideKeyboard()
        yearPicker.isHidden = false
        yFlag = 1
    }
    @IBAction func e2sYearPressed(_ sender: UIButton) {
        hideKeyboard()
        yFlag = 2
        yearPicker.isHidden = false
    }
    @IBAction func e2eYearPressed(_ sender: UIButton) {
        hideKeyboard()
        yFlag = 3
        yearPicker.isHidden = false
    }
    
    func hideView() {
        let parent = self.parent as! NextSection1
        parent.moreExpView.isHidden = true
    }
    
    @IBAction func backgroundTap(_ sender: UIControl) {
        hideKeyboard()
        hidePicker()
    }
    
    func hideKeyboard() {
        view.endEditing(false)
    }
    
    func hidePicker() {
        yearPicker.isHidden = true
    }
    
    func clearData() {
        e1CName.text=""
        e1CAdd.text=""
        e1Position.text=""
        e1Res.text=""
        e2CName.text=""
        e2CAdd.text=""
        e2Position.text=""
        e2Res.text=""
        e1sYearBtn.setTitle("Select Start Year", for: .normal)
        e1eYearBtn.setTitle("Select End Year", for: .normal)
        e2sYearBtn.setTitle("Select Start Year", for: .normal)
        e2eYearBtn.setTitle("Select End Year", for: .normal)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 4:
            moveTextField(textField: textField, moveDistance: -50, up: true)
        case 5:
            moveTextField(textField: textField, moveDistance: -60, up: true)
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
        case 4:
            moveTextField(textField: textField, moveDistance: -50, up: false)
        case 5:
            moveTextField(textField: textField, moveDistance: -60, up: false)
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
    
    func designUI() {
        e1CName.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        e1CAdd.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        e1Position.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        e1Res.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        e2CName.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        e2CAdd.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        e2Position.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        e2Res.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        e1CName.layer.cornerRadius = 5.0
        e1CName.layer.masksToBounds = true
        e1CName.layer.borderWidth = 2.0
        e1CAdd.layer.cornerRadius = 5.0
        e1CAdd.layer.masksToBounds = true
        e1CAdd.layer.borderWidth = 2.0
        e1Position.layer.cornerRadius = 5.0
        e1Position.layer.masksToBounds = true
        e1Position.layer.borderWidth = 2.0
        e1Res.layer.cornerRadius = 5.0
        e1Res.layer.masksToBounds = true
        e1Res.layer.borderWidth = 2.0
        e2CName.layer.cornerRadius = 5.0
        e2CName.layer.masksToBounds = true
        e2CName.layer.borderWidth = 2.0
        e2CAdd.layer.cornerRadius = 5.0
        e2CAdd.layer.masksToBounds = true
        e2CAdd.layer.borderWidth = 2.0
        e2Position.layer.cornerRadius = 5.0
        e2Position.layer.masksToBounds = true
        e2Position.layer.borderWidth = 2.0
        e2Res.layer.cornerRadius = 5.0
        e2Res.layer.masksToBounds = true
        e2Res.layer.borderWidth = 2.0
        e1sYearBtn.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        e1sYearBtn.layer.borderWidth = 2
        e1sYearBtn.layer.cornerRadius = 5.0
        e1sYearBtn.layer.masksToBounds = true
        e1eYearBtn.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        e1eYearBtn.layer.borderWidth = 2
        e1eYearBtn.layer.cornerRadius = 5.0
        e1eYearBtn.layer.masksToBounds = true
        e2sYearBtn.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        e2sYearBtn.layer.borderWidth = 2
        e2sYearBtn.layer.cornerRadius = 5.0
        e2sYearBtn.layer.masksToBounds = true
        e2eYearBtn.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        e2eYearBtn.layer.borderWidth = 2
        e2eYearBtn.layer.cornerRadius = 5.0
        e2eYearBtn.layer.masksToBounds = true
        cancelBtn.layer.borderColor = UIColor(red: 198/255, green: 0, blue: 0, alpha: 1.0).cgColor
        cancelBtn.layer.borderWidth = 2
        cancelBtn.layer.cornerRadius = 5.0
        cancelBtn.layer.masksToBounds = true
        saveBtn.layer.borderColor = UIColor(red: 82/255, green: 170/255, blue: 0, alpha: 1.0).cgColor
        saveBtn.layer.borderWidth = 2
        saveBtn.layer.cornerRadius = 5.0
        saveBtn.layer.masksToBounds = true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        hidePicker()
        return true
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
