//
//  ViewController.swift
//  Resume Builder
//
//  Created by MyBook on 12/15/17.
//  Copyright © 2017 Rutvik Desai. All rights reserved.
//

import UIKit
import Firebase

class SignIn: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Login into the app.
    @IBAction func loginPressed(_ sender: UIButton) {
        activityIndicator.startAnimating()
        guard let email = email.text,
            email != "",
            let password = password.text,
            password != ""
            else {
                AlertController.displayAlert(self, title: "Error", message: "Enter Email/Password!")
                return
            }
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            guard error == nil else{
                AlertController.displayAlert(self, title: "Error", message: error!.localizedDescription)
                self.activityIndicator.stopAnimating()
                return
            }
            guard let user = user else { return }
            self.activityIndicator.stopAnimating()
            self.performSegue(withIdentifier: "signinSegue", sender: nil)
        }
    }
    
    // Design of the textFields and buttons.
    func designUI() {
        email.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        password.layer.borderColor = UIColor(red: 0.33, green: 0.54, blue: 0.70, alpha: 1.0).cgColor
        email.layer.cornerRadius = 5.0
        email.layer.masksToBounds = true
        email.layer.borderWidth = 2.0
        password.layer.cornerRadius = 5.0
        password.layer.masksToBounds = true
        password.layer.borderWidth = 2.0
        loginBtn.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        loginBtn.layer.borderWidth = 2
        loginBtn.layer.cornerRadius = 5.0
        loginBtn.layer.masksToBounds = true
        registerBtn.layer.borderColor = UIColor(red: 0, green: 63/255, blue: 173/255, alpha: 1.0).cgColor
        registerBtn.layer.borderWidth = 2
        registerBtn.layer.cornerRadius = 5.0
        registerBtn.layer.masksToBounds = true
    }
    
    @IBAction func backgroundTap(_ sender: UIControl) {
        hideKeyboard()
    }
    
    // Hiding keyboard.
    func hideKeyboard() {
        view.endEditing(false)
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

