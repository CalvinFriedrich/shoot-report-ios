//
//  RifleTableViewCell.swift
//  shoot-report-ios
//
//  Created by Calvin Friedrich on 10.03.21.
//

import UIKit

class RifleTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
