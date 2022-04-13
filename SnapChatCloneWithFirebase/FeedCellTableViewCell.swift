//
//  FeedCellTableViewCell.swift
//  SnapChatCloneWithFirebase
//
//  Created by Ali Osman DURMAZ on 8.04.2022.
//

import UIKit

class FeedCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
