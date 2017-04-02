//
//  CommentCustomCell.swift
//  Sonder
//
//  Created by Richard Price on 02/04/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import UIKit

class CommentCustomCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLable: UILabel!
    @IBOutlet weak var commentLable: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
