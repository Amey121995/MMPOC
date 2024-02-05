//
//  MMTrackBankAccVC.swift
//  Minty
//
//  Created by Ameya on 11/01/24.
//

import UIKit

class MMTrackBankAccVC: BaseviewVC {

    @IBOutlet weak var tblViewTrackAcc: UITableView!
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var lblBottomDescription: UILabel!
    
    var commonHeaderDelegate : MMCommonHeadrDelegate?
    
    var selectedIndex = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTblView()
        self.btnContinue.setDefaultBlueBtn()
        
        
        let completeString = "We automatically track your expenses for a default period of 6 months. If you wish to modify click View Consent details."
        let attributedString = NSMutableAttributedString(string: completeString)
        if let range = completeString.range(of: "View Consent details.") {
            let nsRange = NSRange(range, in: completeString)
            attributedString.addAttribute(.foregroundColor, value: UIColor.blue, range: nsRange)
        }
        
        lblBottomDescription.attributedText = attributedString
        lblBottomDescription.TapLisner {
            let destVC = MMTrackAccountPopUp()
            destVC.modalPresentationStyle = .overFullScreen
            self.present(destVC, animated: true)
        }
      
    }
    
    func setTblView(){
        self.tblViewTrackAcc.register(UINib(nibName: "MMTrackAccCell", bundle: nil), forCellReuseIdentifier: "MMTrackAccCell")
        self.tblViewTrackAcc.dataSource = self
        self.tblViewTrackAcc.delegate = self
        self.tblViewTrackAcc.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        self.tblViewTrackAcc.separatorStyle = .none
    }
    

    @IBAction func onContinuePressed(_ sender: Any) {
        if selectedIndex == -1{
            self.showToast(message: "Please select bank to track.")
        }
        else{
            if self.selectedIndex == 0{
                let destVC = MMBankFailurePopUpVC()
                destVC.modalPresentationStyle = .overFullScreen
                self.present(destVC, animated: true)
            }
            else if self.selectedIndex == 1{
                self.commonHeaderDelegate?.isTaskComplete(nextVC: "MMVerifyBankAccountVC")
                self.commonHeaderDelegate?.setStatus(status: "success")
            }else if self.selectedIndex == 2{
                self.commonHeaderDelegate?.isTaskComplete(nextVC: "MMVerifyBankAccountVC")
                self.commonHeaderDelegate?.setStatus(status: "pending")
            }
            else{
                self.commonHeaderDelegate?.isTaskComplete(nextVC: "MMVerifyBankAccountVC")
                self.commonHeaderDelegate?.setStatus(status: "MMTxnVC")
            }
            
        }
    }
}

extension MMTrackBankAccVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MMTrackAccCell", for: indexPath) as! MMTrackAccCell
        if self.selectedIndex == indexPath.row{
            cell.imgCheckBox.image = UIImage(named: "checkbox")?.withRenderingMode(.alwaysTemplate)
            cell.imgCheckBox.tintColor = UIColor.blue
        }
        else{
            cell.imgCheckBox.image = UIImage(named: "blank-check-box")?.withRenderingMode(.alwaysTemplate)
            cell.imgCheckBox.tintColor = UIColor(hex: "#D4D4D4")
        }
        
        return cell
    }
    
    
}
extension MMTrackBankAccVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        self.tblViewTrackAcc.reloadData()
        
    }
    
}
