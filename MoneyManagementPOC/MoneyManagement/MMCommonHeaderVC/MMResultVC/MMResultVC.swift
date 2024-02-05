//
//  MMResultVC.swift
//  Minty
//
//  Created by Ameya on 12/01/24.
//

import UIKit

class MMResultVC: BaseviewVC {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitleText: UILabel!
    @IBOutlet weak var lblDetailText: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    
    @IBOutlet weak var btnContinue: UIButton!
    var commonHeaderDelegate : MMCommonHeadrDelegate?
    var status = "pending"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnContinue.setDefaultBlueBtn()
        self.setUI(self.status)
        // Do any additional setup after loading the view.
        
    }
    
    func setUI(_ status : String){
        
        self.lblTitleText.isHidden = true
        self.lblDetailText.isHidden = true
        self.lblSubTitle.isHidden = true
        
        switch status{
        case "success":
            self.imgView.image = UIImage(named: "MM_Consent_Approve")
            self.lblTitleText.isHidden = false
            self.lblDetailText.isHidden = false
            self.lblSubTitle.isHidden = false
            
            self.lblTitleText.text = "Consent Approved"
            self.lblDetailText.text = "Data Received From Axix Bank"
            self.lblSubTitle.text = "You will be redirected in 10 secs"
            
            break
        case "pending":
            self.imgView.image = UIImage(named: "MM_Consent_Pending")
            self.lblTitleText.isHidden = false
            self.lblSubTitle.isHidden = false
            
            self.lblTitleText.text = "Consent Under Process"
            self.lblSubTitle.text = "It is taking longer than usual to fetch your data. We will notify you once your consent is approved by the bank."
            
            break
            
        default:
            self.imgView.image = UIImage(named: "MM_Bank_details_success")
            self.lblDetailText.isHidden = false
            self.lblDetailText.text = "Bank Details has Been Fetch Successful"
            break
        }
    }


    @IBAction func onContinuePressed(_ sender: Any) {
        self.commonHeaderDelegate?.isTaskComplete(nextVC: status == "MMTxnVC" ? "MMTxnVC" : "success")
    }
}
