//
//  MMTxnVC.swift
//  Amey
//
//  Created by Admin on 15/01/24.
//

import UIKit
import DropDown
import SpreadsheetView

class MMTxnVC: BaseviewVC {
    
    @IBOutlet weak var btnDone: UIButton!
    
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var lblTxnType: UILabel!
    @IBOutlet weak var lblAccount: UILabel!
    
    @IBOutlet weak var viewMonthType: UIView!
    @IBOutlet weak var viewTxnType: UIView!
    @IBOutlet weak var viewAccount: UIView!
    
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var spreadsheetView: SpreadsheetView!
    
    let monthDropdown = DropDown()
    let txnTypeDropdown = DropDown()
    let accountTypeDropdown = DropDown()
    
    var header = ["Transaction Category", "Date of Transaction", "Transaction Type", "Amount", "Mapping"]
    
    let txnDetails = [["Others/Withdrawal", "Others/Withdrawal", "Others/Withdrawal", "Others/Withdrawal","Others/Withdrawal", "Others/Withdrawal","Others/Withdrawal", "Others/Withdrawal","Others/Withdrawal", "Others/Withdrawal"],
                      ["23/10/2023", "23/10/2023", "23/10/2023", "23/10/2023","23/10/2023", "23/10/2023", "23/10/2023", "23/10/2023","23/10/2023", "23/10/2023"],
                      ["Debit", "Credit", "Credit", "Debit","Debit", "Credit", "Credit", "Debit","Debit", "Credit"],["1000", "62711", "12901", "921.50","1000", "12901", "62711", "12901","62711", "1000"],["Entertainment", "Food", "Movie", "Food","EMI", "Entertainment", "Rent", "Movie","Entertainment", "Food"]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.viewMonthType.TapLisner(action: {
            self.monthDropdown.show()
        })
        
        self.viewTxnType.TapLisner(action: {
            self.txnTypeDropdown.show()
        })
        
        self.viewAccount.TapLisner(action: {
            self.accountTypeDropdown.show()
        })
    }
    override func onBackButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func setupUI() {
        self.setBackButtonWithoutCart()
        
        self.title = "Assets"
        btnDone.addTarget(self, action: #selector(btnDoneTapped(sender: )), for: .touchUpInside)
        btnSkip.addTarget(self, action: #selector(btnSkipTapped(sender: )), for: .touchUpInside)
        setUpDropDown()
        spreadsheetView.dataSource = self
        spreadsheetView.delegate = self
        
        spreadsheetView.register(HeaderCell.self, forCellWithReuseIdentifier: String(describing: HeaderCell.self))
        spreadsheetView.register(TextCell.self, forCellWithReuseIdentifier: String(describing: TextCell.self))
        spreadsheetView.gridStyle = .none
        spreadsheetView.intercellSpacing = CGSize(width: 0, height: 0)
        spreadsheetView.bounces = false
        spreadsheetView.allowsSelection = false
    }
    @objc func btnDoneTapped(sender : UIButton){
        let vc = MMReportVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func btnSkipTapped(sender : UIButton){
        let destVC = MMGenericPopUpVC()
        destVC.titles = "Please Confirm"
        destVC.subTitle = "Are you sure about skipping this step"
        destVC.btn1text = "No"
        destVC.btn2text = "Yes"
        destVC.modalPresentationStyle = .overFullScreen
        self.present(destVC, animated: true)
    }
    func setUpDropDown(){
        
        let monthList = ["1 Month", "3 Months", "6 Months", "1 Year"]
        
        //        self.tfIncome.isUserInteractionEnabled = false
        self.monthDropdown.anchorView = self.viewMonthType
        self.monthDropdown.dataSource = monthList
        self.monthDropdown.bottomOffset = CGPoint(x: 0, y:(monthDropdown.anchorView?.plainView.bounds.height)! + 5)
        self.monthDropdown.width = self.viewMonthType.bounds.size.width + 20
        self.monthDropdown.direction = .bottom
        self.monthDropdown.cellNib = UINib(nibName: "DropCell", bundle: nil)
        self.monthDropdown.setupCornerRadius(10)
        self.monthDropdown.cellHeight = 30
        self.monthDropdown.customCellConfiguration = { index, title, cell in
            guard let cell = cell as? DropCell else{
                return
            }
            let item = monthList[index]
            cell.lbl.text = item
            cell.lbl.textColor = UIColor(hex: "#4B5675")
            cell.lbl.font = UIFont(name: "RedHatText-Medium", size: 12)
            cell.backgroundColor = .white
        }
        self.monthDropdown.selectionAction = { [self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.lblMonth.text = item
            self.monthDropdown.hide()
            self.view.endEditing(true)
        }
        let txnTypeList = ["All", "Debit", "Credit"]
        
        //        self.tfIncome.isUserInteractionEnabled = false
        self.txnTypeDropdown.anchorView = self.viewTxnType
        self.txnTypeDropdown.dataSource = txnTypeList
        self.txnTypeDropdown.width = self.viewTxnType.bounds.size.width - 10
        self.txnTypeDropdown.bottomOffset = CGPoint(x: 0, y:(txnTypeDropdown.anchorView?.plainView.bounds.height)! + 5)
        self.txnTypeDropdown.direction = .bottom
        self.txnTypeDropdown.cellNib = UINib(nibName: "DropCell", bundle: nil)
        self.txnTypeDropdown.setupCornerRadius(10)
        self.txnTypeDropdown.cellHeight = 30
        self.txnTypeDropdown.customCellConfiguration = { index, title, cell in
            guard let cell = cell as? DropCell else{
                return
            }
            let item = txnTypeList[index]
            cell.lbl.text = item
            cell.lbl.textColor = UIColor(hex: "#4B5675")
            cell.lbl.font = UIFont(name: "RedHatText-Medium", size: 12)
            cell.backgroundColor = .white
        }
        
        
        self.txnTypeDropdown.selectionAction = { [self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.txnTypeDropdown.hide()
            self.lblTxnType.text = item
            self.view.endEditing(true)
        }
        
        let accountList = ["AC/NO XXXXXXX84844", "AC/NO XXXXXXX84844", "AC/NO XXXXXXX84844", "AC/NO XXXXXXX84844","AC/NO XXXXXXX84844", "AC/NO XXXXXXX84844"]
        
        //        self.tfIncome.isUserInteractionEnabled = false
        self.accountTypeDropdown.anchorView = self.viewAccount
        self.accountTypeDropdown.dataSource = accountList
        self.accountTypeDropdown.width = 190//self.viewAccount.bounds.size.width - 10
        self.accountTypeDropdown.bottomOffset = CGPoint(x: 0, y:(txnTypeDropdown.anchorView?.plainView.bounds.height)! + 5)
        self.accountTypeDropdown.direction = .bottom
        self.accountTypeDropdown.cellNib = UINib(nibName: "DropCell", bundle: nil)
        self.accountTypeDropdown.setupCornerRadius(10)
        self.accountTypeDropdown.cellHeight = 30
        self.accountTypeDropdown.customCellConfiguration = { index, title, cell in
            guard let cell = cell as? DropCell else{
                return
            }
            let item = accountList[index]
            cell.lbl.text = item
            cell.lbl.textColor = UIColor(hex: "#4B5675")
            cell.lbl.font = UIFont(name: "RedHatText-Medium", size: 12)
            cell.backgroundColor = .white
        }
        
        self.accountTypeDropdown.selectionAction = { [self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.accountTypeDropdown.hide()
            self.lblAccount.text = item
            self.view.endEditing(true)
        }
        
    }
}
extension MMTxnVC : SpreadsheetViewDataSource {
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return header.count
    }
    
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return txnDetails[0].count + 1
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        return column == 0 ? 160 : 180
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        return 40
    }
    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }
    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        if case 0 = indexPath.row {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: HeaderCell.self), for: indexPath) as! HeaderCell
            cell.label.text = header[indexPath.column]
            if (indexPath.section) == 0{
                cell.backgroundColor = UIColor(hex: "#F1F1F2")
                cell.label.textAlignment = .center
            }else{
                cell.backgroundColor = .white
                cell.label.textAlignment = .left
            }
            return cell
        } else {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: TextCell.self), for: indexPath) as! TextCell
            if (indexPath.section) == 0{
                cell.backgroundColor = UIColor(hex: "#F1F1F2")
                cell.label.textAlignment = .center
            }else{
                cell.backgroundColor = .white
                cell.label.textAlignment = .left
            }
            cell.label.text = txnDetails[indexPath.section][indexPath.row - 1]
            return cell
        }
    }
}
extension MMTxnVC : SpreadsheetViewDelegate{
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, didSelectItemAt indexPath: IndexPath) {
        spreadsheetView.deselectItem(at: indexPath, animated: true)
    }
}
