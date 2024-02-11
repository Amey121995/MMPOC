//
//  MMFetchedBankAccountsVC.swift
//  Amey
//
//  Created by Admin on 15/01/24.
//

import UIKit

class MMFetchedBankAccountsVC: BaseviewVC {

    @IBOutlet weak var viewAccounts: UIView!
    @IBOutlet weak var tblViewActiveAccounts: UITableView!
    @IBOutlet weak var btnViewOverallReport: UIButton!
    @IBOutlet weak var btnTrackNewAccount: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewAccounts.addShadow()
        self.setBackButtonWithoutCart()
        tblViewActiveAccounts.register(UINib(nibName: "ActiveAccountCell", bundle: nil), forCellReuseIdentifier: "ActiveAccountCell")
        
        self.title = "My Account Balance" 
        btnViewOverallReport.addTarget(self, action: #selector(btnViewOverallReportTapped(sender: )), for: .touchUpInside)
        btnTrackNewAccount.addTarget(self, action: #selector(btnAddNewAccountTapped(sender: )), for: .touchUpInside)
    }
    @objc func btnViewOverallReportTapped(sender : UIButton){
        let vc = MMReportVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func btnAddNewAccountTapped(sender : UIButton){
        let vc = MMSelectMeberVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension MMFetchedBankAccountsVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActiveAccountCell", for: indexPath) as! ActiveAccountCell
        cell.btnUnlink.tag = indexPath.row
        cell.btnUnlink.addTarget(self, action: #selector(btnUnlinkPressed(sender: )), for: .touchUpInside)
        return cell
    }
    @objc func btnUnlinkPressed(sender : UIButton){
        let destVC = MMGenericPopUpVC()
        destVC.titles = "Please Confirm"
        destVC.subTitle = "Are you sure you want to permanently delete your bank account? This action is irreversible and you won't be able to track your expenses in future.\nAre you Sure you Want to Unlink?"
        destVC.btn1text = "No"
        destVC.btn2text = "Yes"
        destVC.modalPresentationStyle = .overFullScreen
        self.present(destVC, animated: true)
    }
}
extension MMFetchedBankAccountsVC : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
