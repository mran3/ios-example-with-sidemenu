//
//  PostCell.swift
//  Showcase
//
//  Created by troquer on 12/02/2019.
//  Copyright © 2019 acvc. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellDot: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
