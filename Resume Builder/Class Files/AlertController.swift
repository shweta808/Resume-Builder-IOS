//
//  AlertController.swift
//  Resume Builder
//
//  Created by MyBook on 12/15/17.
//  Copyright © 2017 Rutvik Desai. All rights reserved.
//

import UIKit

class AlertController {
    // Function to call alerts during some error.
    static func displayAlert(_ viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title:title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        viewController.present(alert, animated: true, completion: nil)
    }
}
