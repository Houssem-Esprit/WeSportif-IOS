//
//  HomeCell.swift
//  WeSportif
//
//  Created by Sam on 29/11/2019.
//  Copyright © 2019 Esprit. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.backgroundColor = .white
        
        cardView.layer.cornerRadius = 10.0
        
        cardView.layer.shadowColor = UIColor.gray.cgColor
        
        cardView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        
        cardView.layer.shadowRadius = 6.0
        
        cardView.layer.shadowOpacity = 0.7
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func eventBtnClicked(_ sender: UIButton) {
    }
}
