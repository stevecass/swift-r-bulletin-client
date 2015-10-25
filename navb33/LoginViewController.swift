//
//  LoginViewController.swift
//  rbull-client
//
//  Created by Steven Cassidy on 10/24/15.
//  Copyright © 2015 Steven Cassidy. All rights reserved.
//

import UIKit

protocol LoginViewDelegate {
    func loginViewDismissed(username:String, loginSuccess: Bool)
}

class LoginViewController: RbcViewController {

    var loginViewDelegate: LoginViewDelegate?
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!

    @IBAction func cancelPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)

    }

    @IBAction func loginPressed(sender: AnyObject) {
        if loginViewDelegate == nil {
            showErrorAlert("Internal error", error: "Can't handle login")
            self.dismissViewControllerAnimated(true, completion: nil)
        } else {
            sendLoginRequest()
        }
    }

    func processLoginResult(data: NSData?) {
        do {
            if data != nil {
                let response = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                if response["status"] as! NSInteger == 200 {
                    loginViewDelegate?.loginViewDismissed(self.tfUsername.text!, loginSuccess:true)
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.dismissViewControllerAnimated(true, completion: nil)
                    })
                } else {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.showErrorAlert("Login failed", error: "Login failed")
                    })
                }
            }
        } catch let error as NSError {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.showErrorAlert("Login failed", error: error.localizedDescription)
            })
        }
    }

    func sendLoginRequest() {
        let credentials = NSMutableDictionary()
        credentials.setObject(tfUsername.text!, forKey: "username")
        credentials.setObject(tfPassword.text!, forKey: "password")
        do {
            let requestBody = try NSJSONSerialization.dataWithJSONObject(credentials, options: NSJSONWritingOptions.PrettyPrinted )
            let url = NSURL(string:"http://localhost:3000/api/sessions")!
            let request = NSMutableURLRequest(URL:url)
            request.setValue("application/json", forHTTPHeaderField: "Content-type")
            request.HTTPMethod = "POST"
            request.HTTPBody = requestBody;
            print("Will call \(url)")
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request){ (data, response, error) -> Void in
                if (error != nil) {
                    self.processLoginResult(data)
                } else {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.showErrorAlert("Login failed", error: error!.localizedDescription)
                    })
                }
            }
            task.resume()

        } catch let error as NSError {
            self.showErrorAlert("Login failed", error: error.localizedDescription)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
