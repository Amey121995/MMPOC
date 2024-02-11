//
//  MMLinkedAssetsCell.swift
//  Amey
//
//  Created by Amey on 15/01/24.
//

import UIKit

class MMLinkedAssetsCell: UITableViewCell {

    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var lblBankName: UILabel!
    @IBOutlet weak var lblLinkedMember: UILabel!
    @IBOutlet weak var lblValAccountNumber: UILabel!
    @IBOutlet weak var lblUpdatedOn: UILabel!
    @IBOutlet weak var lblBankBalance: UILabel!
    @IBOutlet weak var imgEye: UIImageView!
    
    @IBOutlet weak var btnUnlink: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewBG.setShadow(cornerRadius: 15)
        self.viewBG.layer.borderWidth = 1
        self.viewBG.layer.borderColor = UIColor.lightGray.cgColor
        self.btnUnlink.setDefaultBlueBtn(fontSize: 12, isRounded: true)
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
