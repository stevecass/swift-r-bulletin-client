//
//  RbcViewController.swift
//  navb33
//
//  Created by Steven Cassidy on 10/22/15.
//  Copyright © 2015 Steven Cassidy. All rights reserved.
//

import UIKit

class RbcViewController: UIViewController {

    var dsParser : NSDateFormatter {
        let df = NSDateFormatter()
        df.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ"
        return df
    }

    var dsFormatter: NSDateFormatter {
        let df = NSDateFormatter()
        df.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        df.dateFormat = "MMM d, HH:mm"
        return df
    }

    func showErrorAlert(title:String, error:NSString) {
        let alert = UIAlertController.init(title: title, message: String(error), preferredStyle: UIAlertControllerStyle.Alert)
        let defaultAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
            // do nothing
        }
        alert.addAction(defaultAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }

    func dateFromJson(dateString:String) -> NSDate? {
        return dsParser.dateFromString(dateString)
    }

    func displayDateFromJSON(dateString: String) -> String {
        let d = dateFromJson(dateString)
        if d != nil {
            return dsFormatter.stringFromDate(d!)
        } else {
            return "Did not parse " + dateString + " as date"
        }
        
        
    }

}
