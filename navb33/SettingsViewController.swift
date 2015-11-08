//
//  SettingsViewController.swift
//  rbull-client
//
//  Created by Steven Cassidy on 10/25/15.
//  Copyright © 2015 Steven Cassidy. All rights reserved.
//

import UIKit

class SettingsViewController: RbcViewController {

    @IBOutlet weak var lblWhoLoggedIn: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func processServerData(data : NSData) {
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            print(json)
            var userMessage = String(json["msg"] as! NSString)
            if userMessage  == "OK" {
                let userName = String(json["username"]!)
                NSUserDefaults.standardUserDefaults().setValue(userName, forKey: "username")
                userMessage = "You are logged in as \(userName)"
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.lblWhoLoggedIn.text = userMessage
            })
        } catch {
            showErrorAlert("Communications", error:(error as NSError).localizedDescription)
            print("Fetch failed: \((error as NSError).localizedDescription)")
        }

    }

    func checkLogin() {
        let url = NSURL(string:"http://localhost:3000/api/sessions")!
        print("Will call \(url)")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url){ (data, response, error) -> Void in
            if (error == nil ) {
                self.processServerData(data!)
            } else {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.showErrorAlert("Server communication failed", error: error!.localizedDescription)
                })
            }
        }
        task.resume()

        
    }



    override func viewDidAppear(animated: Bool) {
        checkLogin()
//        let user = NSUserDefaults.standardUserDefaults().objectForKey("username")
//        if user != nil {
//            lblWhoLoggedIn.text = "You are logged in as \(user)"
//        } else {
//            lblWhoLoggedIn.text = "You are not logged in"
//        }

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
