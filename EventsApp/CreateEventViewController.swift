//
//  CreateEventViewController.swift
//  EventsApp
//
//  Created by kcarter on 4/10/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var locationLabel: UITextField!
    @IBOutlet weak var detailsLabel: UITextField!
    let imagePicker = UIImagePickerController()
    var selectImage = UIImage?()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCamera()
    }
    func setUpCamera()
    {
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = true
    }
    
    @IBAction func doneButton(sender: UIBarButtonItem) {
        if titleLabel.text == "" || detailsLabel.text == "" || locationLabel.text == "" ||
            selectImage == nil
        {
            showAlert("please do stuff", nil, self)
        }
    }
    
    @IBAction func cancelButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func selectButton(sender: UIButton)
    {
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        dismissViewControllerAnimated(true, completion: { () -> Void in
            self.selectImage = image
        })
    }
}
