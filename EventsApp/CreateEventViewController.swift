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
    var location = CLLocation?()
    @IBOutlet weak var datePicker: UIDatePicker!
    
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
    
    func createNewEvent()
    {
        let newEvent = Event()
        newEvent.host = kProfile
        newEvent.details = detailsLabel.text
        newEvent.title = titleLabel.text
        newEvent.eventPicFile = PFFile(data: UIImagePNGRepresentation(selectImage))
        newEvent.location = PFGeoPoint(location: location)
        newEvent.date = datePicker.date
        newEvent.saveInBackgroundWithBlock(nil)
        
    }
    
    @IBAction func doneButton(sender: UIBarButtonItem)
    {
        if titleLabel.text == "" || detailsLabel.text == "" || locationLabel.text == "" ||
            selectImage == nil
        {
            showAlert("please do stuff", nil, self)
        }
        else
        {
            dismissViewControllerAnimated(true, completion: { () -> Void in
                self.geocodeLocationWithBlock({ (succeeded, error) -> Void in
                    self.createNewEvent()
                })
        })
            
        }
        
    }
    
    func geocodeLocationWithBlock(located : (succeeded: Bool, error: NSError!) -> Void)
    {
        var geocode = CLGeocoder()
        geocode.geocodeAddressString(locationLabel.text, completionHandler
            {
                (placemarks, error) -> Void in
                if error != nil
                {
                    showAlertWithError(error, self)
                }
                else
                {
                    let locations : [CLPlacemark] = placemarks as [CLPlacemark]
                    self.location = locations.first?.location
                    located(succeeded: true, error: nil)
                    
                }
            })
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
