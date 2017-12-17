//
//  ViewController.swift
//  Resume Builder
//
//  Created by MyBook on 12/15/17.
//  Copyright © 2017 Rutvik Desai. All rights reserved.
//

import UIKit
import Firebase

class SignIn: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        guard let email = email.text,
            email != "",
            let password = password.text,
            password != ""
            else {
                AlertController.displayAlert(self, title: "Error", message: "Please fill both the fields!")
                return
            }
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            guard error == nil else{
                AlertController.displayAlert(self, title: "Error", message: error!.localizedDescription)
                return
            }
            guard let user = user else { return }
            self.performSegue(withIdentifier: "signinSegue", sender: nil)
        }
        
    }
    
}

