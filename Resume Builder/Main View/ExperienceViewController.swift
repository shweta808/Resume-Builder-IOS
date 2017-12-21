//
//  ExperienceViewController.swift
//  Resume Builder
//
//  Created by Shweta Shahane on 12/17/17.
//  Copyright © 2017 Rutvik Desai. All rights reserved.
//

import UIKit
import Firebase

class ExperienceViewController: UIViewController, UITextFieldDelegate ,UIPickerViewDelegate, UIPickerViewDataSource{


    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var eeYear1: UIButton!
    @IBOutlet weak var esYear1: UIButton!
    @IBOutlet weak var eeYear2: UIButton!
    @IBOutlet weak var esYear2: UIButton!
    @IBOutlet weak var eeYear3: UIButton!
    @IBOutlet weak var esYear3: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var companyName1: UITextField!
    @IBOutlet weak var companyAddr1: UITextField!
    @IBOutlet weak var companyPosition1: UITextField!
    @IBOutlet weak var resp1: UITextView!
    @IBOutlet weak var resp2: UITextView!
    @IBOutlet weak var companyPosition2: UITextField!
    @IBOutlet weak var companyAddr2: UITextField!
    @IBOutlet weak var companyName2: UITextField!
    @IBOutlet weak var companyName3: UITextField!
    @IBOutlet weak var companyAddr3: UITextField!
    @IBOutlet weak var companyPosition3: UITextField!
    @IBOutlet weak var resp3: UITextView!

    @IBOutlet weak var yearPicker: UIDatePicker!

    var allData: Dictionary<String, Array<String>>?
    var allItems:Array<String>?
    var years:Array<String> = ["Select Year"]
    var deparments:Array<String> = ["Select Department"]
    var degrees:Array<String> = ["Select Degree"]

    var sYearSelected: Int?
    var eYearSelected: Int?
    var yFlag = 0


    @IBOutlet weak var sYearButton: UIButton!
    @IBOutlet weak var eYearButton: UIButton!

    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        cancelBtn.isHidden = true
        companyName1.isUserInteractionEnabled = false
        companyAddr1.isUserInteractionEnabled = false
        companyPosition1.isUserInteractionEnabled = false
        resp1.isUserInteractionEnabled = false

        companyName2.isUserInteractionEnabled = false
        companyAddr2.isUserInteractionEnabled = false
        companyPosition2.isUserInteractionEnabled = false
        resp2.isUserInteractionEnabled = false

        companyName3.isUserInteractionEnabled = false
        companyAddr3.isUserInteractionEnabled = false
        companyPosition3.isUserInteractionEnabled = false
        resp3.isUserInteractionEnabled = false

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

        fetchData()
        designUI()
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
                    self.setText(value: userObject?["Experience 1 Company Name"] as! String, sender: self.companyName1)
                    self.setText(value: userObject?["Experience 1 Company Address"] as! String, sender: self.companyAddr1)
                    self.setText(value: userObject?["Experience 1 Position"] as! String, sender: self.companyPosition1)
                    self.setTextView(value: userObject?["Experience 1 Responsibilities"] as! String, sender: self.resp1)

                    self.setText(value: userObject?["Experience 2 Company Name"] as! String, sender: self.companyName2)
                    self.setText(value: userObject?["Experience 2 Company Address"] as! String, sender: self.companyAddr2)
                    self.setText(value: userObject?["Experience 2 Position"] as! String, sender: self.companyPosition2)
                    self.setTextView(value: userObject?["Experience 2 Responsibilities"] as! String, sender: self.resp2)

