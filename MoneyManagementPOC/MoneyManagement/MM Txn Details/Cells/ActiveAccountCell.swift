//
//  ActiveAccountCell.swift
//  Amey
//
//  Created by Admin on 15/01/24.
//

import UIKit

class ActiveAccountCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var btnUnlink: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        bgView.addShadow()
    }
}
