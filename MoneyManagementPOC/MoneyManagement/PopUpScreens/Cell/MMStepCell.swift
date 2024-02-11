//
//  MMStepCell.swift
//  Amey
//
//  Created by Amey on 08/01/24.
//

import UIKit

class MMStepCell: UITableViewCell {
    
    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var viewStepCard: UIView!
    @IBOutlet weak var lblStep: UILabel!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var viewArrowCard: UIView!
    @IBOutlet weak var imgArrow: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewStepCard.layer.cornerRadius = 5
        self.viewCard.layer.borderWidth = 1
        self.viewCard.layer.borderColor = UIColor.blue.withAlphaComponent(0.5).cgColor
        self.viewCard.layer.cornerRadius = 10
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
