//
//  nextSection2.swift
//  Resume Builder
//
//  Created by MyBook on 12/16/17.
//  Copyright © 2017 Rutvik Desai. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class NextSection2: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var techSkills: UITextField!
    @IBOutlet weak var pubName: UITextField!
    @IBOutlet weak var pubDesc: UITextField!
    @IBOutlet weak var pubLink: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var setProfBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designUI()
        activityIndicator.stopAnimating()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        imageView.contentMode = .scaleToFill
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func profilPicPressed(_ sender: UIButton) {
        hideKeyboard()
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIButton) {
        hideKeyboard()
        let parent = self.parent as! NextSection1
        if pubName.text == "", pubDesc.text == "", pubLink.text == "", techSkills.text == "" {}
        else {
            if techSkills.text == "" {
                AlertController.displayAlert(self, title: "Alert", message: "Technical Skills are required!")
            }
            else if pubName.text == "" {
                AlertController.displayAlert(self, title: "Alert", message: "Publication Name is required!")
            }
            else{
                parent.techSkills = techSkills.text!
                parent.pubName = pubName.text!
                parent.pubDesc = pubDesc.text!
                parent.pubLink = pubLink.text!
                saveToFirebase()
            }
        }
    }
    
    func saveToFirebase() {
        let parent = self.parent as! NextSection1
        Auth.auth().createUser(withEmail: parent.emailValue, password: parent.passwordValue) { (user, error) in
            guard error == nil else{
                let alert = UIAlertController(title:"Error", message: error!.localizedDescription, preferredStyle: .alert)
                let ok = UIAlertAction(title: "Edit Username/Password!", style: .default) {
                    (result : UIAlertAction) -> Void in
                     let parent = self.parent as! NextSection1
                    parent.hideSelfView()
                }
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                return
            }
            self.saveData()
            guard let user = user else { return }
        }
    }
    
    func saveData() {
        activityIndicator.startAnimating()
        let parent = self.parent as! NextSection1
        let data = ["Name": parent.fName,
                    "Address":parent.fAddress,
                    "Contact":parent.cNumber,
                    "Email": parent.emailValue,
                    "Professional Summary":parent.pSummary,
                    "Education Degree":parent.degree,
                    "Education Department": parent.department,
                    "University Name":parent.uName,
                    "GPA":parent.uGPA,
                    "Education Start Year": parent.sYear,
                    "Education End Year":parent.eYear,
                    "Project 1 Name":parent.pName,
                    "Project 1 Description": parent.pDesc,
                    "Project 1 Technologies":parent.pTech,
                    "Project 1 Organization":parent.pOrg,
                    "Project 1 Start Year":parent.psYear,
                    "Project 1 End Year":parent.peYear,
                    "Project 2 Name":parent.p1Name,
                    "Project 2 Description": parent.p1Desc,
                    "Project 2 Technologies":parent.p1Tech,
                    "Project 2 Organization":parent.p1Org,
                    "Project 2 Start Year":parent.p1sYear,
                    "Project 2 End Year":parent.p1eYear,
                    "Project 3 Name":parent.p2Name,
                    "Project 3 Description": parent.p2Desc,
                    "Project 3 Technologies":parent.p2Tech,
                    "Project 3 Organization":parent.p2Org,
                    "Project 3 Start Year":parent.p2sYear,
                    "Project 3 End Year":parent.p2eYear,
                    "Experience 1 Company Name":parent.eCName,
                    "Experience 1 Company Address": parent.eCAdd,
                    "Experience 1 Position":parent.ePosition,
                    "Experience 1 Responsibilities":parent.eRes,
                    "Experience 1 Start Year":parent.esYear,
                    "Experience 1 End Year":parent.eeYear,
                    "Experience 2 Company Name":parent.e1CName,
                    "Experience 2 Company Address": parent.e1CAdd,
                    "Experience 2 Position":parent.e1Position,
                    "Experience 2 Responsibilities":parent.e1Res,
                    "Experience 2 Start Year":parent.e1sYear,
                    "Experience 2 End Year":parent.e1eYear,
                    "Experience 3 Company Name":parent.e2CName,
                    "Experience 3 Company Address": parent.e2CAdd,
                    "Experience 3 Position":parent.e2Position,
                    "Experience 3 Responsibilities":parent.e2Res,
                    "Experience 3 Start Year":parent.e2sYear,
                    "Experience 3 End Year":parent.e2eYear,
                    "Technical Skills":parent.techSkills,
                    "Publication Name": parent.pubName,
                    "Publication Description":parent.pubDesc,
                    "Publication Link":parent.pubLink] as [String : Any]
        DatabaseService.shared.resumeData.childByAutoId().setValue(data)
        uploadImage()
    }
    
    func uploadImage() {
        let parent = self.parent as! NextSection1
        let fileName = parent.emailValue
        guard let image = imageView.image else {return}
        guard let imageData = UIImageJPEGRepresentation(image, 1) else { return }
        let uploadImage = DatabaseService.shared.resumeImages.child(fileName+".jpg")
        let uploadTask = uploadImage.putData(imageData, metadata: nil) { (metadata, error) in
            self.activityIndicator.stopAnimating()
            self.performSegue(withIdentifier: "signupSegue", sender: nil)
        }
        uploadTask.observe(.progress) { (snapshot) in
            print(snapshot.progress ?? "No progress")
        }
        uploadTask.resume()
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        hideKeyboard()
        clearData()
        hideView()
    }
    
    func hideView() {
        let parent = self.parent as! NextSection1
        parent.nextSectionView.isHidden = true
    }
    
    func clearData() {
        techSkills.text=""
        pubName.text=""
        pubDesc.text=""
        pubLink.text=""
        imageView.image = nil
    }
    @IBAction func backgroundTap(_ sender: UIControl) {
        hideKeyboard()
    }
    
    func hideKeyboard() {
        view.endEditing(false)
    }

    func designUI() {
        techSkills.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        pubName.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        pubDesc.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        pubLink.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        techSkills.layer.cornerRadius = 5.0
        techSkills.layer.masksToBounds = true
        techSkills.layer.borderWidth = 2.0
        pubName.layer.cornerRadius = 5.0
        pubName.layer.masksToBounds = true
        pubName.layer.borderWidth = 2.0
        pubDesc.layer.cornerRadius = 5.0
        pubDesc.layer.masksToBounds = true
        pubDesc.layer.borderWidth = 2.0
        pubLink.layer.cornerRadius = 5.0
        pubLink.layer.masksToBounds = true
        pubLink.layer.borderWidth = 2.0
        setProfBtn.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        setProfBtn.layer.borderWidth = 2
        setProfBtn.layer.cornerRadius = 5.0
        setProfBtn.layer.masksToBounds = true
        cancelBtn.layer.borderColor = UIColor(red: 198/255, green: 0, blue: 0, alpha: 1.0).cgColor
        cancelBtn.layer.borderWidth = 2
        cancelBtn.layer.cornerRadius = 5.0
        cancelBtn.layer.masksToBounds = true
        signupBtn.layer.borderColor = UIColor(red: 82/255, green: 170/255, blue: 0, alpha: 1.0).cgColor
        signupBtn.layer.borderWidth = 2
        signupBtn.layer.cornerRadius = 5.0
        signupBtn.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        imageView.layer.borderWidth = 2
        imageView.layer.cornerRadius = self.imageView.frame.size.width / 2;
        imageView.layer.masksToBounds = true
        
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
