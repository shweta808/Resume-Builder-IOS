//
//  NextSection1.swift
//  Resume Builder
//
//  Created by MyBook on 12/16/17.
//  Copyright © 2017 Rutvik Desai. All rights reserved.
//

import UIKit

class NextSection1: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var projName: UITextField!
    @IBOutlet weak var projDesc: UITextField!
    @IBOutlet weak var projTech: UITextField!
    @IBOutlet weak var projOrg: UITextField!
    @IBOutlet weak var expCompanyName: UITextField!
    @IBOutlet weak var expCompanyAddress: UITextField!
    @IBOutlet weak var expPosition: UITextField!
    @IBOutlet weak var expResp: UITextField!
    @IBOutlet weak var moreProjView: UIView!
    @IBOutlet weak var moreExpView: UIView!
    @IBOutlet weak var nextSectionView: UIView!
    @IBOutlet weak var psYearBtn: UIButton!
    @IBOutlet weak var peYearBtn: UIButton!
    @IBOutlet weak var esYearBtn: UIButton!
    @IBOutlet weak var eeYearBtn: UIButton!
    @IBOutlet weak var yearPicker: UIPickerView!
    @IBOutlet weak var nextSecBtn: UIButton!
    @IBOutlet weak var addExp: UIButton!
    @IBOutlet weak var addProj: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    var pName = ""; var pDesc = ""; var pTech = ""; var pOrg = ""; var psYear = ""; var peYear = "";
    var eCName = ""; var eCAdd = ""; var ePosition = ""; var eRes = ""; var esYear = ""; var eeYear = "";
    var p1Name = ""; var p1Desc = ""; var p1Tech = ""; var p1Org = ""; var p2Name = ""; var p2Desc = ""; var p2Tech = ""; var p2Org = ""
    var p1sYear = ""; var p1eYear = ""; var p2sYear = ""; var p2eYear = ""
    var e1CName = ""; var e1CAdd = ""; var e1Position = ""; var e1Res = ""; var e2CName = ""; var e2CAdd = ""; var e2Position = ""; var e2Res = ""
    var e1sYear = ""; var e1eYear = ""; var e2sYear = ""; var e2eYear = ""
    var techSkills = ""; var pubName = ""; var pubDesc = ""; var pubLink = ""
    var fName = ""; var fAddress = ""; var cNumber = ""; var emailValue = ""; var passwordValue = ""; var pSummary = ""
    var uName = ""; var uGPA = ""; var department = ""; var degree = ""; var sYear = ""; var eYear = ""
    var yFlag = 0
    var pFlag = 0
    var eFlag = 0
    var psYearSelected: Int?
    var peYearSelected: Int?
    var esYearSelected: Int?
    var eeYearSelected: Int?
    var allData: Dictionary<String, Array<String>>?
    var allItems:Array<String>?
    var years:Array<String> = ["Select Year"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moreProjView.isHidden = true
        moreExpView.isHidden = true
        nextSectionView.isHidden = true
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
    
    // Function to add more projects.
    @IBAction func moreProjPressed(_ sender: UIButton) {
        hideKeyboard()
        hidePicker()
        if projName.text == "" {
            AlertController.displayAlert(self, title: "Alert", message: "Please fill Primary Project Name and Details to add more!")
        }
        else {
            moreProjView.isHidden = false
            moreExpView.isHidden = true
            nextSectionView.isHidden = true
        }
    }
    
    // Function to add more Experience.
    @IBAction func moreExpPressed(_ sender: UIButton) {
        hideKeyboard()
        hidePicker()
        if expCompanyName.text == "" {
            AlertController.displayAlert(self, title: "Alert", message: "Please fill Primary Company Name and Details to add more!")
        }
        else {
            moreProjView.isHidden = true
            moreExpView.isHidden = false
            nextSectionView.isHidden = true
        }
    }
    
    // Going to the next section.
    @IBAction func nextSectionPressed(_ sender: UIButton) {
        hideKeyboard()
        hidePicker()
        if projName.text == "", projDesc.text == "", projTech.text == "", projName.text == "" {pFlag = 1}
        else {
            if projName.text == "" {
                AlertController.displayAlert(self, title: "Alert", message: "Project Name is required!")
            }
            else {
                pName = projName.text!
                pDesc = projDesc.text!
                pTech = projTech.text!
                pOrg = projName.text!
                if psYearBtn.titleLabel?.text == "Select Start Year" {
                    psYear = ""
                }
                else {
                    psYear = (psYearBtn.titleLabel?.text)!
                }
                if peYearBtn.titleLabel?.text == "Select End Year"{
                    peYear = ""
                }
                else {
                    peYear = (peYearBtn.titleLabel?.text)!
                }
                pFlag = 1
            }
        }
        if expCompanyName.text == "", expCompanyAddress.text == "", expPosition.text == "", expResp.text == "" {eFlag = 1}
        else {
            if expCompanyName.text == "" {
                AlertController.displayAlert(self, title: "Alert", message: "Company Name is required!")
            }
            else {
                eCName = expCompanyName.text!
                eCAdd = expCompanyAddress.text!
                ePosition = expPosition.text!
                eRes = expResp.text!
                if esYearBtn.titleLabel?.text == "Select Start Year" {
                    esYear = ""
                }
                else {
                    esYear = (esYearBtn.titleLabel?.text)!
                }
                if eeYearBtn.titleLabel?.text == "Select End Year"{
                    eeYear = ""
                }
                else {
                    eeYear = (eeYearBtn.titleLabel?.text)!
                }
                eFlag = 1
            }
        }
        showHideNext()
    }
    
    // For storing data to the main parent file.
    func showHideNext() {
        if pFlag == 1, eFlag == 1 {
            let parent = self.parent as! SignUp
            fName = parent.fName
            fAddress = parent.fAddress
            cNumber = parent.cNumber
            emailValue = parent.emailValue
            passwordValue = parent.passwordValue
            pSummary = parent.pSummary
            uName = parent.uName
            uGPA = parent.uGPA
            department = parent.department
            degree = parent.degree
            sYear = parent.sYear
            eYear = parent.eYear
            moreProjView.isHidden = true
            moreExpView.isHidden = true
            nextSectionView.isHidden = false
        }
    }
    
    // Navigating back and clearing data.
    @IBAction func cancelPressed(_ sender: UIButton) {
        hideKeyboard()
        hidePicker()
        clearData()
        hideView()
    }
    
    // Hiding view when cancel pressed.
    func hideView() {
        let parent = self.parent as! SignUp
        parent.nextSectionView.isHidden = true
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
                psYearSelected = Int((years[row]))
                let temp = Int((peYearBtn.titleLabel?.text)!.suffix(4))
                if temp != nil {
                    if psYearSelected! > temp! {
                        AlertController.displayAlert(self, title: "Alert", message: "Start year can not be after End year!")
                        psYearBtn.setTitle("Select Start Year", for: .normal)
                    }
                    else {
                        psYearBtn.setTitle("Start Year:" + (years[row]), for: .normal)
                    }
                }
                else {
                    psYearBtn.setTitle("Start Year:" + (years[row]), for: .normal)
                }
            }
            else {
                psYearBtn.setTitle("Select Start Year", for: .normal)
            }
        case 1:
            if years[row] != "Select Year"{
                peYearSelected = Int((years[row]))
                if psYearSelected! > peYearSelected! {
                    AlertController.displayAlert(self, title: "Alert", message: "End year can not be before Start year!")
                    peYearBtn.setTitle("Select End Year", for: .normal)
                }
                else {
                    peYearBtn.setTitle("End Year: " + (years[row]), for: .normal)
                }
            }
            else {
                peYearBtn.setTitle("Select End Year", for: .normal)
            }
        case 2:
            if years[row] != "Select Year"{
                esYearSelected = Int((years[row]))
                let temp = Int((eeYearBtn.titleLabel?.text)!.suffix(4))
                if temp != nil {
                    if esYearSelected! > temp! {
                        AlertController.displayAlert(self, title: "Alert", message: "Start year can not be after End year!")
                        esYearBtn.setTitle("Select Start Year", for: .normal)
                    }
                    else {
                        esYearBtn.setTitle("Start Year:" + (years[row]), for: .normal)
                    }
                }
                else {
                    esYearBtn.setTitle("Start Year:" + (years[row]), for: .normal)
                }
            }
            else {
                esYearBtn.setTitle("Select Start Year", for: .normal)
            }
        case 3:
            if years[row] != "Select Year"{
                eeYearSelected = Int((years[row]))
                if esYearSelected! > eeYearSelected! {
                    AlertController.displayAlert(self, title: "Alert", message: "End year can not be before Start year!")
                    eeYearBtn.setTitle("Select End Year", for: .normal)
                }
                else {
                    eeYearBtn.setTitle("End Year: " + (years[row]), for: .normal)
                }
            }
            else {
                eeYearBtn.setTitle("Select End Year", for: .normal)
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

    @IBAction func psYearPressed(_ sender: UIButton) {
        hideKeyboard()
        yearPicker.isHidden = false
        yFlag = 0
    }
    
    @IBAction func peYearPressed(_ sender: UIButton) {
        if psYearBtn.titleLabel?.text == "Select Start Year" {
            AlertController.displayAlert(self, title: "Alert", message: "Please select start year first!")
        }
        else {
            yearPicker.isHidden = false
            yFlag = 1
        }
        hideKeyboard()
    }
    
    @IBAction func esYearPressed(_ sender: UIButton) {
        hideKeyboard()
        yFlag = 2
        yearPicker.isHidden = false
    }
    
    @IBAction func eeYearPressed(_ sender: UIButton) {
        if esYearBtn.titleLabel?.text == "Select Start Year" {
            AlertController.displayAlert(self, title: "Alert", message: "Please select start year first!")
        }
        else {
            yFlag = 3
            yearPicker.isHidden = false
        }
        hideKeyboard()
    }
    
    // Hide keyboard and picker when user taps on the screen.
    @IBAction func backgroupTap(_ sender: UIControl) {
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
        projName.text=""
        projDesc.text=""
        projTech.text=""
        projOrg.text=""
        expCompanyName.text=""
        expCompanyAddress.text=""
        expPosition.text=""
        expResp.text=""
        psYearBtn.setTitle("Select Start Year", for: .normal)
        peYearBtn.setTitle("Select End Year", for: .normal)
        esYearBtn.setTitle("Select Start Year", for: .normal)
        eeYearBtn.setTitle("Select End Year", for: .normal)
    }
    
    // Hiding subview to navigate back to the parent view.
    func hideSelfView() {
        moreProjView.isHidden = true
        moreExpView.isHidden = true
        nextSectionView.isHidden = true
        let parent = self.parent as! SignUp
        parent.nextSectionView.isHidden = true
    }
    
    // Modifying view so that keyboard does not hide textFields.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 4:
            moveTextField(textField: textField, moveDistance: -100, up: true)
        case 5:
            moveTextField(textField: textField, moveDistance: -120, up: true)
        case 6:
            moveTextField(textField: textField, moveDistance: -140, up: true)
        case 7:
            moveTextField(textField: textField, moveDistance: -160, up: true)
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 4:
            moveTextField(textField: textField, moveDistance: -100, up: false)
        case 5:
            moveTextField(textField: textField, moveDistance: -120, up: false)
        case 6:
            moveTextField(textField: textField, moveDistance: -140, up: false)
        case 7:
            moveTextField(textField: textField, moveDistance: -160, up: false)
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
        projName.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        projDesc.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        projTech.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        projOrg.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        expCompanyName.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        expCompanyAddress.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        expPosition.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        expResp.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        projName.layer.cornerRadius = 5.0
        projName.layer.masksToBounds = true
        projName.layer.borderWidth = 2.0
        projDesc.layer.cornerRadius = 5.0
        projDesc.layer.masksToBounds = true
        projDesc.layer.borderWidth = 2.0
        projTech.layer.cornerRadius = 5.0
        projTech.layer.masksToBounds = true
        projTech.layer.borderWidth = 2.0
        projOrg.layer.cornerRadius = 5.0
        projOrg.layer.masksToBounds = true
        projOrg.layer.borderWidth = 2.0
        expCompanyName.layer.cornerRadius = 5.0
        expCompanyName.layer.masksToBounds = true
        expCompanyName.layer.borderWidth = 2.0
        expCompanyAddress.layer.cornerRadius = 5.0
        expCompanyAddress.layer.masksToBounds = true
        expCompanyAddress.layer.borderWidth = 2.0
        expPosition.layer.cornerRadius = 5.0
        expPosition.layer.masksToBounds = true
        expPosition.layer.borderWidth = 2.0
        expResp.layer.cornerRadius = 5.0
        expResp.layer.masksToBounds = true
        expResp.layer.borderWidth = 2.0
        addExp.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        addExp.layer.borderWidth = 2
        addExp.layer.cornerRadius = 5.0
        addExp.layer.masksToBounds = true
        addProj.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        addProj.layer.borderWidth = 2
        addProj.layer.cornerRadius = 5.0
        addProj.layer.masksToBounds = true
        psYearBtn.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        psYearBtn.layer.borderWidth = 2
        psYearBtn.layer.cornerRadius = 5.0
        psYearBtn.layer.masksToBounds = true
        peYearBtn.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        peYearBtn.layer.borderWidth = 2
        peYearBtn.layer.cornerRadius = 5.0
        peYearBtn.layer.masksToBounds = true
        esYearBtn.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        esYearBtn.layer.borderWidth = 2
        esYearBtn.layer.cornerRadius = 5.0
        esYearBtn.layer.masksToBounds = true
        eeYearBtn.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        eeYearBtn.layer.borderWidth = 2
        eeYearBtn.layer.cornerRadius = 5.0
        eeYearBtn.layer.masksToBounds = true
        cancelBtn.layer.borderColor = UIColor(red: 198/255, green: 0, blue: 0, alpha: 1.0).cgColor
        cancelBtn.layer.borderWidth = 2
        cancelBtn.layer.cornerRadius = 5.0
        cancelBtn.layer.masksToBounds = true
        nextSecBtn.layer.borderColor = UIColor(red: 82/255, green: 170/255, blue: 0, alpha: 1.0).cgColor
        nextSecBtn.layer.borderWidth = 2
        nextSecBtn.layer.cornerRadius = 5.0
        nextSecBtn.layer.masksToBounds = true
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
