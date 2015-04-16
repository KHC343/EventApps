//
//  EventsViewController.swift
//  EventsApp
//
//  Created by kcarter on 4/7/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var eventTableView: UITableView!
    var eventsArray = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if PFUser.currentUser() == nil
        {
            performSegueWithIdentifier("EventsToRegister", sender: self)
        }
        else
        {
            Profile.queryForCurrentUsersProfile({ (profile, error) -> Void in
                self.setEventDate()
            })
        }
}
    func setEventData()
    {
        Event.queryForEvents { (events, error) -> Void in
            self.eventsArray = events as [Event]
            self.eventTableView.reloadData()
        }
    }
    
    @IBAction func onRefreshTapped(sender: UIBarButtonItem)
    {
        setEventData()
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell") as TableViewCell
        let event = eventsArray[indexPath.row] as Event
        cell.eventName.text = event.title
        cell.eventDate.text = event.date.toStringOfMonthDayAndTime()
        event.eventPicFile.getDataInBackgroundWithBlock { (data, error) -> Void in
            cell.eventsImageView.image = UIImage(data: data)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return eventsArray.count
    }
}