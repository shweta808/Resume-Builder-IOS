//
//  MainView.swift
//  Resume Builder
//
//  Created by MyBook on 12/15/17.
//  Copyright © 2017 Rutvik Desai. All rights reserved.
//

import UIKit
import Firebase
import MessageUI

class MainView: UIViewController , MFMailComposeViewControllerDelegate {


    var subViews:[UIView]!

    @IBOutlet weak var superView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var contactText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var emailBtn: UIButton!

    var html: String?
    var ref: DatabaseReference!
    var filename: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        nameText.isUserInteractionEnabled = false
        emailText.isUserInteractionEnabled = false
        contactText.isUserInteractionEnabled = false
        
        subViews = [UIView]()
        subViews.append(ProfileViewController().view)
        subViews.append(ExperienceViewController().view)
        subViews.append(ProjectsViewController().view)
        subViews.append(EducationViewController().view)

        for v in subViews {
           superView.addSubview(v)
        }
        superView.bringSubview(toFront: subViews[0])
        designUI()
        convertDatatoHtml()
        //Fetch name, email-id and position from database
        fetchData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func logoutPressed(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "signoutSegue", sender: nil)
        }
        catch{
            print("Error")
        }
    }

    @IBAction func switchViews(_ sender: UISegmentedControl) {
        self.superView.bringSubview(toFront: subViews[sender.selectedSegmentIndex])
    }

    public func fetchData() {
        let user = Auth.auth().currentUser
        let current_user = user?.email
        activityIndicator.startAnimating()
        ref = DatabaseService.shared.resumeData
        //ref = Database.database().reference().child("Resume Data")
        //observing the data changes
        ref.observe(DataEventType.value, with: { (snapshot) in
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                //iterating through all the values
                for user in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let userObject = user.value as? [String: AnyObject]
                    if userObject?["Email"] as? String == current_user {
                        let Name  = userObject?["Name"]
                        let Email = userObject?["Email"]
                        let Contact = userObject?["Contact"]
                        self.filename = userObject?["Email"] as? String
                        self.setProfile(Name:Name as! String ,Email:Email as! String,Contact:Contact as! String)
                        self.fetchImage()
                    }
                }
            }
        })
    }
    
    func fetchImage() {
        let refImage = DatabaseService.shared.resumeImages.child(filename!+".jpg")
        _ = refImage.getData(maxSize: 1024 * 1024 * 12) { (data, error) in
            if let data = data {
                let image = UIImage(data: data)
                self.imageView.image = image
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func designUI() {
        nameText.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        emailText.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        contactText.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        nameText.layer.cornerRadius = 5.0
        nameText.layer.masksToBounds = true
        nameText.layer.borderWidth = 2.0
        emailText.layer.cornerRadius = 5.0
        emailText.layer.masksToBounds = true
        emailText.layer.borderWidth = 2.0
        contactText.layer.cornerRadius = 5.0
        contactText.layer.masksToBounds = true
        contactText.layer.borderWidth = 2.0
        logoutBtn.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        logoutBtn.layer.borderWidth = 2
        logoutBtn.layer.cornerRadius = 5.0
        logoutBtn.layer.masksToBounds = true
        emailBtn.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        emailBtn.layer.borderWidth = 2
        emailBtn.layer.cornerRadius = 5.0
        emailBtn.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        imageView.layer.borderWidth = 2
        imageView.layer.cornerRadius = self.imageView.frame.size.width / 2;
        imageView.layer.masksToBounds = true
        segmentedControl.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        segmentedControl.layer.borderWidth = 2
        segmentedControl.layer.cornerRadius = 5.0
        segmentedControl.layer.masksToBounds = true
        let textAttributeNormal = [NSAttributedStringKey.foregroundColor: UIColor.black]
        let textAttributeSelected = [NSAttributedStringKey.foregroundColor: UIColor.white]
        segmentedControl.setTitleTextAttributes(textAttributeNormal, for: .normal)
        segmentedControl.setTitleTextAttributes(textAttributeSelected, for: .selected)
    }
    @IBAction func backgroundTap(_ sender: UIControl) {
        hideKeyboard()
    }
    
    func hideKeyboard() {
        view.endEditing(false)
    }
    
    public func setProfile(Name:String , Email:String ,Contact:String){
        self.nameText.text = Name
        self.emailText.text = Email
        self.contactText.text = Contact
    }

    public func convertDatatoHtml(){

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
                        self.html = """
                        <html>
                        <head>
                        <title>Resume</title>
                        </head>
                        <body>
                        <h3><center>\(userObject?["Name"] as! String)</center></h3>
                        <p><center>\(userObject?["Address"] as! String)|\(userObject?["Contact"] as! String)</center></p>
                        <p><h3><u>Education</u></h3></p>
                        <p><b>\(userObject?["Education Degree"] as! String):</b>\(userObject?["Education Department"] as! String),\(userObject?["University Name"] as! String),\(userObject?["GPA"] as! String)
                        <b>\(userObject?["Education Start Year"] as! String)-\(userObject?["Education End Year"] as! String)</b></p>
                        <p><h3><u>Technical Skills</u></h3></p>
                        <p>\(userObject?["Technical Skills"] as! String)</p>
                        <p><h3><u>Experience</u></h3></p>
                        <p><u><b>\(userObject?["Experience 1 Company Name"] as! String),\(userObject?["Experience 1 Company Address"] as! String)</b></u>
                        <u><b>\(userObject?["Experience 1 Start Year"] as! String)-\(userObject?["Experience 1 End Year"] as! String)</b></u></p>
                        <p><b>\(userObject?["Experience 1 Position"] as! String)</b></p>
                        <p>\(userObject?["Experience 1 Responsibilities"] as! String)</p>

                        <p><u><b>\(userObject?["Experience 2 Company Name"] as! String),\(userObject?["Experience 2 Company Address"] as! String)</b></u>
                        <u><b>\(userObject?["Experience 2 Start Year"] as! String)-\(userObject?["Experience 2 End Year"] as! String)</b></u></p>
                        <p><b>\(userObject?["Experience 2 Position"] as! String)</b></p>
                        <p>\(userObject?["Experience 2 Responsibilities"] as! String)</p>

                        <p><u><b>\(userObject?["Experience 3 Company Name"] as! String),\(userObject?["Experience 3 Company Address"] as! String)</b></u>
                        <u><b>\(userObject?["Experience 3 Start Year"] as! String)-\(userObject?["Experience 3 End Year"] as! String)</b></u></p>
                        <p><b>\(userObject?["Experience 3 Position"] as! String)</b></p>
                        <p>\(userObject?["Experience 3 Responsibilities"] as! String)</p>
                        <p><h3><u>Academic Projects</u></h3></p>
                        <p><u><b>\(userObject?["Project 1 Organization"] as! String)</b></u>
                        <u><b>\(userObject?["Project 1 Start Year"] as! String)-\(userObject?["Project 1 End Year"] as! String)</b></u></p>
                        <p><b>\(userObject?["Project 1 Name"] as! String)</b></p>
                        <ul><li>\(userObject?["Project 1 Description"] as! String)</li>
                        <li>\(userObject?["Project 1 Technologies"] as! String)</li>
                        </ul>

                        <p><u><b>\(userObject?["Project 2 Organization"] as! String)</b></u>
                        <u><b>\(userObject?["Project 2 Start Year"] as! String)-\(userObject?["Project 2 End Year"] as! String)</b></u></p>
                        <p><b>\(userObject?["Project 2 Name"] as! String)</b></p>
                        <ul><li>\(userObject?["Project 2 Description"] as! String)</li>
                        <li>\(userObject?["Project 2 Technologies"] as! String)</li>
                        </ul>

                        <p><u><b>\(userObject?["Project 3 Organization"] as! String)</b></u>
                        <u><b>\(userObject?["Project 3 Start Year"] as! String)-\(userObject?["Project 3 End Year"] as! String)</b></u></p>
                        <p><b>\(userObject?["Project 3 Name"] as! String)</b></p>
                        <ul><li>\(userObject?["Project 3 Description"] as! String)</li>
                        <li>\(userObject?["Project 3 Technologies"] as! String)</li>
                        </ul>
                        </body>
                        </html>
"""
                    }
                }
            }
        })
    }

    public func createPDF() {
        print(html!)
        let fmt = UIMarkupTextPrintFormatter(markupText: html!)
        let render = UIPrintPageRenderer()
        render.addPrintFormatter(fmt, startingAtPageAt: 0)

        // 3. Assign paperRect and printableRect

        let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4, 72 dpi
        //let printable = CGRect.insetBy(page)

        render.setValue(page, forKey: "paperRect")
        render.setValue(page, forKey: "printableRect")

        // 4. Create PDF context and draw

        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, CGRect(x: 0, y: 0, width: 0, height: 0), nil)

        for i in 1...render.numberOfPages {
            UIGraphicsBeginPDFPage();
            let bounds = UIGraphicsGetPDFContextBounds()
            render.drawPage(at: i - 1, in: bounds)
        }

        UIGraphicsEndPDFContext();

        // 5. Save PDF file

        // let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let filemgr = FileManager.default

        let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)

        let docsDir = dirPaths[0].path
        print(docsDir)
        pdfData.write(toFile: "\(docsDir)/Resume.pdf", atomically: true)
    }

    @IBAction func sendEmail (_ sender: UIButton) {
        createPDF()
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            AlertController.displayAlert(self, title: "Error", message: "E-mail not sent!")
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        //Check to see the device can send email.
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self

            //Set to recipients
            mailComposer.setToRecipients([""])

            //Set the subject
            mailComposer.setSubject("Resume")

            //set mail body
            mailComposer.setMessageBody("Hi,\n PFA Resume.", isHTML: true)
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                if let fileData = NSData(contentsOfFile: "\(documentsPath)/Resume.pdf")
                {
                    mailComposer.addAttachmentData(fileData as Data, mimeType: "application/pdf", fileName: "Resume.pdf")
                }

            //this will compose and present mail to user
            return mailComposer
    }

    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }


}
