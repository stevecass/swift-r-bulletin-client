//
//  RbcViewController.swift
//  navb33
//
//  Created by Steven Cassidy on 10/22/15.
//  Copyright © 2015 Steven Cassidy. All rights reserved.
//

import UIKit

class RbcViewController: UIViewController {

    func showErrorAlert(title:String, error:NSString) {
        let alert = UIAlertController.init(title: title, message: String(error), preferredStyle: UIAlertControllerStyle.Alert)
        let defaultAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
            // do nothing
        }
        alert.addAction(defaultAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }

    func dateFromJson(dateString:String) -> NSDate? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        return dateFormatter.dateFromString(dateString)
    }

}
