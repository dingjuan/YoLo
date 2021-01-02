//
//  cityTableViewCell.swift
//  YoLoBoo
//
//  Created by Kevin Lu on 12/31/20.
//  Copyright © 2020 Juan Ding. All rights reserved.
//

import UIKit

class cityTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 5
        backView.layer.shadowOffset = CGSize(width: 1, height: 1)
        backView.layer.shadowColor = UIColor.gray.cgColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
