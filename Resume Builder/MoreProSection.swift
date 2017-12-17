//
//  MoreEduSection.swift
//  Resume Builder
//
//  Created by MyBook on 12/16/17.
//  Copyright © 2017 Rutvik Desai. All rights reserved.
//

import UIKit

class MoreProSection: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

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
    
    @IBAction func cancelPressed(_ sender: UIButton) {
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
                p1sYearSelected = Int((years[row]))
                p1sYearBtn.setTitle("Start Year:" + (years[row]), for: .normal)
            }
            else {
                p1sYearBtn.setTitle("Select Start Year", for: .normal)
            }
        case 1:
            if years[row] != "Select Year"{
                p1eYearSelected = Int((years[row]))
                p1eYearBtn.setTitle("End Year:" + (years[row]), for: .normal)
            }
            else {
                p1eYearBtn.setTitle("Select End Year", for: .normal)
            }
        case 2:
            if years[row] != "Select Year"{
                p2sYearSelected = Int((years[row]))
                p2sYearBtn.setTitle("Start Year:" + (years[row]), for: .normal)
            }
            else {
                p2sYearBtn.setTitle("Select Start Year", for: .normal)
            }
        case 3:
            if years[row] != "Select Year"{
                p2eYearSelected = Int((years[row]))
                p2eYearBtn.setTitle("End Year:" + (years[row]), for: .normal)
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
    
    func hideView() {
        let parent = self.parent as! NextSection1
        parent.moreProjView.isHidden = true
    }
    
    @IBAction func p1sYearPressed(_ sender: UIButton) {
        yearPicker.isHidden = false
        yFlag = 0
    }
    @IBAction func p1eYearPressed(_ sender: UIButton) {
        yearPicker.isHidden = false
        yFlag = 1
    }
    @IBAction func p2sYearPressed(_ sender: UIButton) {
        yFlag = 2
        yearPicker.isHidden = false
    }
    @IBAction func p2eYearPressed(_ sender: UIButton) {
        yFlag = 3
        yearPicker.isHidden = false
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

}
