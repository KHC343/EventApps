//
//  loginViewController.swift
//  EventsApp
//
//  Created by kcarter on 4/7/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

import UIKit

class loginViewController: UIViewController {

    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func loginOnTapped(sender: UIButton)
    {
        if usernameText.text == "" || passwordText.text == ""
        {
            showAlert("Please enter Username and Password", nil, self)
        }
        else
        {
            User.loginUser(usernameText.text, password: passwordText.text, completed: { (result, error) -> Void in
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
