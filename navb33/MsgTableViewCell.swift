//
//  MsgTableViewCell.swift
//  rbull-client
//
//  Created by Steven Cassidy on 11/3/15.
//  Copyright © 2015 Steven Cassidy. All rights reserved.
//

import UIKit

class MsgTableViewCell: UITableViewCell {

    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblMain: UILabel!

    @IBAction func btnClicked(sender: AnyObject) {
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
