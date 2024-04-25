//
//  LeagueTableViewCell.swift
//  Sportify
//
//  Created by Ramez Hamdi Saeed on 25/04/2024.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {

    @IBOutlet weak var leagueName : UILabel!
    @IBOutlet weak var leagueImage : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
