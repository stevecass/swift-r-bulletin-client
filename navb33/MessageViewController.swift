//
//  MessageViewController.swift
//  navb33
//
//  Created by Steven Cassidy on 10/21/15.
//  Copyright © 2015 Steven Cassidy. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController, UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!
    var currentConversation = NSDictionary()
    var messages = NSArray()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("msgcell", forIndexPath: indexPath) as! MessageTableViewCell
        let message = String(messages[indexPath.row].objectForKey("content")!)
        cell.lblMain.text = message
        return cell
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
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            currentConversation = jsonResult
            messages = jsonResult.objectForKey("messages") as! NSArray
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
        print("vdl in MessageViewController")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0
        if let topicId = currentConversation.objectForKey("topic_id") {
            if let convId = currentConversation.objectForKey("id") {
                let url = NSURL(string:"http://localhost:3000/api/topics/\(topicId)/conversations/\(convId)")!
                print("Will call \(url)")
                let session = NSURLSession.sharedSession()
                let task = session.dataTaskWithURL(url) { (data, response, error) -> Void in
                    self.showJSON(data!)
                }
                task.resume()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
