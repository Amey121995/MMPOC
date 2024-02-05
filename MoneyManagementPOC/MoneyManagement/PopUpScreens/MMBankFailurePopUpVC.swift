//
//  MMBankFailurePopUpVC.swift
//  Minty
//
//  Created by Ameya on 04/01/24.
//

import UIKit

class MMBankFailurePopUpVC: BaseviewVC {
    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgPending: UIImageView!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnContinue: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
    }
    
    func setUI(){
        self.viewCard.roundCorners(corners:[.topLeft, .topRight], radius: 20)
        self.viewCard.clipsToBounds = true
        
        self.btnCancel.setDefaultBorderBlueBtn()
        self.btnContinue.setDefaultBlueBtn()
        
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func continuePressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
