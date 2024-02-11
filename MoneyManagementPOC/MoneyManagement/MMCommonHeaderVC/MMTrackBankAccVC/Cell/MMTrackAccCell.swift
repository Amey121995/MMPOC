//
//  MMTrackAccCell.swift
//  Amey
//
//  Created by Amey on 11/01/24.
//

import UIKit

class MMTrackAccCell: UITableViewCell {
    
    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var imgBankIcon: UIImageView!
    @IBOutlet weak var lblBankName: UILabel!
    @IBOutlet weak var lblDes: UILabel!
    @IBOutlet weak var lblMaskedAccount: UILabel!
    @IBOutlet weak var imgCheckBox: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewCard.layer.borderWidth = 1
        self.viewCard.layer.cornerRadius = 15
        self.viewCard.layer.borderColor = UIColor.clear.cgColor
        self.viewCard.layer.shadowOpacity = 0.18
        self.viewCard.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.viewCard.layer.shadowRadius = 2
        self.viewCard.layer.shadowColor = UIColor.black.cgColor
        self.viewCard.layer.masksToBounds = false
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
