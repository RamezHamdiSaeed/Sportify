//
//  LeagueDetailsCollectionViewCell.swift
//  Sportify
//
//  Created by Hadir on 25/04/2024.
//

import UIKit

class LeagueDetailsCollectionViewCell: UICollectionViewCell {
    @IBOutlet var firstTeamLogo: UIImageView!
    @IBOutlet var firstTeamNameLabel: UILabel!
    @IBOutlet var secondTeamLogo: UIImageView!
    @IBOutlet var secondTeamNameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var scoreLabel: UILabel!
    
    @IBOutlet var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        firstTeamLogo.clipsToBounds = true
        secondTeamLogo.clipsToBounds = true
        
    }

}
