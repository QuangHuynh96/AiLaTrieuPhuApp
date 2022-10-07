//
//  RulesTableViewCell.swift
//  GameProject
//
//  Created by GST.DN on 03/10/2022.
//

import UIKit

class RulesTableViewCell: UITableViewCell {

    @IBOutlet var supportImage: UIImageView!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
