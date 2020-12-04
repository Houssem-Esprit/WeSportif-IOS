//
//  HomeCVCell.swift
//  WeSportif
//
//  Created by Rami Ounifi on 12/27/19.
//  Copyright © 2019 Esprit. All rights reserved.
//

import UIKit

class HomeCVCell: UICollectionViewCell {
    
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var cardView: UIView!
    override func awakeFromNib() {
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 10.0
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cardView.layer.shadowRadius = 6.0
        cardView.layer.shadowOpacity = 0.7
        dateView.layer.cornerRadius = 4
    }
    
    
    
}
