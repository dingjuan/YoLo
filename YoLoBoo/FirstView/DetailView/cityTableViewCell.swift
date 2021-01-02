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
        backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1)
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 10
        backView.layer.borderColor = UIColor.white.cgColor
        backView.layer.borderWidth = 2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
