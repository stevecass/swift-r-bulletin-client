//
//  MsgTableViewCell.swift
//  rbull-client
//
//  Created by Steven Cassidy on 11/3/15.
//  Copyright © 2015 Steven Cassidy. All rights reserved.
//

import UIKit

class MsgTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMain: UILabel!
    @IBOutlet weak var btnAuthor: UIButton!

    @IBAction func btnClicked(sender: AnyObject) {
        print("button clicked")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
