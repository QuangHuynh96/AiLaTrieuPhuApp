//
//  ScoreTableViewCell.swift
//  GameProject
//
//  Created by GST.DN on 03/10/2022.
//

import UIKit

class ScoreTableViewCell: UITableViewCell {
    @IBOutlet var placesLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
