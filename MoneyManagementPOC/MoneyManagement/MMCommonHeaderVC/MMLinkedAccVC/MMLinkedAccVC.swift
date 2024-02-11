//
//  MMLinkedAccVC.swift
//  Amey
//
//  Created by Amey on 15/01/24.
//

import UIKit

func maskAmt(_ val: Double) -> String{
    let str = "\(Int(val))"
    let maskedMiddleDigits = String(repeating: "X", count: 4)
    let maskedString =  maskedMiddleDigits
    
    return maskedString
}

class MMBankAccountDetails{
    var bankName: String?
    var bankHolderName: String?
    var bankAccNumber: String?
    var lasupdatedTime: String?
    var bankBalance: Double?
    var isBankBalVisible: Bool?
    init(bankName: String? = nil, bankHolderName: String? = nil, bankAccNumber: String? = nil, lasupdatedTime: String? = nil, bankBalance: Double? = nil, isBankBalVisible: Bool? = nil) {
        self.bankName = bankName
        self.bankHolderName = bankHolderName
        self.bankAccNumber = bankAccNumber
        self.lasupdatedTime = lasupdatedTime
        self.bankBalance = bankBalance
        self.isBankBalVisible = isBankBalVisible
    }
}

class MMLinkedAccVC: BaseviewVC {

    @IBOutlet weak var lblHeaderText: UILabel!
    @IBOutlet weak var noRecords: UIView!
    
    @IBOutlet weak var viewAllView: UIView!
    @IBOutlet weak var linkedAssetTableView: UITableView!
    @IBOutlet weak var btnLinkAccount: UIButton!
    @IBOutlet weak var lblTotalActiveCount: UILabel!
    
    var selectedIndex = -1
    var selectedMemberIndex = 0
    
    var bankList : [MMBankAccountDetails] = [MMBankAccountDetails(bankName: "Axis  Bank", bankHolderName: "John Doe", bankAccNumber: "XXXXXXXXXXX 9137", lasupdatedTime: "01:11 PM", bankBalance: 1929.21, isBankBalVisible: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Assets"
        self.setBackButtonWithoutCart()
        self.btnLinkAccount.setDefaultBlueBtn(fontSize: 12, isRounded: true)
        self.setUI()
    }
    
    override func onBackButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    func setUI(){
        self.noRecords.isHidden = true
        self.lblTotalActiveCount.text = "\(self.bankList.count)"
        self.setTableViewUI()
    }

    func setTableViewUI(){
        self.linkedAssetTableView.delegate = self
        self.linkedAssetTableView.dataSource = self
        
        self.linkedAssetTableView.register(UINib(nibName: "MfListCell", bundle: nil), forCellReuseIdentifier: "MfListCell")
        self.linkedAssetTableView.register(UINib(nibName: "MMLinkedAssetsCell", bundle: nil), forCellReuseIdentifier: "MMLinkedAssetsCell")
    }
    
    
    @objc func unlinkBroker(_ sender: UIButton){
        self.showToast(message: "Unlinked Pressed")
    }
    
    
    @IBAction func goToViewAll(_ sender: Any) {
        let vc = MMSelectMeberVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func linkAccount(_ sender: Any) {
        let vc = MMSelectMeberVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}

extension MMLinkedAccVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bankList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.bankList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MMLinkedAssetsCell", for: indexPath) as! MMLinkedAssetsCell
        cell.btnUnlink.tag = indexPath.row
        cell.btnUnlink.addTarget(self, action: #selector(unlinkBroker), for: .touchUpInside)
        cell.selectionStyle = .none
        cell.lblBankName.text = item.bankName ?? "-"
        cell.lblLinkedMember.text = item.bankHolderName ?? "-"
        cell.lblValAccountNumber.text = item.bankAccNumber ?? "-"
        cell.lblUpdatedOn.text = item.lasupdatedTime ?? "-"
        
        
        if item.isBankBalVisible!{
            cell.imgEye.tintColor = UIColor.blue
            cell.lblBankBalance.text = "₹" + "\((item.bankBalance ?? 0).kmFormatted)"
        }
        else{
            cell.imgEye.tintColor = .black
            cell.lblBankBalance.text = "₹" + "\(maskAmt(item.bankBalance ?? 0))"
        }
         
        cell.imgEye.TapLisner {
            
            self.bankList[indexPath.row].isBankBalVisible = !(self.bankList[indexPath.row].isBankBalVisible!)
            self.linkedAssetTableView.reloadData()
        }
        
        
        
        return cell
    }
    
    
}
                            
extension MMLinkedAccVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
