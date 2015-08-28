//
//  MovieCell.swift
//  rotten-tomatoes-client
//
//  Created by Gideon Goodwin on 8/28/15.
//  Copyright © 2015 Gideon Goodwin. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
