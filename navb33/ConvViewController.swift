//
//  ConvViewController.swift
//  navb33
//
//  Created by Steven Cassidy on 10/21/15.
//  Copyright © 2015 Steven Cassidy. All rights reserved.
//

import UIKit

class ConvViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var tableView: UITableView!
    var currentTopic = NSDictionary()
    var convs = NSArray()
    var selectedConversation = NSDictionary()

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return convs.count;
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.font = cell.textLabel?.font.fontWithSize(12)
        cell.textLabel?.text = String(convs[indexPath.row].objectForKey("name")!)
        return cell
    }

    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        print("CVC willSelect \(indexPath.row)")
        selectedConversation = convs[indexPath.row] as! NSDictionary
        return indexPath
    }

    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        print("CVC didSelect \(indexPath.row)")

    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("CVC prepareForSegue")
        if segue.identifier == "msgs" {
            (segue.destinationViewController as! MessageViewController).currentConversation = selectedConversation
        }
    }

    func showErrorAlert(error:NSString) {
        let alert = UIAlertController.init(title: "Comms error", message: String(error), preferredStyle: UIAlertControllerStyle.Alert)
        let defaultAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
            // do nothing
        }
        alert.addAction(defaultAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }

    func showJSON(data:NSData) {
        do {
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSArray
            convs = jsonResult
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        } catch {
            showErrorAlert((error as NSError).localizedDescription)
            print("Fetch failed: \((error as NSError).localizedDescription)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("CVC vdl")
        if let topicId = currentTopic.objectForKey("id") {
            let url = NSURL(string:"http://localhost:3000/api/topics/\(topicId)/conversations")!
            print("Will call \(url)")
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithURL(url) { (data, response, error) -> Void in
                self.showJSON(data!)
            }
            task.resume()
        }
    }

    override func viewDidAppear(animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
