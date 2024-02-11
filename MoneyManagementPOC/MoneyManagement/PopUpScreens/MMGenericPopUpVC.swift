//
//  MMGenericPopUpVC.swift
//  Amey
//
//  Created by Amey on 04/01/24.
//

import UIKit
protocol MMGenericProto{
    func btnPressed(isBtn1Pressed: Bool)
}
class MMGenericPopUpVC: BaseviewVC {
    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var divider: UIView!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    
    var titles = ""
    var subTitle = ""
    
    var callBack : MMGenericProto?
    
    var btn1text = "Continue"
    var btn2text = "Cancel"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
    }
    
    func setUI(){
        
        if self.titles.isEmpty{
            
        }
        else{
            self.lblTitle.text = self.titles
        }
        
        if self.subTitle.isEmpty{
            
        }
        else{
            self.lblSubTitle.text = self.subTitle
        }
        
        
        
        self.viewCard.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        self.viewCard.clipsToBounds = true
        
        self.btn1.setTitle(self.btn1text, for: .normal)
        self.btn1.setDefaultBorderBlueBtn()
        self.btn2.setTitle( self.btn2text, for: .normal)
        self.btn2.setDefaultBlueBtn()
        
        
        
    }
    
    @IBAction func btn1Pressed(_ sender: Any) {
        self.dismiss(animated: true){
            self.callBack?.btnPressed(isBtn1Pressed: true)
        }
    }
    
    @IBAction func btn2Pressed(_ sender: Any) {
        self.dismiss(animated: true){
            self.callBack?.btnPressed(isBtn1Pressed: false)
        }
    }
    
}
