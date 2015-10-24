//
//  ViewController.swift
//  navb33
//
//  Created by Steven Cassidy on 10/21/15.
//  Copyright © 2015 Steven Cassidy. All rights reserved.
//

import UIKit

class TopicViewController: RbcViewController, UITableViewDataSource, UITableViewDelegate {


    var topics = NSArray()
    var currentTopic = NSDictionary()
    let refreshControl = UIRefreshControl()

    @IBOutlet weak var tableView: UITableView!
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.font = cell.textLabel?.font.fontWithSize(12)
        cell.textLabel?.text = String(topics[indexPath.row].objectForKey("name")!)
        return cell
    }


    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        currentTopic = topics[indexPath.row] as! NSDictionary
        return indexPath
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "conv" {
            (segue.destinationViewController as! ConvViewController).currentTopic = currentTopic
        }
    }


    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //performSegueWithIdentifier("conv", sender: self)
        
    }

    func showJSON(data:NSData?) {
        if data != nil {
            do {
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                topics = jsonResult
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
            } catch {
                print("Fetch failed: \((error as NSError).localizedDescription)")
            }
        } else {
            showErrorAlert("Communications", error:"No data retrieved from server. Network?")
        }
        self.refreshControl.endRefreshing()
    }
    
    func loadTopics() {
        let url = NSURL(string:"http://localhost:3000/api/topics")!
        print("Will call \(url)")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url) { (data, response, error) -> Void in
            self.showJSON(data)
        }
        task.resume()
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }

  
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTopics()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: "loadTopics", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

