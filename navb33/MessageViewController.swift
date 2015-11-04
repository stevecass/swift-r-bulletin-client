//
//  MessageViewController.swift
//  navb33
//
//  Created by Steven Cassidy on 10/21/15.
//  Copyright © 2015 Steven Cassidy. All rights reserved.
//

import UIKit

class MessageViewController: RbcViewController, UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!
    var currentConversation = NSDictionary()
    var messages = NSArray()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("msgcell", forIndexPath: indexPath) as! MsgTableViewCell
        let message = String(messages[indexPath.row].objectForKey("content")!)
        let userName = String(messages[indexPath.row].objectForKey("username")!)
        let displayDate = displayDateFromJSON(String(messages[indexPath.row].objectForKey("updated_at")!))

        cell.lblMain.text = message
        cell.btnAuthor.setTitle("From \(userName) at \(displayDate)", forState: UIControlState.Normal) 
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
        return cell
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
            showErrorAlert("Communications", error:(error as NSError).localizedDescription)
            print("Fetch failed: \((error as NSError).localizedDescription)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("vdl in MessageViewController")
        let nib = UINib(nibName: "MsgTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "msgcell")
        
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
