//
//  DropCell.swift
//  Minty
//
//  Created by Ameya on 04/01/24.
//

import UIKit
import DropDown

class DropCell: DropDownCell {

    @IBOutlet weak var lbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
