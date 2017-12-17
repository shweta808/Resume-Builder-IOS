//
//  NextSection1.swift
//  Resume Builder
//
//  Created by MyBook on 12/16/17.
//  Copyright © 2017 Rutvik Desai. All rights reserved.
//

import UIKit

class NextSection1: UIViewController {
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        moreProjView.isHidden = true
        moreExpView.isHidden = true
        nextSectionView.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func moreProjPressed(_ sender: UIButton) {
        moreProjView.isHidden = false
        moreExpView.isHidden = true
        nextSectionView.isHidden = true
    }
    
    @IBAction func moreExpPressed(_ sender: UIButton) {
        moreProjView.isHidden = true
        moreExpView.isHidden = false
        nextSectionView.isHidden = true
    }
    @IBAction func nextSectionPressed(_ sender: UIButton) {
        moreProjView.isHidden = true
        moreExpView.isHidden = true
        nextSectionView.isHidden = false
    }
    @IBAction func cancelPressed(_ sender: UIButton) {
        hideView()
    }
    
    func hideView() {
        let parent = self.parent as! SignUp
        parent.nextSectionView.isHidden = true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
