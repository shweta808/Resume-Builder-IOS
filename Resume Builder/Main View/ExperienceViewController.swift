//
//  ExperienceViewController.swift
//  Resume Builder
//
//  Created by Shweta Shahane on 12/17/17.
//  Copyright © 2017 Rutvik Desai. All rights reserved.
//

import UIKit
import Firebase

class ExperienceViewController: UIViewController, UITextFieldDelegate ,UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate {

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

    @IBOutlet weak var sYearButton: UIButton!
    @IBOutlet weak var eYearButton: UIButton!
    @IBOutlet weak var eYearButton3: UIButton!
    @IBOutlet weak var sYearButton3: UIButton!
    @IBOutlet weak var sYearButton2: UIButton!
    @IBOutlet weak var eYearButton2: UIButton!
    
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        cancelBtn.isHidden = true
        yearPicker.isHidden = true
        resp1.delegate = self
        resp2.delegate = self
        resp3.delegate = self
        sYearButton.isUserInteractionEnabled = false
        eYearButton.isUserInteractionEnabled = false
        sYearButton2.isUserInteractionEnabled = false
        eYearButton2.isUserInteractionEnabled = false
        sYearButton3.isUserInteractionEnabled = false
        eYearButton3.isUserInteractionEnabled = false

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
            years = years + tempY
        }
        fetchData()
        designUI()
        // Do any additional setup after loading the view.
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
                        if userObject?["Experience 1 Start Year"] as! String != "" {
                            self.setButtonTitle(value: userObject?["Experience 1 Start Year"] as! String, sender: self.sYearButton)
                        }
                        else {
                            self.sYearButton.setTitle("Start Year", for: .normal)
                        }
                        if userObject?["Experience 1 End Year"] as! String != "" {
                            self.setButtonTitle(value: userObject?["Experience 1 End Year"] as! String, sender: self.eYearButton)
                        }
                        else {
                            self.eYearButton.setTitle("End Year", for: .normal)
                        }
                        self.setText(value: userObject?["Experience 2 Company Name"] as! String, sender: self.companyName2)
                        self.setText(value: userObject?["Experience 2 Company Address"] as! String, sender: self.companyAddr2)
                        self.setText(value: userObject?["Experience 2 Position"] as! String, sender: self.companyPosition2)
                        self.setTextView(value: userObject?["Experience 2 Responsibilities"] as! String, sender: self.resp2)
                        if userObject?["Experience 2 Start Year"] as! String != "" {
                            self.setButtonTitle(value: userObject?["Experience 2 Start Year"] as! String, sender: self.sYearButton2)
                        }
                        else {
                            self.sYearButton2.setTitle("Start Year", for: .normal)
                        }
                        if userObject?["Experience 2 End Year"] as! String != "" {
                            self.setButtonTitle(value: userObject?["Experience 2 End Year"] as! String, sender: self.eYearButton2)
                        }
                        else {
                            self.eYearButton2.setTitle("End Year", for: .normal)
                        }
                        self.setText(value: userObject?["Experience 3 Company Name"] as! String, sender: self.companyName3)
                        self.setText(value: userObject?["Experience 3 Company Address"] as! String, sender: self.companyAddr3)
                        self.setText(value: userObject?["Experience 3 Position"] as! String, sender: self.companyPosition3)
                        self.setTextView(value: userObject?["Experience 3 Responsibilities"] as! String, sender: self.resp3)
                        if userObject?["Experience 3 Start Year"] as! String != "" {
                            self.setButtonTitle(value: userObject?["Experience 3 Start Year"] as! String, sender: self.sYearButton3)
                        }
                        else {
                            self.sYearButton3.setTitle("Start Year", for: .normal)
                        }
                        if userObject?["Experience 3 End Year"] as! String != "" {
                            self.setButtonTitle(value: userObject?["Experience 3 End Year"] as! String, sender: self.eYearButton3)
                        }
                        else {
                            self.eYearButton3.setTitle("End Year", for: .normal)
                        }
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
    
    // Hide picker when clicked on textFields.
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        hidePicker()
        return true
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

    public func setButtonTitle(value:String , sender : UIButton){
        sender.setTitle(value, for: UIControlState.normal)
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
                            if self.e1sYearSelected != nil {
                                self.ref.child(key).updateChildValues(["Experience 1 Start Year": "Start Year:\(String(describing: self.e1sYearSelected!))"])
                            }
                            if self.e1eYearSelected != nil {
                                self.ref.child(key).updateChildValues(["Experience 1 End Year": "End Year:\(String(describing: self.e1eYearSelected!))"])
                            }
                            self.ref.child(key).updateChildValues(["Experience 2 Company Address": eCompanyAddr2 as Any])
                            self.ref.child(key).updateChildValues(["Experience 2 Company Name": eCompanyName2 as Any])
                            self.ref.child(key).updateChildValues(["Experience 2 Position": eCompanyPosition2 as Any])
                            self.ref.child(key).updateChildValues(["Experience 2 Responsibilities": eResp2 as Any])
                            if self.e2sYearSelected != nil {
                                self.ref.child(key).updateChildValues(["Experience 2 Start Year": "Start Year:\(String(describing: self.e2sYearSelected!))"])
                            }
                            if self.e2eYearSelected != nil {
                                self.ref.child(key).updateChildValues(["Experience 2 End Year": "End Year:\(String(describing: self.e2eYearSelected!))"])
                            }
                            self.ref.child(key).updateChildValues(["Experience 3 Company Address": eCompanyAddr3 as Any])
                            self.ref.child(key).updateChildValues(["Experience 3 Company Name": eCompanyName3 as Any])
                            self.ref.child(key).updateChildValues(["Experience 3 Position": eCompanyPosition3 as Any])
                            self.ref.child(key).updateChildValues(["Experience 3 Responsibilities": eResp3 as Any])
                            if self.e3sYearSelected != nil {
                                self.ref.child(key).updateChildValues(["Experience 3 Start Year": "Start Year:\(String(describing: self.e3sYearSelected!))"])
                            }
                            if self.e3eYearSelected != nil {
                                self.ref.child(key).updateChildValues(["Experience 3 End Year": "End Year:\(String(describing: self.e3eYearSelected!))"])
                            }
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

            sYearButton.isUserInteractionEnabled = false
            eYearButton.isUserInteractionEnabled = false
            sYearButton2.isUserInteractionEnabled = false
            eYearButton2.isUserInteractionEnabled = false
            sYearButton3.isUserInteractionEnabled = false
            eYearButton3.isUserInteractionEnabled = false
            yearPicker.isHidden = true
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

            sYearButton.isUserInteractionEnabled = true
            eYearButton.isUserInteractionEnabled = true
            sYearButton2.isUserInteractionEnabled = true
            eYearButton2.isUserInteractionEnabled = true
            sYearButton3.isUserInteractionEnabled = true
            eYearButton3.isUserInteractionEnabled = true

            cancelBtn.isHidden = false
        }

    }

    @IBAction func cancelEdit(_ sender: UIButton) {
        self.editBtn.setTitle("Edit", for: UIControlState.normal)
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
        
        sYearButton.isUserInteractionEnabled = true
        eYearButton.isUserInteractionEnabled = true
        sYearButton2.isUserInteractionEnabled = true
        eYearButton2.isUserInteractionEnabled = true
        sYearButton3.isUserInteractionEnabled = true
        eYearButton3.isUserInteractionEnabled = true
        cancelBtn.isHidden = true
        fetchData()
    }

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
                let temp = Int((eYearButton.titleLabel?.text)!.suffix(4))
                if temp != nil {
                    if e1sYearSelected! > temp! {
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
        case 1:
            if years[row] != "Select Year"{
                e1eYearSelected = Int((years[row]))
                if e1sYearSelected! > e1eYearSelected! {
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
        case 2:
            if years[row] != "Select Year"{
                e2sYearSelected = Int((years[row]))
                let temp = Int((eYearButton2.titleLabel?.text)!.suffix(4))
                if temp != nil {
                    if e2sYearSelected! > temp! {
                        AlertController.displayAlert(self, title: "Alert", message: "Start year can not be after End year!")
                        sYearButton2.setTitle("Select Start Year", for: .normal)
                    }
                    else {
                        sYearButton2.setTitle("Start Year:" + (years[row]), for: .normal)
                    }
                }
                else {
                    sYearButton2.setTitle("Start Year:" + (years[row]), for: .normal)
                }
            }
            else {
                sYearButton2.setTitle("Select Start Year", for: .normal)
            }
        case 3:
            if years[row] != "Select Year"{
                e2eYearSelected = Int((years[row]))
                if e2sYearSelected! > e2eYearSelected! {
                    AlertController.displayAlert(self, title: "Alert", message: "End year can not be before Start year!")
                    eYearButton2.setTitle("Select End Year", for: .normal)
                }
                else {
                    eYearButton2.setTitle("End Year: " + (years[row]), for: .normal)
                }
            }
            else {
                eYearButton2.setTitle("Select End Year", for: .normal)
            }
        case 4:
            if years[row] != "Select Year"{
                e3sYearSelected = Int((years[row]))
                let temp = Int((eYearButton3.titleLabel?.text)!.suffix(4))
                if temp != nil {
                    if e3sYearSelected! > temp! {
                        AlertController.displayAlert(self, title: "Alert", message: "Start year can not be after End year!")
                        sYearButton3.setTitle("Select Start Year", for: .normal)
                    }
                    else {
                        sYearButton3.setTitle("Start Year:" + (years[row]), for: .normal)
                    }
                }
                else {
                    sYearButton3.setTitle("Start Year:" + (years[row]), for: .normal)
                }
            }
            else {
                sYearButton3.setTitle("Select Start Year", for: .normal)
            }
        case 5:
            if years[row] != "Select Year"{
                e3eYearSelected = Int((years[row]))
                if e3sYearSelected! > e3eYearSelected! {
                    AlertController.displayAlert(self, title: "Alert", message: "End year can not be before Start year!")
                    eYearButton3.setTitle("Select End Year", for: .normal)
                }
                else {
                    eYearButton3.setTitle("End Year: " + (years[row]), for: .normal)
                }
            }
            else {
                eYearButton3.setTitle("Select End Year", for: .normal)
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
        yearPicker.frame.origin.x = esYear1.frame.origin.x
        yearPicker.frame.origin.y = esYear1.frame.origin.y
        yFlag = 0
    }

    @IBAction func e1eYearPressed(_ sender: UIButton) {
        if sYearButton.titleLabel?.text == "Select Start Year" || sYearButton.titleLabel?.text == "Start Year"{
            AlertController.displayAlert(self, title: "Alert", message: "Please select start year first!")
        }
        else {
            yearPicker.isHidden = false
            yFlag = 1
            yearPicker.frame.origin.x = esYear1.frame.origin.x
            yearPicker.frame.origin.y = esYear1.frame.origin.y
        }
        hideKeyboard()
    }

    @IBAction func e2sYearPressed(_ sender: UIButton) {
        hideKeyboard()
        yFlag = 2
        yearPicker.frame.origin.x = esYear2.frame.origin.x
        yearPicker.frame.origin.y = esYear2.frame.origin.y
        yearPicker.isHidden = false
    }

    @IBAction func e2eYearPressed(_ sender: UIButton) {
        if sYearButton2.titleLabel?.text == "Select Start Year" || sYearButton2.titleLabel?.text == "Start Year" {
            AlertController.displayAlert(self, title: "Alert", message: "Please select start year first!")
        }
        else {
            yFlag = 3
            yearPicker.isHidden = false
            yearPicker.frame.origin.x = esYear2.frame.origin.x
            yearPicker.frame.origin.y = esYear2.frame.origin.y
        }
        hideKeyboard()
    }

    @IBAction func e3sYearPressed(_ sender: UIButton) {
        hideKeyboard()
        yFlag = 4
        yearPicker.isHidden = false
        yearPicker.frame.origin.x = esYear2.frame.origin.x
        yearPicker.frame.origin.y = esYear2.frame.origin.y
    }

    @IBAction func e3eYearPressed(_ sender: UIButton) {
        if sYearButton3.titleLabel?.text == "Select Start Year" || sYearButton3.titleLabel?.text == "Start Year" {
            AlertController.displayAlert(self, title: "Alert", message: "Please select start year first!")
        }
        else {
            yFlag = 5
            yearPicker.isHidden = false
            yearPicker.frame.origin.x = esYear2.frame.origin.x
            yearPicker.frame.origin.y = esYear2.frame.origin.y
        }
        hideKeyboard()
    }
    
    // Hiding picker.
    func hidePicker() {
        yearPicker.isHidden = true
    }
}
