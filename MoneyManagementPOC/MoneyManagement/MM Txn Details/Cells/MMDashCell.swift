//
//  MMDashCell.swift
//  Amey
//
//  Created by Amey on 03/01/24.
//

import UIKit

class MMDashCell: UICollectionViewCell {
    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgArrow: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.viewCard.layer.borderWidth = 1
        self.viewCard.layer.cornerRadius = 15
        self.viewCard.layer.borderColor = UIColor.clear.cgColor
        self.viewCard.layer.shadowOpacity = 0.18
        self.viewCard.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.viewCard.layer.shadowRadius = 2
        self.viewCard.layer.shadowColor = UIColor.black.cgColor
        self.viewCard.layer.masksToBounds = false
    }

}
