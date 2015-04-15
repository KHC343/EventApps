//
//  RegisterViewController.swift
//  EventsApp
//
//  Created by kcarter on 4/7/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
     override func viewDidLoad() {
        super.viewDidLoad()

 }
    @IBAction func registerButtonTapped(sender: UIButton) {
        if usernameText.text == "" || passwordText.text == ""
        {
            showAlert("Please enter Username and Password", nil, self)
        }
        else
        {
            User.registerNewUser(usernameText.text, password: passwordText.text, completed: { (result, error) -> Void in
                if error != nil
                {
                   showAlertWithError(error, self)
                }
                else
                {
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            })
        }
    }
   
}