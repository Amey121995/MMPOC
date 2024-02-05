//
//  MMCommonHeadrVC.swift
//  Minty
//
//  Created by Ameya on 10/01/24.
//

import UIKit
protocol MMCommonHeadrDelegate{
    func isTaskComplete(nextVC: String)
    func setStatus(status : String)
}

class MMCommonHeadrVC: BaseviewVC {
    @IBOutlet weak var viewHeaderCard: UIView!
    @IBOutlet weak var viewStepView: UIView!
    
    @IBOutlet weak var lblStep1: UILabel!
    @IBOutlet weak var lblStep2: UILabel!
    @IBOutlet weak var lblStep3: UILabel!
    
    @IBOutlet weak var viewSep1: UIView!
    @IBOutlet weak var viewSep2: UIView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDes: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    var status = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideHeaderView()
        self.title = "ASSETS"
        self.setBackButtonWithoutCart()
        self.isTaskComplete(nextVC: "MMBankListVC")
        
       
    }
    
    func hideHeaderView(){
        self.viewHeaderCard.isHidden = true
    }

    func showHeaderView(title: String, des: String, step: Int){
        
        self.lblTitle.text = title
        self.lblDes.text = des
        
        self.viewSep1.removeDottedLine()
        self.viewSep2.removeDottedLine()
        if step == 3{
            self.lblStep3.setBlueBackWithWhiteText()
            self.lblStep2.setBlueBackWithWhiteText()
            self.lblStep1.setBlueBackWithWhiteText()
            self.viewSep1.addDottedLine(color: UIColor.blue, lineWidth: 2.0, dotSpacing: 2.5)
            self.viewSep2.addDottedLine(color: UIColor.blue, lineWidth: 2.0, dotSpacing: 2.5)
        }
        else if step == 2{
            self.lblStep3.setClearBackWithBlueText()
            self.lblStep2.setBlueBackWithWhiteText()
            self.lblStep1.setBlueBackWithWhiteText()
            self.viewSep1.addDottedLine(color: UIColor.blue, lineWidth: 2.0, dotSpacing: 2.5)
            self.viewSep2.addDottedLine(color: UIColor.lightGray, lineWidth: 2.0, dotSpacing: 2.5)
        }
        else{
            self.lblStep3.setClearBackWithBlueText()
            self.lblStep2.setClearBackWithBlueText()
            self.lblStep1.setBlueBackWithWhiteText()
            self.viewSep1.addDottedLine(color: UIColor.lightGray, lineWidth: 2.0, dotSpacing: 2.5)
            self.viewSep2.addDottedLine(color: UIColor.lightGray, lineWidth: 2.0, dotSpacing: 2.5)
        }
        
        self.viewHeaderCard.isHidden = false
    }
    
    func setUIViewController(destVC: BaseviewVC){

        self.addChild(destVC)
        destVC.view.frame.size = self.containerView.bounds.size
        self.containerView.addSubview(destVC.view)
        destVC.didMove(toParent: self)
    }
    
    override func onBackButtonPressed(_ sender: UIButton) {
        let destVC = MMGenericPopUpVC()
        destVC.callBack = self
        destVC.titles = "Exit Confirmation"
        destVC.subTitle = "Are you sure you want to leave? Your changes may not be saved."
        destVC.btn1text = "Yes"
        destVC.btn2text = "No"
        destVC.modalPresentationStyle = .overFullScreen
        self.present(destVC, animated: true)
    }
}

extension MMCommonHeadrVC: MMGenericProto{
    func btnPressed(isBtn1Pressed: Bool) {
        print("isBtn1Pressed == \(isBtn1Pressed)")
        if isBtn1Pressed{
            self.navigationController?.popViewController(animated: true)
        }
        else{
            
        }
    }
    
    
}
extension MMCommonHeadrVC: MMCommonHeadrDelegate{
  
    
    func isTaskComplete(nextVC: String) {
        for view in self.containerView.subviews{
            view.removeFromSuperview()
        }

        switch nextVC{
        case "MMBankListVC":
            self.showHeaderView(title: "Select Bank Account", des: "Track your balances with 100% accuracy, get insights on your expenses!", step: 1)
            
            let destVC = MMBankListVC()
            destVC.commonHeaderDelegate = self
            self.setUIViewController(destVC: destVC)
        case "MMTrackBankAccVC":
            self.showHeaderView(title: "Yay! we found your accounts", des: "Select and confirm the accounts you want to track!", step: 1)
            
            let destVC = MMTrackBankAccVC()
            destVC.commonHeaderDelegate = self
            self.setUIViewController(destVC: destVC)
        case "MMVerifyMobileVC":
            self.showHeaderView(title: "Verify your mobile number", des: "You will receive a 6-digit code on your phone number +91-8652010383 From Finvu", step: 1)
            
            let destVC = MMVerifyMobileVC()
            destVC.commonHeaderDelegate = self
            self.setUIViewController(destVC: destVC)
            break
        case "MMChangeMobNoVC":
            self.showHeaderView(title: "Enter or select mobile number", des: "Select an already verified number for finding your account or use an another number.", step: 1)
            
            let destVC = MMChangeMobNoVC()
            destVC.commonHeaderDelegate = self
            self.setUIViewController(destVC: destVC)
        case "MMVerifyBankAccountVC":
            self.showHeaderView(title: "AXIS BANK Verification", des: "Verify your bank account by OTP sent to you on your phone number +91-9699935433", step: 2)
            let destVC = MMVerifyBankAccountVC()
            destVC.commonHeaderDelegate = self
            self.setUIViewController(destVC: destVC)
        case "MMBankRequestLoaderVC":
            let destVC = MMBankRequestLoaderVC()
            destVC.commonHeaderDelegate = self
            self.navigationController?.pushViewController(destVC, animated: true)
        case "MMResultVC":
            self.showHeaderView(title: "All done!", des: "Enjoy seamless tracking", step: 3)
            let destVC = MMResultVC()
            destVC.status = self.status
            destVC.commonHeaderDelegate = self
            self.setUIViewController(destVC: destVC)
        case "success":
            
            let destVC = MMLinkedAccVC()
            self.navigationController?.pushViewController(destVC, animated: true)
            break
        case "MMTxnVC":
            
            let destVC = MMTxnVC()
            self.navigationController?.pushViewController(destVC, animated: true)
            break
        default:
            break
        }
       
    }
    
    func setStatus(status: String) {
        self.status = status
    }
    
}
