//
//  MessageTableViewCell.swift
//  navb33
//
//  Created by Steven Cassidy on 10/22/15.
//  Copyright © 2015 Steven Cassidy. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {


    @IBOutlet weak var lblMain: UILabel!
    @IBOutlet weak var lblSecondary: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
