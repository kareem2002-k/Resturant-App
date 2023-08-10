//
//  CustomTableViewCell.swift
//  ResturantAppITI
//
//  Created by Kareem Ahmed on 10/08/2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var optionIcon: UIImageView!
    @IBOutlet weak var optionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
