//
//  MainView.swift
//  Resume Builder
//
//  Created by MyBook on 12/15/17.
//  Copyright © 2017 Rutvik Desai. All rights reserved.
//

import UIKit
import Firebase

class MainView: UIViewController {


    @IBOutlet weak var superView: UIView!
    var subViews:[UIView]!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var contactText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var emailBtn: UIButton!
    
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
                    let Name  = userObject?["Name"]
                    let Email = userObject?["Email"]
                    let Contact = userObject?["Contact"]
                    self.filename = userObject?["Email"] as? String
                    self.setProfile(Name:Name as! String ,Email:Email as! String,Contact:Contact as! String)
                    self.fetchImage()
                    //creating artist object with model and fetched values
                    //appending it to list
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
        //imageTask.resume()
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

    public func setProfile(Name:String , Email:String ,Contact:String){
        self.nameText.text = Name
        self.emailText.text = Email
        self.contactText.text = Contact
    }

}
