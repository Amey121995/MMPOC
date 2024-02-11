//
//  MMReportVC.swift
//  Amey
//
//  Created by Admin on 15/01/24.
//

import UIKit
import Fastis

class MMReportVC: BaseviewVC {

    @IBOutlet weak var viewAccounts: UIView!
    @IBOutlet weak var viewFromDate: UIView!
    @IBOutlet weak var viewToDate: UIView!
    @IBOutlet weak var lblFromDate: UILabel!
    @IBOutlet weak var lblToDate: UILabel!
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var btnWhatsapp: UIButton!
    
    var fromDate:Date? = nil
    var toDate:Date? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        viewAccounts.addShadow()
        self.setBackButtonWithoutCart()
        
        self.title = "My Account Balance"
        btnDownload.tag = 1
        btnEmail.tag = 2
        btnWhatsapp.tag = 3
        btnDownload.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        btnEmail.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        btnWhatsapp.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "DD/MM/YYYY"
        viewFromDate.TapLisner {
            
            let fastisController = FastisController(mode: .single)
            fastisController.title = "Choose From Date"
            fastisController.maximumDate = Date()
            fastisController.allowToChooseNilDate = true
            fastisController.shortcuts = [.today]
            fastisController.doneHandler = { result in
                self.fromDate = result ?? Date()
                let strDate = dateFormater.string(from: result ?? Date())
                self.lblFromDate.text = strDate
            }
            fastisController.present(above: self)
            
        }
        viewToDate.TapLisner {
            
            let fastisController = FastisController(mode: .single)
            fastisController.title = "Choose To Date"
            fastisController.maximumDate = Date()
            fastisController.allowToChooseNilDate = true
            fastisController.shortcuts = [.today]
            fastisController.doneHandler = { result in
                self.toDate = result ?? Date()
                let strDate = dateFormater.string(from: result ?? Date())
                self.lblToDate.text = strDate
            }
            fastisController.present(above: self)
            
        }
    }
    @objc func btnTapped(sender : UIButton){
        if sender.tag == 1{
            self.showToast(message: "Report Downloading")
        }else if sender.tag == 2{
            self.showToast(message: "Report has been shared successfully on your registered mail id.")
        }else if sender.tag == 3{
            self.showToast(message: "Report has been shared successfully on Whatsapp registered mobile number.")
        }
    }
}