                    self.setText(value: userObject?["Experience 3 Company Name"] as! String, sender: self.companyName3)
                    self.setText(value: userObject?["Experience 3 Company Address"] as! String, sender: self.companyAddr3)
                    self.setText(value: userObject?["Experience 3 Position"] as! String, sender: self.companyPosition3)
                    self.setTextView(value: userObject?["Experience 3 Responsibilities"] as! String, sender: self.resp3)
                    }
                }
            }
        })
    }
    
    func designUI() {
        companyName1.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        companyAddr1.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        companyPosition1.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        resp1.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        companyName2.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        companyAddr2.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        companyPosition2.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        resp2.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        companyName3.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        companyAddr3.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        companyPosition3.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        resp3.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        companyName1.layer.cornerRadius = 5.0
        companyName1.layer.masksToBounds = true
        companyName1.layer.borderWidth = 2.0
        companyAddr1.layer.cornerRadius = 5.0
        companyAddr1.layer.masksToBounds = true
        companyAddr1.layer.borderWidth = 2.0
        companyPosition1.layer.cornerRadius = 5.0
        companyPosition1.layer.masksToBounds = true
        companyPosition1.layer.borderWidth = 2.0
        resp1.layer.cornerRadius = 5.0
        resp1.layer.masksToBounds = true
        resp1.layer.borderWidth = 2.0
        companyName2.layer.cornerRadius = 5.0
        companyName2.layer.masksToBounds = true
        companyName2.layer.borderWidth = 2.0
        companyAddr2.layer.cornerRadius = 5.0
        companyAddr2.layer.masksToBounds = true
        companyAddr2.layer.borderWidth = 2.0
        companyPosition2.layer.cornerRadius = 5.0
        companyPosition2.layer.masksToBounds = true
        companyPosition2.layer.borderWidth = 2.0
        resp2.layer.cornerRadius = 5.0
        resp2.layer.masksToBounds = true
        resp2.layer.borderWidth = 2.0
        companyName3.layer.cornerRadius = 5.0
        companyName3.layer.masksToBounds = true
        companyName3.layer.borderWidth = 2.0
        companyAddr3.layer.cornerRadius = 5.0
        companyAddr3.layer.masksToBounds = true
        companyAddr3.layer.borderWidth = 2.0
        companyPosition3.layer.cornerRadius = 5.0
        companyPosition3.layer.masksToBounds = true
        companyPosition3.layer.borderWidth = 2.0
        resp3.layer.cornerRadius = 5.0
        resp3.layer.masksToBounds = true
        resp3.layer.borderWidth = 2.0
        editBtn.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        editBtn.layer.borderWidth = 2
        editBtn.layer.cornerRadius = 5.0
        editBtn.layer.masksToBounds = true
        esYear1.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        esYear1.layer.borderWidth = 2
        esYear1.layer.cornerRadius = 5.0
        esYear1.layer.masksToBounds = true
        eeYear1.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        eeYear1.layer.borderWidth = 2
        eeYear1.layer.cornerRadius = 5.0
        eeYear1.layer.masksToBounds = true
        esYear2.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        esYear2.layer.borderWidth = 2
        esYear2.layer.cornerRadius = 5.0
        esYear2.layer.masksToBounds = true
        eeYear2.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        eeYear2.layer.borderWidth = 2
        eeYear2.layer.cornerRadius = 5.0
        eeYear2.layer.masksToBounds = true
        esYear3.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        esYear3.layer.borderWidth = 2
        esYear3.layer.cornerRadius = 5.0
        esYear3.layer.masksToBounds = true
        eeYear3.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        eeYear3.layer.borderWidth = 2
        eeYear3.layer.cornerRadius = 5.0
        eeYear3.layer.masksToBounds = true
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


    //Edit and Save data

    @IBAction func editDetails(_ sender: UIButton) {
        if editBtn.currentTitle == "Save" {
            let eCompanyName1 = companyName1.text
            let eCompanyAddr1 = companyAddr1.text
            let eCompanyPosition1 = companyPosition1.text
            let eResp1 = resp1.text

            let eCompanyName2 = companyName2.text
            let eCompanyAddr2 = companyAddr2.text
            let eCompanyPosition2 = companyPosition2.text
            let eResp2 = resp2.text

            let eCompanyName3 = companyName3.text
            let eCompanyAddr3 = companyAddr3.text
            let eCompanyPosition3 = companyPosition3.text
            let eResp3 = resp3.text

            let user = Auth.auth().currentUser
            let current_user = user?.email

            ref.queryOrdered(byChild: "Email").queryEqual(toValue: current_user)
                .observe(.value, with: { snapshot in
                    if ( snapshot.value is NSNull ) {
                        print("Email not found")
                    } else {
                        for child in snapshot.children {
                            let key = (child as AnyObject).key as String
                            self.ref.child(key).updateChildValues(["Experience 1 Company Address": eCompanyAddr1 as Any])
                            self.ref.child(key).updateChildValues(["Experience 1 Company Name": eCompanyName1 as Any])
                            self.ref.child(key).updateChildValues(["Experience 1 Position": eCompanyPosition1 as Any])
                            self.ref.child(key).updateChildValues(["Experience 1 Responsibilities": eResp1 as Any])

                            self.ref.child(key).updateChildValues(["Experience 2 Company Address": eCompanyAddr2 as Any])
                            self.ref.child(key).updateChildValues(["Experience 2 Company Name": eCompanyName2 as Any])
                            self.ref.child(key).updateChildValues(["Experience 2 Position": eCompanyPosition2 as Any])
                            self.ref.child(key).updateChildValues(["Experience 2 Responsibilities": eResp2 as Any])

                            self.ref.child(key).updateChildValues(["Experience 3 Company Address": eCompanyAddr3 as Any])
                            self.ref.child(key).updateChildValues(["Experience 3 Company Name": eCompanyName3 as Any])
                            self.ref.child(key).updateChildValues(["Experience 3 Position": eCompanyPosition3 as Any])
                            self.ref.child(key).updateChildValues(["Experience 3 Responsibilities": eResp3 as Any])
                        }
                    }
                })

            self.editBtn.setTitle("Edit", for: UIControlState.normal)
            companyName1.isUserInteractionEnabled = false
            companyAddr1.isUserInteractionEnabled = false
            companyPosition1.isUserInteractionEnabled = false
            resp1.isUserInteractionEnabled = false

            companyName2.isUserInteractionEnabled = false
            companyAddr2.isUserInteractionEnabled = false
            companyPosition2.isUserInteractionEnabled = false
            resp2.isUserInteractionEnabled = false

            companyName3.isUserInteractionEnabled = false
            companyAddr3.isUserInteractionEnabled = false
            companyPosition3.isUserInteractionEnabled = false
            resp3.isUserInteractionEnabled = false

             cancelBtn.isHidden = true
        }
        else{
            self.editBtn.setTitle("Save", for: UIControlState.normal)
            companyName1.isUserInteractionEnabled = true
            companyAddr1.isUserInteractionEnabled = true
            companyPosition1.isUserInteractionEnabled = true
            resp1.isUserInteractionEnabled = true

            companyName2.isUserInteractionEnabled = true
            companyAddr2.isUserInteractionEnabled = true
            companyPosition2.isUserInteractionEnabled = true
            resp2.isUserInteractionEnabled = true

            companyName3.isUserInteractionEnabled = true
            companyAddr3.isUserInteractionEnabled = true
            companyPosition3.isUserInteractionEnabled = true
            resp3.isUserInteractionEnabled = true

            cancelBtn.isHidden = false
        }

    }

    @IBAction func cancelEdit(_ sender: UIButton) {
        fetchData()
    }

    //Date Picker implementation

    // Setting up pickerView.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case yearPicker: return years.count
        default: return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case yearPicker: return years[row]
        default: return ""
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case yearPicker:
            if yFlag == 0 {
                if years[row] != "Select Year"{
                    sYearSelected = Int((years[row]))
                    let temp = Int((eYearButton.titleLabel?.text)!.suffix(4))
                    if temp != nil {
                        if sYearSelected! > temp! {
                            AlertController.displayAlert(self, title: "Alert", message: "Start year can not be after End year!")
                            sYearButton.setTitle("Select Start Year", for: .normal)
                        }
                        else {
                            sYearButton.setTitle("Start Year:" + (years[row]), for: .normal)
                        }
                    }
                    else {
                        sYearButton.setTitle("Start Year:" + (years[row]), for: .normal)
                    }
                }
                else {
                    sYearButton.setTitle("Select Start Year", for: .normal)
                }
            }
            else {
                if years[row] != "Select Year"{
                    eYearSelected = Int((years[row]))
                    if sYearSelected! > eYearSelected! {
                        AlertController.displayAlert(self, title: "Alert", message: "End year can not be before Start year!")
                        eYearButton.setTitle("Select End Year", for: .normal)
                    }
                    else {
                        eYearButton.setTitle("End Year: " + (years[row]), for: .normal)
                    }
                }
                else {
                    eYearButton.setTitle("Select End Year", for: .normal)
                }
            }
            yearPicker.isHidden = true
        default:
            break
        }
        //yearPicker.selectRow(0, inComponent: 0, animated: true)
    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var data: String = ""
        var title: NSAttributedString?
        switch pickerView {
        case yearPicker:
            data = years[row]
        default:
            break
        }
        title = NSAttributedString(string: data, attributes: [NSAttributedStringKey.foregroundColor:UIColor.white])
        return title
    }
    // pickerView setup end.
}
