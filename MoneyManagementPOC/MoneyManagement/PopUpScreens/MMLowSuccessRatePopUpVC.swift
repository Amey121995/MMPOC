//
//  MMLowSuccessRatePopUpVC.swift
//  Amey
//
//  Created by Amey on 04/01/24.
//

import UIKit
protocol MMLowSussessProto{
    func cancelPressed()
    func continuePressed()
}
class MMLowSuccessRatePopUpVC: BaseviewVC {
    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgPending: UIImageView!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnContinue: UIButton!
    
    var delegate : MMLowSussessProto?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
    }
    
    func setUI(){
        self.viewCard.clipsToBounds = true
        self.viewCard.roundCorners(corners: [.topLeft, .topRight], radius: 20)
  
        
        self.btnCancel.setDefaultBorderBlueBtn()
        self.btnContinue.setDefaultBlueBtn()
        
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true){
            self.delegate?.cancelPressed()
        }
    }
    
    @IBAction func continuePressed(_ sender: Any) {
        self.dismiss(animated: true){
            self.delegate?.continuePressed()
        }
    }
    
}
