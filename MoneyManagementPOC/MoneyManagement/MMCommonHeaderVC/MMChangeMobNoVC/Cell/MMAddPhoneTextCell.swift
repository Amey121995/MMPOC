//
//  MMAddPhoneTextCell.swift
//  Minty
//
//  Created by Ameya on 12/01/24.
//

import UIKit

class MMAddPhoneTextCell: UITableViewCell {
    
    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var tfAddNumber: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewCard.layer.borderWidth = 1
        self.viewCard.layer.cornerRadius = 5
        self.viewCard.layer.borderColor = UIColor.clear.cgColor
        self.viewCard.layer.shadowOpacity = 0.08
        self.viewCard.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        self.viewCard.layer.shadowRadius = 2
        self.viewCard.layer.shadowColor = UIColor.black.cgColor
        self.viewCard.layer.masksToBounds = false
        self.selectionStyle = .none
        self.tfAddNumber.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
